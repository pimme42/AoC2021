import 'package:y2021/y2021.dart';

void main(List<String>? argv) {
  String path = "./bin/06/";
  String fileName = path + "input";
  //fileName = path + "testInput";

  int days = 256;

  String content = readFile(fileName).trim();

  List<int> ages = content.split(",").map((e) => int.parse(e)).toList();

  Map<int, int> school = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0, 8: 0};

  for (var age in ages) {
    school[age] = school[age]! + 1;
  }

  for (int i = 0; i < days; i++) {
    print(school);
    Map<int, int> newSchool = {
      0: 0,
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
      6: 0,
      7: 0,
      8: 0
    };

    for (int n = 0; n < 9; n++) {
      if (n == 0) {
        newSchool[8] = school[0]!;
        newSchool[6] = school[0]!;
      } else {
        newSchool[n - 1] = newSchool[n - 1]! + school[n]!;
      }
    }
    school = newSchool;
  }
  print(school);
  print(school.values.reduce((value, element) => value + element));
}
