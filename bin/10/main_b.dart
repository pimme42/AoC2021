import 'package:y2021/y2021.dart';

Map<String, int> points = {
  ")": 1,
  "]": 2,
  "}": 3,
  ">": 4,
};

List<String> open = ["(", "[", "{", "<"];

void main(List<String>? argv) {
  String path = "./bin/10/";
  String fileName = path + "input";
  //fileName = path + "testInput";

//  String content = readFile(fileName);
  List<String> content = readFileAsLines(fileName);
//  List<int> content = readFileAsIntLines(fileName);

  List<String> filteredList = [];

  for (var line in content) {
    String c = checkCorrupt(line);
    if (!points.keys.contains(c)) {
      filteredList.add(line);
    }
  }

  List<int> scores = [];
  for (var line in filteredList) {
    scores.add(checkMissing(line));
  }
  print(scores);
  print(scores..sort());
  print((scores..sort())[scores.length ~/ 2]);

  // 1118976874
}

String checkCorrupt(String line) {
  String ret = "";
  Stack<String> stack = Stack();
  for (int i = 0; i < line.length; i++) {
    if (open.contains(line[i])) {
      stack.push(line[i]);
    } else if (points.keys.contains(line[i])) {
      String pop = stack.pop();
      if (!checkOpenClose(pop, line[i])) {
        return line[i];
      }
    }
  }
  return ret;
}

int checkMissing(String line) {
  int ret = 0;
  Stack<String> stack = Stack();
  for (int i = 0; i < line.length; i++) {
    if (open.contains(line[i])) {
      stack.push(line[i]);
    } else if (points.keys.contains(line[i])) {
      stack.pop();
    }
  }
  while (stack.canPop()) {
    ret = ret * 5 + points[findMatch(stack.pop())]!;
  }
  return ret;
}

bool checkOpenClose(String open, String close) {
  switch (open) {
    case "(":
      return close == ")";
    case "[":
      return close == "]";
    case "{":
      return close == "}";
    case "<":
      return close == ">";
  }
  return false;
}

String findMatch(String open) {
  switch (open) {
    case "(":
      return ")";
    case "[":
      return "]";
    case "{":
      return "}";
    case "<":
      return ">";
  }
  return "";
}
