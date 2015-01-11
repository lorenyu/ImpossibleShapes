Pattern P1x1A, P1x1B,
  P2x2A, P2x2B,
  P3x3A, P3x3B, P3x3C, P3x3D,
  P7x7A, P7x7B, P7x7C, P7x7D, P7x7E, P7x7F,
  P13x13A, P13x13B;
  
Pattern[] patterns;


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

void initPresetPattern() {
  P1x1A = new PresetPattern(new Tile[][]{
    {T6a}
  });
  
  P1x1B = new PresetPattern(new Tile[][]{
    {T6a1}
  });

  P2x2A = new PresetPattern(new Tile[][]{
    {T4d4, T4d},
    {T4d2,null}
  });
  
  P2x2B = new PresetPattern(new Tile[][]{
    {T4d1,T4d3},
    {T4d5,null}
  });

//  P2x2C = new PresetPattern(new Tile[][]{
//    {T3a1,T3e3},
//    {T3e1,T3a3}
//  });

  P3x3A = new PresetPattern(new Tile[][]{
    {T3c1,T3c,null},
    {T3c,null,T3c1},
    {null,T3c1,T3c}
  });
  
  P3x3B = new PresetPattern(new Tile[][]{
    {T3d1,T3d,null},
    {T3d,null,T3d1},
    {null,T3d1,T3d}
  });

  P3x3C = new PresetPattern(new Tile[][]{
    {T3c1,T3d,null},
    {T3d,null,T3c1},
    {null,T3c1,T3d}
  });
  
  P3x3D = new PresetPattern(new Tile[][]{
    {T3d1,T3c,null},
    {T3c,null,T3d1},
    {null,T3d1,T3c}
  });

  P7x7A = new PresetPattern(new Tile[][]{
    { T3a,T3a1,T3a5,null,T3a2,T3a4,T3a3},
    {T3a2,T3a4,T3a3, T3a,T3a1,T3a5,null},
    {T3a1,T3a5,null,T3a2,T3a4,T3a3, T3a},
    {T3a4,T3a3, T3a,T3a1,T3a5,null,T3a2},
    {T3a5,null,T3a2,T3a4,T3a3, T3a,T3a1},
    {T3a3, T3a,T3a1,T3a5,null,T3a2,T3a4},
    {null,T3a2,T3a4,T3a3, T3a,T3a1,T3a5}
  });

  P7x7B = new PresetPattern(new Tile[][]{
    {T3a2, T3a,T3a1,T3a4,T3a3,T3a5,null},
    {T3a1,T3a4,T3a3,T3a5,null,T3a2, T3a},
    {T3a3,T3a5,null,T3a2, T3a,T3a1,T3a4},
    {null,T3a2, T3a,T3a1,T3a4,T3a3,T3a5},
    { T3a,T3a1,T3a4,T3a3,T3a5,null,T3a2},
    {T3a4,T3a3,T3a5,null,T3a2, T3a,T3a1},
    {T3a5,null,T3a2, T3a,T3a1,T3a4,T3a3}
  });
  
  P7x7C = new PresetPattern(new Tile[][]{
    {T3e5,T3e3,T3e4,T3e1,T3e,T3e2,null},
    {T3e4,T3e1,T3e,T3e2,null,T3e5,T3e3},
    {T3e,T3e2,null,T3e5,T3e3,T3e4,T3e1},
    {null,T3e5,T3e3,T3e4,T3e1,T3e,T3e2},
    {T3e3,T3e4,T3e1,T3e,T3e2,null,T3e5},
    {T3e1,T3e,T3e2,null,T3e5,T3e3,T3e4},
    {T3e2,null,T3e5,T3e3,T3e4,T3e1,T3e}
  });
  
  P7x7D = new PresetPattern(new Tile[][]{
    {T3e3,T3e4,T3e2,null,T3e5,T3e1,T3e},
    {T3e5,T3e1,T3e,T3e3,T3e4,T3e2,null},
    {T3e4,T3e2,null,T3e5,T3e1,T3e,T3e3},
    {T3e1,T3e,T3e3,T3e4,T3e2,null,T3e5},
    {T3e2,null,T3e5,T3e1,T3e,T3e3,T3e4},
    {T3e,T3e3,T3e4,T3e2,null,T3e5,T3e1},
    {null,T3e5,T3e1,T3e,T3e3,T3e4,T3e2}
  });

  P7x7E = new PresetPattern(new Tile[][]{
    {T3b4,T3b,T3b5,T3b2,T3b3,T3b1,null},
    {T3b3,T3b1,null,T3b4,T3b,T3b5,T3b2},
    {T3b,T3b5,T3b2,T3b3,T3b1,null,T3b4},
    {T3b1,null,T3b4,T3b,T3b5,T3b2,T3b3},
    {T3b5,T3b2,T3b3,T3b1,null,T3b4,T3b},
    {null,T3b4,T3b,T3b5,T3b2,T3b3,T3b1},
    {T3b2,T3b3,T3b1,null,T3b4,T3b,T3b5}
  });
  
  P7x7F = new PresetPattern(new Tile[][]{
    {T3br1,T3br,T3br2,null,T3br5,T3br3,T3br4},
    {T3br2,null,T3br5,T3br3,T3br4,T3br1,T3br},
    {T3br5,T3br3,T3br4,T3br1,T3br,T3br2,null},
    {T3br4,T3br1,T3br,T3br2,null,T3br5,T3br3},
    {T3br,T3br2,null,T3br5,T3br3,T3br4,T3br1},
    {null,T3br5,T3br3,T3br4,T3br1,T3br,T3br2},
    {T3br3,T3br4,T3br1,T3br,T3br2,null,T3br5},
  });

  P13x13A = new PresetPattern(new Tile[][]{
    {T3b4,null,null,T3b,T3b2,T3b5,T3b3,null,null,T3b1,null,null,null},
    {T3b,T3b2,T3b5,T3b3,null,null,T3b1,null,null,null,T3b4,null,null},
    {T3b3,null,null,T3b1,null,null,null,T3b4,null,null,T3b,T3b2,T3b5},
    {T3b1,null,null,null,T3b4,null,null,T3b,T3b2,T3b5,T3b3,null,null},
    {null,T3b4,null,null,T3b,T3b2,T3b5,T3b3,null,null,T3b1,null,null},
    {null,T3b,T3b2,T3b5,T3b3,null,null,T3b1,null,null,null,T3b4,null},
    {T3b5,T3b3,null,null,T3b1,null,null,null,T3b4,null,null,T3b,T3b2},
    {null,T3b1,null,null,null,T3b4,null,null,T3b,T3b2,T3b5,T3b3,null},
    {null,null,T3b4,null,null,T3b,T3b2,T3b5,T3b3,null,null,T3b1,null},
    {null,null,T3b,T3b2,T3b5,T3b3,null,null,T3b1,null,null,null,T3b4},
    {T3b2,T3b5,T3b3,null,null,T3b1,null,null,null,T3b4,null,null,T3b},
    {null,null,T3b1,null,null,null,T3b4,null,null,T3b,T3b2,T3b5,T3b3},
    {null,null,null,T3b4,null,null,T3b,T3b2,T3b5,T3b3,null,null,T3b1},
  });
  
  P13x13B = new PresetPattern(new Tile[][]{
    {T3br1,T3br4,T3br,null,null,T3br2,null,null,null,T3br5,null,null,T3br3},
    {T3br5,null,null,T3br3,T3br1,T3br4,T3br,null,null,T3br2,null,null,null},
    {T3br2,null,null,null,T3br5,null,null,T3br3,T3br1,T3br4,T3br,null,null},
    {T3br4,T3br,null,null,T3br2,null,null,null,T3br5,null,null,T3br3,T3br1},
    {null,null,T3br3,T3br1,T3br4,T3br,null,null,T3br2,null,null,null,T3br5},
    {null,null,null,T3br5,null,null,T3br3,T3br1,T3br4,T3br,null,null,T3br2},
    {T3br,null,null,T3br2,null,null,null,T3br5,null,null,T3br3,T3br1,T3br4},
    {null,T3br3,T3br1,T3br4,T3br,null,null,T3br2,null,null,null,T3br5,null},
    {null,null,T3br5,null,null,T3br3,T3br1,T3br4,T3br,null,null,T3br2,null},
    {null,null,T3br2,null,null,null,T3br5,null,null,T3br3,T3br1,T3br4,T3br},
    {T3br3,T3br1,T3br4,T3br,null,null,T3br2,null,null,null,T3br5,null,null},
    {null,T3br5,null,null,T3br3,T3br1,T3br4,T3br,null,null,T3br2,null,null},
    {null,T3br2,null,null,null,T3br5,null,null,T3br3,T3br1,T3br4,T3br,null}
  });
}
