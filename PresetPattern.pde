class PresetPattern extends Pattern {
  Tile[][] tilePattern;

  PresetPattern(Tile[][] tilePattern) {
    this.tilePattern = tilePattern;
    graph.openNode(graph.getNode(0, 0));
  }

  boolean step() {
    if (graph.openNodes.size() <= 0) {
      println("No more open nodes");
      return false;
    }
    
    Node node = graph.openNodes.get(0);
    
    int patternRow = node.row % tilePattern.length;
    int patternCol = node.col % tilePattern[patternRow].length;
    Tile tile = tilePattern[patternRow][patternCol];

    if (tile == null) {
      graph.closeNode(node);
      return true;
    }

    graph.placeTile(tile, node.row, node.col);
    return true;
  }
}
