import 'dart:math';

import 'package:y2021/y2021.dart';

void main(List<String>? argv) {
  String path = "./bin/03/";
  String fileName = path + "input";
//  fileName = path + "testInput";
  List<String> content = readFileAsLines(fileName);

  List<int> ones = List.generate(content[0].length, (index) => index);
  List<int> zeros = List.generate(content[0].length, (index) => index);

  for (String line in content) {
    for (int i = 0; i < line.length; ++i) {
      switch (line[i]) {
        case "0":
          zeros[i]++;
          break;
        case "1":
          ones[i]++;
          break;
      }
    }
  }

  int gamma = 0;
  int epsilon = 0;

  for (int i = 0; i < ones.length; ++i) {
    if (ones[i] > zeros[i]) {
      gamma += pow(2, ones.length - i - 1).toInt();
    } else if (zeros[i] > ones[i]) {
      epsilon += pow(2, ones.length - i - 1).toInt();
    }
  }

  print(gamma);
  print(epsilon);

  print(gamma * epsilon);
}
