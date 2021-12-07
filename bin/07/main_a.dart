import 'package:y2021/y2021.dart';

void main(List<String>? argv) {
  String path = "./bin/07/";
  String fileName = path + "input";
  //fileName = path + "testInput";

  List<int> content = readFileAsIntLines(fileName, separator: ",");
  content.sort();

  int middle = (content.length / 2).floor();
  double median;
  if (content.length % 2 == 1) {
    median = content[middle].toDouble();
  } else {
    median = (content[middle] + content[middle - 1]) / 2;
  }
  print(median);

  int cost = 0;
  for (int number in content) {
    cost += (number - median.round()).abs();
  }
  print(cost);

  // 339321
}
