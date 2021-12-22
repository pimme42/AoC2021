import 'package:y2021/y2021.dart';

void main(List<String>? argv) {
  String path = "./bin/22/";
  String fileName = path + "input";
  // fileName = path + "testInput";
  // fileName = path + "testInput2";

  // String content = readFile(fileName);
  List<String> content = readFileAsLines(fileName);
  // List<int> content = readFileAsIntLines(fileName);

  Map<int, Map<int, Map<int, bool>>> grid = {};

  for (var line in content) {
    Cube cube = readLine(line.trim());
    print(cube);
    for (int x = cube.fromX; x <= cube.toX; x++) {
      for (int y = cube.fromY; y <= cube.toY; y++) {
        for (int z = cube.fromZ; z <= cube.toZ; z++) {
          if (x.abs() <= 50 && y.abs() <= 50 && z.abs() <= 50) {
            if (grid[x] == null) {
              grid[x] = {};
            }
            if (grid[x]![y] == null) {
              grid[x]![y] = {};
            }
            grid[x]![y]![z] = cube.on;
          }
        }
      }
    }
  }
  int counter = 0;
  for (int x = -50; x <= 50; x++) {
    for (int y = -50; y <= 50; y++) {
      for (int z = -50; z <= 50; z++) {
        if (grid[x]?[y]?[z] != null && grid[x]![y]![z]!) {
          counter++;
        }
      }
    }
  }
  print(counter);
}

Cube readLine(String line) {
  List<String> parts = line.split(" ");
  bool on = true;
  if (parts[0] == "off") {
    on = false;
  }
  Cube ret = Cube(on);
  parts = parts[1].split(",");
  for (var part in parts) {
    List<String> newParts = part.split("=");
    String axis = newParts[0];
    newParts = newParts[1].split("..");
    if (axis == "x") {
      int x0 = int.parse(newParts[0]);
      int x1 = int.parse(newParts[1]);
      ret.fromX = x0;
      ret.toX = x1;

      if ((x0 < -50 && x1 < -50) || (x0 > 50 && x1 > 50)) {
        ret.fromX = -100;
        ret.toX = -100;
      } else if (x0 < -50 && x1 >= -50) {
        ret.fromX = -50;
        if (x1 > 50) {
          ret.toX = 50;
        }
      } else if (x0 <= 50 && x1 > 50) {
        ret.toX = 50;
        if (x0 < -50) {
          ret.fromX = -50;
        }
      }
    } else if (axis == "y") {
      int y0 = int.parse(newParts[0]);
      int y1 = int.parse(newParts[1]);
      ret.fromY = y0;
      ret.toY = y1;

      if ((y0 < -50 && y1 < -50) || (y0 > 50 && y1 > 50)) {
        ret.fromY = -100;
        ret.toY = -100;
      } else if (y0 < -50 && y1 >= -50) {
        ret.fromY = -50;
        if (y1 > 50) {
          ret.toY = 50;
        }
      } else if (y0 <= 50 && y1 > 50) {
        ret.toY = 50;
        if (y0 < -50) {
          ret.fromY = -50;
        }
      }
    } else if (axis == "z") {
      int z0 = int.parse(newParts[0]);
      int z1 = int.parse(newParts[1]);
      ret.fromZ = z0;
      ret.toZ = z1;

      if ((z0 < -50 && z1 < -50) || (z0 > 50 && z1 > 50)) {
        ret.fromZ = -100;
        ret.toZ = -100;
      } else if (z0 < -50 && z1 >= -50) {
        ret.fromZ = -50;
        if (z1 > 50) {
          ret.toZ = 50;
        }
      } else if (z0 <= 50 && z1 > 50) {
        ret.toZ = 50;
        if (z0 < -50) {
          ret.fromZ = -50;
        }
      }
    }
  }
  return ret;
}

class Cube {
  bool on;
  late int fromX;
  late int toX;
  late int fromY;
  late int toY;
  late int fromZ;
  late int toZ;
  Cube(this.on);

  String toString() => "$on($fromX, $toX)($fromY, $toY)($fromZ, $toZ)";
}
