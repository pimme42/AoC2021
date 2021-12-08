import 'package:y2021/y2021.dart';

void main(List<String>? argv) {
  String path = "./bin/08/";
  String fileName = path + "input";
  //fileName = path + "testInput";

  List<String> content = readFileAsLines(fileName);

  int counter = 0;

  for (String line in content) {
    if (line.isNotEmpty) {
      List<String> parts = line.split("|");
      List<String> outputs = parts[1].trim().split(" ");
      counter += outputs
          .where((str) => (str.length == 2 ||
              str.length == 3 ||
              str.length == 4 ||
              str.length == 7))
          .length;
      print(outputs);
    }
  }
  print(counter);

  // 381
}
