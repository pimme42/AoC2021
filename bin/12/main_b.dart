import 'package:y2021/y2021.dart';

void main(List<String>? argv) {
  String path = "./bin/12/";
  String fileName = path + "input";
  fileName = path + "testInput";

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

  for (Node node in nodes.values) {
    if (node.name != "start" &&
        node.name != "end" &&
        node.name == node.name.toLowerCase()) {
      nodes.forEach((key, value) {
        value.neighbours = value.neighbours
            .where((element) => !element.name.contains("2"))
            .toList();
      });

      Node newNode = Node(node.name + "2", false)..neighbours = node.neighbours;

      for (Node neighbour in node.neighbours) {
        neighbour.addNeighbour(newNode);
      }

      List<Node> newList = [...List.of(nodes.values), newNode];
      findPaths(paths,
          newList.singleWhere((element) => element.name == "start"), true);
      print(newList);
    }
  }

  print(nodes.values);
//  paths = findPaths(paths, nodes["start"]!);
  paths = paths.where((element) => element.contains("end")).toList();
  print(paths);
  print(paths.length);
}

List<String> findPaths(List<String> paths, Node start, [bool newPath = false]) {
  if (paths.isEmpty || newPath) {
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
