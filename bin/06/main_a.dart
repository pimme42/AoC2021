import 'package:y2021/y2021.dart';

void main(List<String>? argv) {
  String path = "./bin/06/";
  String fileName = path + "input";
  //fileName = path + "testInput";

  // a
//  int days = 80;

  // b
  int days = 256;

  String content = readFile(fileName).trim();

  List<LanternFish> school =
      content.split(",").map((e) => LanternFish(int.parse(e))).toList();
//  print(school);

  int prev = school.length;
  int prevDelta = 0;

  for (int i = 0; i < days; i++) {
    print("Day ${i + 1}");
    int len = school.length;
    for (int n = 0; n < len; n++) {
      LanternFish? newFish = school[n].iterate();
      if (newFish != null) {
        school.add(newFish);
      }
    }
    print(school.length - prev);
    print((school.length - prev) - prevDelta);
    print("----------------------");
    prevDelta = school.length - prev;
  }
//  print(school);
  print(school.length);

  // a: 379414
}

class LanternFish {
  int timer;

  LanternFish([int? initTime]) : timer = initTime ?? 8;

  LanternFish? iterate() {
    if (timer == 0) {
      timer = 6;
      return LanternFish();
    } else {
      timer--;
    }
    return null;
  }

  String toString() => timer.toString();
}
