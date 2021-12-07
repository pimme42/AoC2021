import 'package:y2021/y2021.dart';

void main(List<String>? argv) {
  String path = "./bin/07/";
  String fileName = path + "input";
  //fileName = path + "testInput";

  List<int> content = readFileAsIntLines(fileName, separator: ",");
  content.sort();

  int sum = content.reduce((value, element) => value + element);

  print(sum);
  print(sum / content.length);
  int mean = (sum / content.length).floor();
  print(mean);

  int cost = 0;
  for (int number in content) {
    for (int i = 0; i < (number - mean).abs(); i++) {
      cost += (i + 1);
    }
  }
  print(cost);
}
