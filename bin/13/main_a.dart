import 'dart:math';

import 'package:y2021/y2021.dart';

void main(List<String>? argv) {
  String path = "./bin/13/";
  String fileName = path + "input";
//  fileName = path + "testInput";

//  String content = readFile(fileName);
  List<String> content = readFileAsLines(fileName);
//  List<int> content = readFileAsIntLines(fileName);

  int maxX = 0;
  int maxY = 0;
  for (var line in content) {
    List<String> parts = line.split(",");
    if (parts.length == 2) {
      int x = int.parse(parts[0]);
      int y = int.parse(parts[1]);
      maxX = max(maxX, x);
      maxY = max(maxY, y);
    }
  }

  print(maxX);
  print(maxY);

  Grid grid = Grid(maxX + 1, maxY + 1);

  for (var line in content) {
    List<String> parts = line.split(",");
    if (parts.length == 2) {
      int x = int.parse(parts[0]);
      int y = int.parse(parts[1]);
      grid.setDot(x, y);
    } else if (line.isNotEmpty) {
      parts = line.split("=");

      int foldLine = int.parse(parts[1]);
      grid.foldLines
          .add(FoldLine(parts[0].substring(parts[0].length - 1), foldLine));
    }
  }

//  print(grid);

  grid = grid.foldFirst();
//  print(grid);
  print("Count: ${grid.count}");

  // 810
}

class Grid {
  List<List<bool>> grid;
  List<FoldLine> foldLines;

  Grid(int x, int y)
      : foldLines = [],
        grid = List.generate(y, (index) => List.generate(x, (index) => false));

  void setDot(int x, int y) => grid[y][x] = true;

  Grid foldFirst() {
    print(foldLines.first.axis);
    print(foldLines.first.pos);
    Grid newGrid = Grid(0, 0);
    if (foldLines.first.axis == "x") {
      newGrid = Grid(foldLines.first.pos, grid.length);
      for (int y = 0; y < grid.length; y++) {
        int len = grid[y].length - 1;
        for (int x = 0; x < foldLines.first.pos; x++) {
          try {
            newGrid.grid[y][x] =
                grid[y][x] || grid[y][2 * foldLines.first.pos - x];
          } catch (e) {}
        }
      }
    } else if (foldLines.first.axis == "y") {
      newGrid = Grid(grid[0].length, foldLines.first.pos);
      int len = grid.length - 1;
      for (int y = 0; y < foldLines.first.pos; y++) {
        for (int x = 0; x < grid[y].length; x++) {
          try {
            print(":::::::::::::::::");
            print(y);
            print(foldLines.first.pos);
            print(grid.length);
            print(2 * foldLines.first.pos - y);
            newGrid.grid[y][x] =
                grid[y][x] || grid[2 * foldLines.first.pos - y][x];
          } catch (e) {}
        }
      }
    }
    return newGrid;
  }

  int get count {
    int count = 0;
    for (var line in grid) {
      count += line.where((element) => element).length;
    }
    return count;
  }

  String toString() {
    String ret = "$foldLines\n";
    for (int y = 0; y < grid.length; y++) {
      List<bool> line = grid[y];
      for (int x = 0; x < line.length; x++) {
        bool pos = line[x];
        if (foldLines.isNotEmpty &&
            foldLines.first.axis == "x" &&
            foldLines.first.pos == x) {
          ret += "|";
        } else if (foldLines.isNotEmpty &&
            foldLines.first.axis == "y" &&
            foldLines.first.pos == y) {
          ret += "-";
        } else {
          ret += pos ? "#" : ".";
        }
      }
      ret += "\n";
    }
    return ret;
  }
}

class FoldLine {
  String axis;
  int pos;

  FoldLine(this.axis, this.pos);

  String toString() {
    return "$axis:$pos";
  }
}
