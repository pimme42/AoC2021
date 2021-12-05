import 'dart:math';

import 'package:y2021/y2021.dart';

void main(List<String>? argv) {
  String path = "./bin/05/";
  String fileName = path + "input";
  //fileName = path + "testInput";

  List<String> content = readFileAsLines(fileName);

  Diagram diagram = Diagram(1000);

  for (var line in content) {
    if (line.isNotEmpty) {
      List<String> parts = line.split("->");
      List<String> start = parts[0].trim().split(",");
      List<String> end = parts[1].trim().split(",");
      int startX = int.parse(start[0]);
      int startY = int.parse(start[1]);
      int endX = int.parse(end[0]);
      int endY = int.parse(end[1]);
      if (startX == endX) {
        // Iterate Y
        for (int y = min(startY, endY); y <= max(startY, endY); y++) {
          diagram.addHit(startX, y);
        }
      }
      if (startY == endY) {
        // Iterate Y
        for (int x = min(startX, endX); x <= max(startX, endX); x++) {
          diagram.addHit(x, startY);
        }
      }
    }
  }
  print(diagram.sum);

  // 5084
}

class Diagram {
  List<List<int>> diagram;
  int sum;

  Diagram(int size)
      : sum = 0,
        diagram = List.generate(size, (index) => List.filled(size, 0));

  void addHit(int x, int y) {
    diagram[y][x]++;
    if (diagram[y][x] == 2) {
      sum++;
    }
  }

  String toString() {
    String ret = "";
    for (var y in diagram) {
      for (var x in y) {
        if (x == 0) {
          ret += ".";
        } else {
          ret += x.toString();
        }
      }
      ret += "\n";
    }
    return ret;
  }
}
