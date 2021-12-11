import 'package:y2021/y2021.dart';

Map<String, int> points = {
  ")": 3,
  "]": 57,
  "}": 1197,
  ">": 25137,
};

List<String> open = ["(", "[", "{", "<"];

void main(List<String>? argv) {
  String path = "./bin/10/";
  String fileName = path + "input";
  //fileName = path + "testInput";

//  String content = readFile(fileName);
  List<String> content = readFileAsLines(fileName);
//  List<int> content = readFileAsIntLines(fileName);

  int sum = 0;
  for (var line in content) {
    String c = checkCorrupt(line);
    if (points.keys.contains(c)) {
      sum += points[c]!;
    }
  }
  print(sum);

  // 319233
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
