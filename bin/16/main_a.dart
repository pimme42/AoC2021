import 'package:y2021/y2021.dart';

int sumVersions = 0;
int start = 0;

void main(List<String>? argv) {
  String path = "./bin/16/";
  String fileName = path + "input";
//  fileName = path + "testInput";

  String content = readFile(fileName).trim();
//  List<String> content = readFileAsLines(fileName);
//  List<int> content = readFileAsIntLines(fileName);

  String binary = "";
  if (int.tryParse(content, radix: 2)?.toRadixString(2) != content) {
    for (int i = 0; i < content.length; i++) {
      binary +=
          int.parse(content[i], radix: 16).toRadixString(2).padLeft(4, "0");
    }
  } else {
    binary = content;
  }

  print(binary);

  readPacket(binary);

  print("SumVersions: ${sumVersions}");

  // 940
}

void readPacket(String packet) {
  int ret = -1;
  int version = int.parse(packet.substring(start, start + 3), radix: 2);
  int typeId = int.parse(packet.substring(start + 3, start + 6), radix: 2);
  start += 6;

  print("Version: $version");
  sumVersions += version;
  print("TypeId: $typeId");

  if (typeId == 4) {
    String literal = "";
    while (true) {
      String first = packet.substring(start, start + 1);
      literal += packet.substring(start + 1, start + 5);
      start += 5;
      if (first == "0") {
        break;
      }
    }

    print("Literal: ${int.parse(literal, radix: 2)}");
    ret = start;
  } else {
    String lengthTypeId = packet.substring(start, start + 1);
    start++;

    int bitLength = 0;

    print("LengthTypeId $lengthTypeId}");

    if (lengthTypeId == "0") {
      bitLength = 15;
    } else if (lengthTypeId == "1") {
      bitLength = 11;
    } else {
      print("ERROR!!!");
    }
    int L = int.parse(packet.substring(start, start + bitLength), radix: 2);
    start += bitLength;
    print("I: $L");

    if (lengthTypeId == "0") {
      int newStart;
      int end = start + L;
      print("End: $end");
      while (start < end) {
        print("Start $start");
        readPacket(packet);
      }
    } else if (lengthTypeId == "1") {
      for (int i = 0; i < L; i++) {
        readPacket(packet);
      }
    } else {
      print("ERROR!!!");
    }
  }
}
