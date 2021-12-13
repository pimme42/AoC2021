import 'package:y2021/y2021.dart';

void main(List<String>? argv) {
  String path = "./bin/12/";
  String fileName = path + "input";
//  fileName = path + "testInput3";

//  String content = readFile(fileName);
  List<String> content = readFileAsLines(fileName);
//  List<int> content = readFileAsIntLines(fileName);

  Map<String, Node> nodes = {};

  List<String> paths = [];

  for (var line in content) {
    List<String> parts = line.split("-");
    String first = parts[0];
    String second = parts[1];
    if (nodes[first] == null) {
      nodes[first] = Node(first, first == first.toUpperCase());
    }
    if (nodes[second] == null) {
      nodes[second] = Node(second, second == second.toUpperCase());
    }
    nodes[first]!.addNeighbour(nodes[second]!);
    nodes[second]!.addNeighbour(nodes[first]!);
  }

  print(nodes.values);
  findPaths(paths, nodes["start"]!);
  paths = paths.where((element) => element.contains("end")).toList();
  print(paths);
  print(paths.length);

  // 4549
}

List<String> findPaths(List<String> paths, Node start) {
  if (paths.isEmpty) {
    paths.add("");
  }
  paths.last += start.name;
  int index = paths.length - 1;
//  print(paths);
  //  print("start: ${start.name}");
  if (start.name != "end") {
    for (Node node in start.neighbours) {
      paths.add(paths[index]);
//      print(paths[index]);
      if (node.name == node.name.toUpperCase() ||
          !paths.last.contains(node.name)) {
//        print("From ${start.name} -> To ${node.name}");
        (findPaths(paths, node));
      }
    }
  }

  return paths;
}

class Node {
  final String name;
  final bool large;
  bool visited;
  List<Node> neighbours = [];

  Node(this.name, this.large, [this.visited = false]);

  bool get canVisit => large == true || (large == false && visited == false);

  void get visit => visited = true;

  void addNeighbour(Node neighbour) {
    neighbours.add(neighbour);
  }

  String toString() {
    List<String> neigh = neighbours.map((e) => e.name).toList();
    return "$name: $visited ($neigh)";
  }
}
