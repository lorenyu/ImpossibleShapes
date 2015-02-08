class RandomPattern implements Pattern {
  Graph graph = new Graph();
  
  RandomPattern() {
    graph.openNode(graph.getNode(graph.numRows/2, graph.numCols/2));
    while (step());
  }

  boolean step() {
    if (graph.openNodes.size() <= 0) {
      println("No more open nodes");
      return false;
    }
    Node node = graph.openNodes.get(int(random(this.graph.openNodes.size())));
    
    Tile[] validTiles = graph.validTiles(node.row, node.col);
    if (validTiles.length <= 0) {
      println("No valid tiles.");
      graph.closeNode(node);
      return true;
    }
//    drawTiles(validTiles);
    int tileIndex = int(random(validTiles.length));
    println("Using tile " + tileIndex);
    Tile tile = validTiles[tileIndex];

    graph.placeTile(tile, node.row, node.col);
    return true;
  }

  void draw() {
    graph.draw();
  }
}
