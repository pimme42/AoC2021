import 'package:y2021/y2021.dart';

void main(List<String>? argv) {
  String path = "./bin/21/";
  String fileName = path + "input";
  // fileName = path + "testInput";

  // String content = readFile(fileName);
  // List<String> content = readFileAsLines(fileName);
  List<int> content = readFileAsIntLines(fileName);
  List<Player> players = [];
  for (int startPos in content) {
    players.add(Player(startPos));
  }
  print(players);

  bool run = true;
  while (run) {
    for (int i = 0; i < players.length && run; i++) {
      run = !players[i].move();
    }
  }
  print(players);
  print(DeterministicDice().numRolls);
  print(players[0].score * DeterministicDice().numRolls);

  // 1004670
}

class DeterministicDice {
  static final DeterministicDice _instance = DeterministicDice._(0);
  int _face;
  int _rolls;
  DeterministicDice._([this._face = 0]) : _rolls = 0;

  factory DeterministicDice() => _instance;

  int get roll {
    _rolls++;
    if (_face == 100) {
      _face = 0;
    }
    _face++;
    return _face;
  }

  int get numRolls => _rolls;
}

class Player {
  int pos;
  int score;
  DeterministicDice _dice;
  Player(this.pos)
      : score = 0,
        _dice = DeterministicDice();

  bool move() {
    pos = (pos + _dice.roll + _dice.roll + _dice.roll) % 10;
    score += pos == 0 ? 10 : pos;
    return score >= 1000;
  }

  String toString() {
    return "@$pos :: $score";
  }
}
