import 'dart:collection';

import 'package:y2021/y2021.dart';

void main(List<String>? argv) {
  String path = "./bin/14/";
  String fileName = path + "input";
//  fileName = path + "testInput";

//  String content = readFile(fileName);
  List<String> content = readFileAsLines(fileName);
//  List<int> content = readFileAsIntLines(fileName);

  LinkedList<Entry> list = LinkedList();

  for (int i = 0; i < content[0].trim().length; i++) {
    list.add(Entry(content[0][i]));
  }

  Map<String, String> rules = {};

  for (int i = 1; i < content.length; i++) {
    if (content[i].trim().isNotEmpty) {
      List<String> parts = content[i].split("->");
      rules[parts[0].trim()] = parts[1].trim();
    }
  }

  for (int i = 0; i < 40; i++) {
    print(i);
    Entry? nextEntry = list.first;
    while (nextEntry != null) {
      String char = nextEntry.value;
      if (nextEntry.next != null) {
        String pair = char + nextEntry.next?.value;
        String? insert = rules[pair];
        if (insert != null) {
          nextEntry.insertAfter(Entry(insert));
          nextEntry = nextEntry.next;
        }
      }
      nextEntry = nextEntry?.next;
    }
  }

  Map<String, int> counter = {};
  Iterator<Entry> it = list.iterator;
  while (it.moveNext()) {
    String char = it.current.value;
    counter[char] = (counter[char] ?? 0) + 1;
  }
  print(counter);

  int max = counter.values
      .reduce((value, element) => value > element ? value : element);

  int min = counter.values
      .reduce((value, element) => value < element ? value : element);

  print(max - min);
  list.clear();
}

class Entry<T> extends LinkedListEntry<Entry> {
  T value;

  Entry(this.value) : super();

  @override
  String toString() {
    return value.toString();
  }
}
