import 'package:y2021/y2021.dart';

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

//  print(binary);

  print("Svar: ${readPacket(binary)}");
}

int readPacket(String packet) {
  int ret = -1;
  int version = int.parse(packet.substring(start, start + 3), radix: 2);
  int typeId = int.parse(packet.substring(start + 3, start + 6), radix: 2);
  start += 6;

//  print("Version: $version");
//  print("TypeId: $typeId");

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

//    print("Literal: ${int.parse(literal, radix: 2)}");
    return int.parse(literal, radix: 2);
  } else {
    String lengthTypeId = packet.substring(start, start + 1);
    start++;

    int bitLength = 0;

//    print("LengthTypeId $lengthTypeId");

    if (lengthTypeId == "0") {
      bitLength = 15;
    } else if (lengthTypeId == "1") {
      bitLength = 11;
    } else {
      print("ERROR!!!");
    }
    int L = int.parse(packet.substring(start, start + bitLength), radix: 2);
    start += bitLength;
//    print("L: $L");

    List<int> subPackages = [];

    if (lengthTypeId == "0") {
      int newStart;
      int end = start + L;
      while (start < end) {
        subPackages.add(readPacket(packet));
      }
    } else if (lengthTypeId == "1") {
      for (int i = 0; i < L; i++) {
        subPackages.add(readPacket(packet));
      }
    } else {
      print("ERROR!!!");
    }

    return reduce(subPackages, typeId);
  }
}

int reduce(List<int> values, int typeId) {
  switch (typeId) {
    case 0:
      return values.reduce((value, element) => value + element);
    case 1:
      return values.reduce((value, element) => value * element);
    case 2:
      return values
          .reduce((value, element) => element < value ? element : value);
    case 3:
      return values
          .reduce((value, element) => element > value ? element : value);
    case 5:
      return values[0] > values[1] ? 1 : 0;
    case 6:
      return values[0] < values[1] ? 1 : 0;
    case 7:
      return values[0] == values[1] ? 1 : 0;
  }
  return 0;
}
