import 'dart:io';
import 'dart:math';
import 'dart:collection';

bool fileExistsSync(String path) {
  return File(path).existsSync();
}

String readFile(String path) {
  String? contents;
//  if (fileExistsSync(path)) {
  File file = File(path);
  contents = file.readAsStringSync();
//  }
  if (contents != null) {
    return contents;
  } else {
    throw FileSystemException("Couldn't read file", path);
  }
}

List<String> readFileAsLines(String path, {String separator = "\n"}) {
  String content = readFile(path);
  return content.trim().split(separator);
}

List<int> readFileAsIntLines(String path, {String separator = "\n"}) {
  String content = readFile(path);
  return content.trim().split(separator).map((element) {
    return int.tryParse(element)!;
  }).toList();
}

int binaryToInt(String binary) {
  int res = 0;
  for (int i = 0; i < binary.length; ++i) {
    int pos = binary.length - i - 1;
    if (binary[pos] == "1") {
      res += pow(2, i).toInt();
    }
  }
  return res;
}

class Stack<T> {
  final _stack = Queue<T>();

  int get length => _stack.length;

  bool canPop() => _stack.isNotEmpty;

  void clearStack() {
    while (_stack.isNotEmpty) {
      _stack.removeLast();
    }
  }

  void push(T element) {
    _stack.addLast(element);
  }

  T pop() {
    T lastElement = _stack.last;
    _stack.removeLast();
    return lastElement;
  }

  T peak() => _stack.last;

  String toString() => _stack.toString();
}
