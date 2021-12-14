import 'package:y2021/y2021.dart';

void main(List<String>? argv) {
  String path = "./bin/14/";
  String fileName = path + "input";
//  fileName = path + "testInput";

//  String content = readFile(fileName);
  List<String> content = readFileAsLines(fileName);
//  List<int> content = readFileAsIntLines(fileName);

  Map<String, int> pairs = {};

  for (int i = 0; i < content[0].trim().length - 1; i++) {
    String pair = content[0][i] + content[0][i + 1];
    pairs[pair] = (pairs[pair] ?? 0) + 1;
  }

  Map<String, String> rules = {};

  for (int i = 1; i < content.length; i++) {
    if (content[i].trim().isNotEmpty) {
      List<String> parts = content[i].split("->");
      rules[parts[0].trim()] = parts[1].trim();
    }
  }

  for (int i = 0; i < 40; i++) {
    Map<String, int> newPairs = {};
    for (String pair in pairs.keys) {
      String? insert = rules[pair];
      if (insert != null) {
        String pair1 = pair.substring(0, 1) + insert;
        String pair2 = insert + pair.substring(1, 2);
        int num1 = newPairs[pair1] ?? 0;
        int num2 = newPairs[pair2] ?? 0;
        newPairs[pair1] = num1 + pairs[pair]!;
        newPairs[pair2] = num2 + pairs[pair]!;
      } else {
        print("No rule!");
        newPairs[pair] = 1;
      }
    }
    pairs = newPairs;
  }

  Map<String, int> counter = {};
  for (String pair in pairs.keys) {
    String char1 = pair.substring(0, 1);
    String char2 = pair.substring(1, 2);
    counter[char1] = (counter[char1] ?? 0) + pairs[pair]!;
    counter[char2] = (counter[char2] ?? 0) + pairs[pair]!;
  }
  for (String char in counter.keys) {
    counter[char] = (counter[char]! / 2).ceil();
  }
  print(counter);

  int max = counter.values
      .reduce((value, element) => value > element ? value : element);

  int min = counter.values
      .reduce((value, element) => value < element ? value : element);

  print(max - min);

// 2276644000111
}
