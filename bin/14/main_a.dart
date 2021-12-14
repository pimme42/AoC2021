import 'dart:collection';

import 'package:y2021/y2021.dart';

void main(List<String>? argv) {
  String path = "./bin/14/";
  String fileName = path + "input";
//  fileName = path + "testInput";

//  String content = readFile(fileName);
  List<String> content = readFileAsLines(fileName);
//  List<int> content = readFileAsIntLines(fileName);

  Queue<String> queue = Queue();

  for (int i = 0; i < content[0].trim().length; i++) {
    queue.addLast(content[0][i]);
  }

  Map<String, String> rules = {};

  for (int i = 1; i < content.length; i++) {
    if (content[i].trim().isNotEmpty) {
      List<String> parts = content[i].split("->");
      rules[parts[0].trim()] = parts[1].trim();
    }
  }

  for (int i = 0; i < 40; i++) {
    Queue<String> newQueue = Queue();

    while (queue.isNotEmpty) {
      String char = queue.removeFirst();
      newQueue.addLast(char);
      if (queue.isNotEmpty) {
        String pair = char + queue.first;
        String? insert = rules[pair];
        if (insert != null) {
          newQueue.addLast(insert);
        }
      }
    }
    queue = newQueue;
  }

  Map<String, int> counter = {};
  while (queue.isNotEmpty) {
    String char = queue.removeLast();
    counter[char] = (counter[char] ?? 0) + 1;
  }
  print(counter);

  int max = counter.values
      .reduce((value, element) => value > element ? value : element);

  int min = counter.values
      .reduce((value, element) => value < element ? value : element);

  print(max - min);

  // a 2003
  // b out of memory
}
