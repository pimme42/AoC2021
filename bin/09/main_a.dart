import 'package:y2021/y2021.dart';

void main(List<String>? argv) {
  String path = "./bin/09/";
  String fileName = path + "input";
//  fileName = path + "testInput";

  //String content = readFile(fileName);
  List<String> content = readFileAsLines(fileName);
//  List<int> content = readFileAsIntLines(fileName);

  int counter = 0;

  for (int y = 0; y < content.length; y++) {
    if (content[y].isNotEmpty) {
      content[y] = content[y].trim();
      for (int x = 0; x < content[y].trim().length; x++) {
        bool isSmaller = true;
        int left = x - 1;
        int right = x + 1;
        int over = y - 1;
        int under = y + 1;
        int number = p(content[y][x]);
        if (left >= 0 && number >= p(content[y][left])) {
          isSmaller = false;
        } else if (right < content[y].length &&
            number >= p(content[y][right])) {
          isSmaller = false;
        } else if (over >= 0 && number >= p(content[over][x])) {
          isSmaller = false;
        } else if (under < content.length && number >= p(content[under][x])) {
          isSmaller = false;
        }
        if (isSmaller) {
          counter += number + 1;
        }
      }
    }
  }

  print(counter);
}

int p(String c) => int.parse(c);
