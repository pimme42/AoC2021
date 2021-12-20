import 'package:y2021/y2021.dart';

String infinityColor = "";

void main(List<String>? argv) {
  String path = "./bin/20/";
  String fileName = path + "input";
  // fileName = path + "testInput";

  // String content = readFile(fileName);
  List<String> content = readFileAsLines(fileName);
//  List<int> content = readFileAsIntLines(fileName);

  String key = content[0].trim();
  print(key);
  infinityColor = ".";

  Map<int, Map<int, String>> image = {};

  int minX = 0;
  int maxX = 0;
  int minY = 0;
  int maxY = 0;

  int y = 0;
  for (int i = 1; i < content.length; i++) {
    if (image[y] == null) {
      image[y] = {};
    }
    String line = content[i].trim();
    if (line.isNotEmpty) {
      for (int x = 0; x < line.length; x++) {
        image[y]![x] = line[x];
      }
      maxX = line.length;
      y++;
    }
  }
  maxY = y;

  print("Start");
  printImage(image);
  /*
  a:
  for (int i = 0; i < 2; i++) {
  */
  /* b */
  for (int i = 0; i < 50; i++) {
    print(":::::: $i ::::::::::");
    Map<int, Map<int, String>> newImage = {};

    for (int y = minY - (i + 1); y < maxY + (i + 1); y++) {
      if (newImage[y] == null) {
        newImage[y] = {};
      }
      for (int x = minX - (i + 1); x < maxX + (i + 1); x++) {
        // print(
        // "$x,$y: ${getKeyIndex(image, x, y)}  ${key[getKeyIndex(image, x, y)]}");
        newImage[y]![x] = key[getKeyIndex(image, x, y)];
      }
    }

    image = newImage;
    print("result");
    printImage(image);
    if (infinityColor == ".") {
      infinityColor = key[0];
    } else {
      infinityColor = key[511];
    }
  }
  int count = 0;

  for (int y in image.keys) {
    for (int x in image[y]!.keys) {
      if (image[y]![x] == "#") {
        count++;
      }
    }
  }
  print(count);

  // a: 5347
  // b: 17172
}

int getKeyIndex(Map<int, Map<int, String>> image, int x, int y) {
  // print("$x :: $y");
  String code = "";
  for (int dy = -1; dy <= 1; dy++) {
    for (int dx = -1; dx <= 1; dx++) {
      if (x == -2 && y == -2) {
        print("${x + dx} ${y + dy} :> ${getPixel(image, x + dx, y + dy)}");
      }
      code += getPixel(image, x + dx, y + dy);
    }
  }
  // print(code);
  code = code.replaceAll(".", "0").replaceAll("#", "1");

  if (x == -2 && y == -2) {
    print(code);
    print(int.parse(code, radix: 2));
  }
  return int.parse(code, radix: 2);
}

String getPixel(Map<int, Map<int, String>> image, int x, int y) {
  if (x == -2 && y == -2) {
    print("Pixel: ${image[y]?[x]} :: $infinityColor");
  }
  return image[y]?[x] ?? infinityColor;
}

void printImage(Map<int, Map<int, String>> image) {
  for (int y in image.keys) {
    if (y < 2) {
      print(
          "${y.toString().padLeft(3, " ")}: ${image[y]?.values.toString().replaceAll(", ", "")} (${image[y]?.length})");
    }
  }
}
