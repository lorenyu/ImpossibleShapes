class Graph {
  Node[][] grid;
  ArrayList<Node> openNodes = new ArrayList<Node>();
  ArrayList<Node> tiledNodes = new ArrayList<Node>();
  int numRows;
  int numCols;
  
  Graph() {
    numRows = int(height / TILE_SPACING + 4);
    numCols = int((width + height / 2) / TILE_SPACING + 2);
    grid = new Node[numRows][numCols];
    for (int i = 0; i < numRows; i++) {
      Node[] row = grid[i];
      for (int j = 0; j < numCols; j++) {
        row[j] = new Node(i, j);
      }
    }
  }
  
  void draw() {
    for (int row = 0; row < numRows; row++) {
      for (int col = 0; col < numCols; col++) {
        Node node = grid[row][col];
        pushMatrix();
        float x = col * TILE_SPACING - row * TILE_SPACING/2;
        float y = row * TILE_SPACING * sqrt(3)/2;
        translate(x,y);
        node.draw();
        popMatrix();
      }
    }
  }
  
  boolean hasAdjacentTile(int row, int col) {
    for (int[] adjacency : ADJACENCIES) {
      Node adjacentNode = getNode(row + adjacency[1], col + adjacency[0]);
      if (adjacentNode != null && adjacentNode.tile != null) {
        return true;
      }
    }
    return false;
  }
  
  boolean isTileValid(Tile tile, int row, int col) {
    return true;
  }
  
  Tile[] validTiles(int row, int col) {
    println("Getting valid tiles for " + row + "," + col);
    Node node = getNode(row, col);
    if (node == null) {
      return new Tile[]{};
    }

    if (node.tile != null) {
      return new Tile[]{};
    }

    if (!hasAdjacentTile(row, col)) {
      println("No adjacent tile. All tiles valid");
      return tiles;
    }

    ArrayList<Tile> validTiles = new ArrayList<Tile>();
    for (Tile tile : tiles) {
      int[] colorMap = node.getColorMap(tile, getAdjacentNodes(node));
      if (colorMap != null) {
        validTiles.add(tile);
      }
    }
    return validTiles.toArray(new Tile[]{});
  }
  
  Node[] getAdjacentNodes(Node node) {
    ArrayList<Node> adjacentNodes = new ArrayList<Node>();
    for (int[] adjacency : ADJACENCIES) {
      Node adjacentNode = getNode(node.row + adjacency[1], node.col + adjacency[0]);
      if (adjacentNode != null) {
        adjacentNodes.add(adjacentNode);
      }
    }
    return adjacentNodes.toArray(new Node[]{});
  }
  
  Node getNode(int row, int col) {
    if (row < 0 || row >= numRows) {
      return null;
    }
    if (col < 0 || col >= numCols) {
      return null;
    }
    return grid[row][col];
  }
  
  void openNode(Node node) {
    assert node != null;
    println("Adding open node " + node.row + "," + node.col);
    openNodes.add(node);
  }

  void closeNode(Node node) {
    println("Removing node " + node.row + "," + node.col);
    openNodes.remove(node);
  }
  
  boolean placeTile(Tile tile, int row, int col) {
    println("Placing tile on " + row + "," + col + ".");
    Node node = getNode(row, col);
    assert node != null;

    if (node.tile != null) {
      return false;
    }

    int[] colorMap = node.getColorMap(tile, getAdjacentNodes(node));
    assert colorMap != null;
    node.setTile(tile, colorMap);

    tiledNodes.add(node);
    openNodes.remove(node);
    for (int[] adjacency : tile.adjacencies) {
      int r = row + adjacency[1];
      int c = col + adjacency[0];
      Node adjacentNode = getNode(r, c);
      if (adjacentNode != null && adjacentNode.tile == null && !openNodes.contains(adjacentNode)) {
        openNodes.add(adjacentNode);
        println("Adding " + r + "," + c + " to open nodes");
      }
    }
    return true;
  }

  boolean canPlaceTile(Tile tile, Node node) {
    return true;
  }
}
