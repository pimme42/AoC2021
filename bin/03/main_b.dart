import 'dart:math';

import 'package:y2021/y2021.dart';

void main(List<String>? argv) {
  String path = "./bin/03/";
  String fileName = path + "input";
  //fileName = path + "testInput";
  List<String> content = readFileAsLines(fileName);

  String o2Gen = reduceO2Gen(0, content);
//  print(o2Gen);

  String O2Scrub = reduceO2Scrub(0, content);
//  print(O2Scrub);

  print(binaryToInt(o2Gen) * binaryToInt(O2Scrub));

  // 3277956
}

List<String> getMostCommon(List<String> content) {
  List<String> mostCommon = List.generate(content[0].length, (index) => "1");
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

  for (int i = 0; i < ones.length; ++i) {
    if (zeros[i] > ones[i]) {
      mostCommon[i] = "0";
    }
  }

  return mostCommon;
}

String reduceO2Gen(int index, List<String> content) {
  List<String> mostCommon = getMostCommon(content);
  List<String> reducedList = [];
  if (content.isEmpty) {
    return "Empty";
  }
  for (String line in content) {
    if (line.isNotEmpty && line[index] == mostCommon[index]) {
      reducedList.add(line);
    }
  }
  if (reducedList.length == 1) {
    return reducedList.first;
  } else {
    return reduceO2Gen(index + 1, reducedList);
  }
}

String reduceO2Scrub(int index, List<String> content) {
  List<String> mostCommon = getMostCommon(content);
  List<String> reducedList = [];
  if (content.isEmpty) {
    return "Empty";
  }
  for (String line in content) {
    if (line.isNotEmpty && line[index] != mostCommon[index]) {
      reducedList.add(line);
    }
  }
  if (reducedList.length == 1) {
    return reducedList.first;
  } else {
    return reduceO2Scrub(index + 1, reducedList);
  }
}
