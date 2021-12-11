import 'dart:math';
import 'package:collection/collection.dart';
import 'package:y2021/y2021.dart';

void main(List<String>? argv) {
  String path = "./bin/11/";
  String fileName = path + "input";
//  fileName = path + "testInput";

//  String content = readFile(fileName);
  List<String> content = readFileAsLines(fileName);
//  List<int> content = readFileAsIntLines(fileName);

  List<bool> flashed =
      List.generate(content.length * content.length, (index) => false);

  List<bool> resetFlashed() =>
      List.generate(content.length * content.length, (index) => false);

  for (int i = 0; i < 10000; i++) {
    if (countFlashes(
      content,
      resetFlashed(),
    )) {
      print("Step: ${i + 1}");
      break;
    }
  }
}

bool countFlashes(List<String> content, List<bool> flashed) {
  bool ret = false;
  bool changed = true;

  for (int row = 0; row < content.length; row++) {
    for (int col = 0; col < content[row].length; col++) {
      int level = int.parse(content[row][col]);
      level++;
      if (level > 9) {
        content = setChar(content, row, col, "X");
      } else {
        content = setChar(content, row, col, level.toString());
      }
    }
  }

  while (changed) {
    changed = false;

    for (int row = 0; row < content.length; row++) {
      for (int col = 0; col < content[row].length; col++) {
        String char = content[row][col];

        if (char == "X" && !checkFlashed(flashed, row, col)) {
          // flash
          flashed = setFlashed(flashed, row, col);
          content = updateNeighbours(content, flashed, row, col);
          changed = true;
        }
      }
    }
  }

  for (int row = 0; row < content.length; row++) {
    for (int col = 0; col < content[row].length; col++) {
      if (content[row][col] == "X") {
        setChar(content, row, col, "0");
      }
    }
  }

//  print(content.join("").codeUnits.toSet());
  if (content.join("").codeUnits.toSet().length == 1 &&
      content.join("").codeUnits.toSet().first == 48) {
    return true;
  }
  return false;
}

List<String> updateNeighbours(
    List<String> content, List<bool> flashed, int row, int col) {
  content = update(content, flashed, row - 1, col);

  content = update(content, flashed, row - 1, col - 1);

  content = update(content, flashed, row - 1, col + 1);

  content = update(content, flashed, row + 1, col);

  content = update(content, flashed, row + 1, col - 1);

  content = update(content, flashed, row + 1, col + 1);

  content = update(content, flashed, row, col - 1);

  content = update(content, flashed, row, col + 1);

  return content;
}

List<String> update(
    List<String> content, List<bool> flashed, int row, int col) {
  try {
    String char = content[row][col];
    if (char != "X") {
      int level = int.parse(content[row][col]);
      if (!checkFlashed(flashed, row, col)) {
        if (level < 9) {
          setChar(content, row, col, (level + 1).toString());
        } else {
          setChar(content, row, col, "X");
        }
      }
    }
    //content[row] = content[row].replaceRange(col, col + 1, level.toString());
  } catch (e) {}
  return content;
}

List<String> setChar(List<String> content, int row, int col, String c) {
  content[row] = content[row].replaceRange(col, col + 1, c);
  return content;
}

bool checkFlashed(List<bool> flashed, int row, int col) {
  return flashed[row * sqrt(flashed.length).round() + col];
}

List<bool> setFlashed(List<bool> flashed, int row, int col) {
  flashed[row * sqrt(flashed.length).round() + col] = true;
  return flashed;
}
