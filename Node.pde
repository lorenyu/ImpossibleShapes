class Node {
  int row;
  int col;
  Tile tile;
  int[] colorMap;
  color[] mappedColors;

  Node(int row, int col) {
    this.row = row;
    this.col = col;
  }
  
  void draw() {
    // TODO: do color mapping
    if (this.tile == null) {
      return;
    }

    if (mappedColors != null) {
      this.tile.draw(mappedColors);
    } else {
      this.tile.draw();
    }
  }
  
  int[] getColorMap(Tile tile, Node[] adjacentNodes) {
    assert adjacentNodes.length > 0;
    ArrayList<int[]> adjacentColorMaps = new ArrayList<int[]>();
    for (int i = 0; i < adjacentNodes.length; i++) {
      Node adjacentNode = adjacentNodes[i];
      int[] adjacency = new int[]{adjacentNode.col - col, adjacentNode.row - row};
      int[] adjacentColorMap = getColorMap(tile, adjacentNode, adjacency);
      if (adjacentColorMap == null) {
        return null;
      }
      adjacentColorMaps.add(adjacentColorMap);
    }
    assert adjacentColorMaps.size() > 0;
    
    int[] colorMap = new int[4];
    for (int i = 0; i < colorMap.length; i++) {
      colorMap[i] = -1;
    }
    for (int[] adjacentColorMap : adjacentColorMaps) {
      for (int i = 0; i < adjacentColorMap.length; i++) {
        if (adjacentColorMap[i] == -1) {
          continue;
        } else if (colorMap[i] == -1) {
          colorMap[i] = adjacentColorMap[i];
        } else if (colorMap[i] != adjacentColorMap[i]) {
          return null;
        }
      }
    }
    return colorMap;
  }
  
  int[] getColorMap(Tile tile, Node other, int[] adjacency) {
    if (tile == null || other.tile == null) {
      return new int[]{-1,-1,-1,-1};
    }
    int[] tileColorMap = tile.getColorMap(other.tile, adjacency);
    if (tileColorMap == null) {
      return null;
    }
    int[] nodeColorMap = new int[tileColorMap.length];
    for (int i = 0; i < nodeColorMap.length; i++) {
      assert other.colorMap != null;
      if (tileColorMap[i] != -1) {
        nodeColorMap[i] = other.colorMap[tileColorMap[i]];
      } else {
        nodeColorMap[i] = -1;
      }
    }
    return nodeColorMap;
  }
  
//  boolean isAdjacentTo(Node node) {
//    return getAdjacencyTo(node) != null;
//  }
//  
//  int[] getAdjacencyTo(Node node) {
//    for (int[] adjacency : ADJACENCIES) {
//      if (row + adjacency[0] == node.row &&
//          col + adjacency[1] == node.col) {
//        return adjacency;
//      }
//    }
//    return null;
//  }
//  
//  void addEdgeTo(Node node) {
//    this.edges.add(new Edge(this, node));
//  }
  
  void setTile(Tile tile, int[] colorMap) {
    this.tile = tile;
    if (colorMap == null) {
      colorMap = new int[]{0,1,2,3};
    }
    this.colorMap = colorMap;
    boolean[] usedColors = new boolean[4];
    for (int i = 0; i < colorMap.length; i++) {
      if (colorMap[i] != -1) {
        usedColors[colorMap[i]] = true;
      }
    }
    for (int i = 0; i < colorMap.length; i++) {
      if (colorMap[i] == -1) {
        int colorIndex = -1;
        for (int j = 0; j < usedColors.length; j++) {
          if (!usedColors[j]) {
            colorIndex = j;
            break;
          }
        }
        assert colorIndex != -1;
        colorMap[i] = colorIndex;
        usedColors[colorIndex] = true;
      }
    }
    println("Setting tile's mapped colors to " + colorMap[0] + "," + colorMap[1] + "," + colorMap[2] + "," + colorMap[3] + ".");
    mappedColors = new color[colorMap.length];
    for (int i = 0; i < mappedColors.length; i++) {
      mappedColors[i] = colors[colorMap[i]];
    }
  }
  
//  ArrayList<Node> getAdjacentNodes() {
//    ArrayList<Node> adjacentNodes = new ArrayList<Node>();
//    for (Edge edge : edges) {
//      if (edge.nodes[0] == this) {
//        adjacentNodes.add(edge.nodes[1]);
//      } else {
//        adjacentNodes.add(edge.nodes[0]);
//      }
//    }
//    return adjacentNodes;
//  }
}
