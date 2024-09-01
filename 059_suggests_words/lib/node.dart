class Node {
  Node(this.key, this.nodes);

  final String key;
  final List<Node> nodes;

  List<String> getAllKeys() {
    final childrenKeys = <String>[];
    for (final node in nodes) {
      childrenKeys.addAll(node.getAllKeys());
    }
    return [key, ...childrenKeys];
  }
}
