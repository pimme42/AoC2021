import 'package:y2021/y2021.dart';

void main(List<String>? argv) {
  String path = "./bin/04/";
  String fileName = path + "input";
  //fileName = path + "testInput";
  List<String> content = readFileAsLines(fileName);

  List<int> numbers = content[0].split(",").map((e) => int.parse(e)).toList();

  List<BingoBoard> boards = [];

  for (int i = 2; i < content.length; ++i) {
    if ((i - 2) % 6 == 0) {
      boards.add(BingoBoard());
    }
    content[i].split(" ").forEach((element) {
      if (int.tryParse(element) != null) {
        boards.last.addNum(int.parse(element));
      }
    });
  }

  print(boards);

  int? bingo = null;
  for (int number in numbers) {
    for (BingoBoard board in boards) {
      if (bingo == null && board.checkNumber(number)) {
        bingo = number;
        print("Full row!");
        print(number);
        print(board.sumBoard());
        print(number * board.sumBoard());
        break;
      }
    }
  }
  print(bingo);

  // 22680
}

class BingoBoard {
  List<List<BoardNum>> vertical =
      List.generate(5, (index) => List.generate(5, (index) => BoardNum(0)));
  List<List<BoardNum>> horizontal =
      List.generate(5, (index) => List.generate(5, (index) => BoardNum(0)));
  int _x = 0;
  int _y = 0;

  void addNum(int number) {
    BoardNum boardNum = BoardNum(number);
//    print("($_x, $_y)");
    vertical[_x][_y] = boardNum;
    horizontal[_y][_x] = boardNum;
    _x++;
    if (_x >= 5) {
      _x = 0;
      _y++;
    }
  }

  int sumBoard() {
    int sum = 0;
    for (int i = 0; i < vertical.length; ++i) {
      for (int n = 0; n < vertical[i].length; ++n) {
        if (!vertical[i][n].isChecked) {
          sum += vertical[i][n].number;
        }
      }
    }
    return sum;
  }

  bool checkNumber(int number) {
//    print("Num: $number");
    for (int i = 0; i < vertical.length; ++i) {
      for (int n = 0; n < vertical[i].length; ++n) {
        vertical[i][n].checkNum(number);
      }
    }
    for (int i = 0; i < vertical.length; ++i) {
      for (int n = 0; n < vertical[i].length; ++n) {
        bool rowChecked = true;
        bool colChecked = true;
        for (int n = 0; n < vertical[i].length; ++n) {
          if (!vertical[i][n].isChecked) {
            rowChecked = false;
          }
          if (!horizontal[i][n].isChecked) {
            colChecked = false;
          }
        }
/*        print(i);
        print("V: " + vertical[i].toString());
        print("H: " + horizontal[i].toString());
*/
        if (rowChecked || colChecked) {
          //print("Number $number");
          return true;
        }
      }
    }
//    print("-----");
    return false;
  }

  String toString() {
    return "BingoBoard: \nVertical: $vertical\nHorizontal: $horizontal";
  }
}

class BoardNum {
  int number;
  bool isChecked = false;
  BoardNum(this.number);

  void checkNum(int checkNumber) {
    if (number == checkNumber) {
      isChecked = true;
    }
  }

  String toString() {
    return "$number (${isChecked ? "C" : " "})";
  }
}
