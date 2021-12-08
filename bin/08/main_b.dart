import 'package:y2021/y2021.dart';

void main(List<String>? argv) {
  String path = "./bin/08/";
  String fileName = path + "input";
//  fileName = path + "testInput";

  int sum = 0;

  List<String> content = readFileAsLines(fileName);

  Map<int, List<int>> numberLengts = {
    2: [1],
    3: [7],
    4: [4],
    5: [2, 3, 5],
    6: [0, 6, 9],
    7: [8],
  };

  for (String line in content) {
    if (line.isNotEmpty) {
      List<String> parts = line.split("|");
      Map<List<int>, List<int>> signalMap = {};
//      Map<String, List<int>> signalMap = {};
      List<String> signals = parts[0].trim().split(" ");

//      print(signals);

      Map<int, List<int>> decode = {};

      for (String signal in signals) {
//        String sortedSignal = sortString(signal);
        List<int> sortedSignal = List.from(signal.codeUnits)..sort();
        signalMap[sortedSignal] = numberLengts[sortedSignal.length]!;
        if (sortedSignal.length == 2) {
          decode[1] = sortedSignal;
        } else if (sortedSignal.length == 3) {
          decode[7] = sortedSignal;
        } else if (sortedSignal.length == 4) {
          decode[4] = sortedSignal;
        } else if (sortedSignal.length == 7) {
          decode[8] = sortedSignal;
        }
      }
//      print(signalMap);
      signalMap.remove(decode[1]);
      signalMap.remove(decode[4]);
      signalMap.remove(decode[7]);
      signalMap.remove(decode[8]);

      // 3 är den enda 5-tecken siffra som innehåller samma signaler som 1
      decode[3] = signalMap.keys.singleWhere((element) =>
          element.length == 5 &&
          element.contains(decode[1]![0]) &&
          element.contains(decode[1]![1]));
      signalMap.remove(decode[3]);

      // 6 är den enda 6-tecken siffra som inte innehåller samma båda signalerna i 1
      decode[6] = signalMap.keys.singleWhere((element) =>
          element.length == 6 &&
          (!element.contains(decode[1]![0]) ||
              !element.contains(decode[1]![1])));
      signalMap.remove(decode[6]);

      // 5 signaler finns även i 6
      decode[5] = signalMap.keys.singleWhere((element) =>
          element.length == 5 &&
          decode[6]!.contains(element[0]) &&
          decode[6]!.contains(element[1]) &&
          decode[6]!.contains(element[2]) &&
          decode[6]!.contains(element[3]) &&
          decode[6]!.contains(element[4]));
      signalMap.remove(decode[5]);

      // 2 är det sista 5-tecken numret
      decode[2] = signalMap.keys.singleWhere((element) => element.length == 5);
      signalMap.remove(decode[2]);

      // 4 signaler finns även i 9
      decode[9] = signalMap.keys.singleWhere((element) =>
          element.length == 6 &&
          element.contains(decode[4]![0]) &&
          element.contains(decode[4]![1]) &&
          element.contains(decode[4]![2]) &&
          element.contains(decode[4]![3]));
      signalMap.remove(decode[9]);

      decode[0] = signalMap.keys.single;
      signalMap.remove(decode[0]);

//      print(signalMap);
//      decode.forEach(
//          (key, value) => print("$key: ${String.fromCharCodes(value)}"));

      Map<String, int> decodeRev = {};
      decode.forEach((key, value) {
        decodeRev[String.fromCharCodes(value)] = key;
      });

      List<String> outputs = parts[1].trim().split(" ");

      String outputValue = "";

      for (int i = 0; i < outputs.length; i++) {
        String signal =
            String.fromCharCodes(List.from(outputs[i].codeUnits)..sort());
        outputValue += decodeRev[signal].toString();
      }

      print(outputValue);
      sum += int.parse(outputValue);
    }
  }
  print(sum);

  // 1023686
}

/*

len     number
2       1
3       7
4       4
5       2, 3, 5
6       0, 6, 9
7       8


  0:      1:      2:      3:      4:
 aaaa    ....    aaaa    aaaa    ....
b    c  .    c  .    c  .    c  b    c
b    c  .    c  .    c  .    c  b    c
 ....    ....    dddd    dddd    dddd
e    f  .    f  e    .  .    f  .    f
e    f  .    f  e    .  .    f  .    f
 gggg    ....    gggg    gggg    ....

  5:      6:      7:      8:      9:
 aaaa    aaaa    aaaa    aaaa    aaaa
b    .  b    .  .    c  b    c  b    c
b    .  b    .  .    c  b    c  b    c
 dddd    dddd    ....    dddd    dddd
.    f  e    f  .    f  e    f  .    f
.    f  e    f  .    f  e    f  .    f
 gggg    gggg    ....    gggg    gggg

*/