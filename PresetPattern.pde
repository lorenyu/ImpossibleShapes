Pattern P1x1A, P1x1B,
  P1x2A, P1x2B,
  P2x1A,
  P2x2A, P2x2B,
  P3x3A, P3x3B, P3x3C, P3x3D,
  P7x7A, P7x7B, P7x7C, P7x7D, P7x7E, P7x7F,
  P7x7G, P7x7H, P7x7I, P7x7J,
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
  
  P1x2A = new PresetPattern(new Tile[][]{
    {T4d},
    {T4d3}
  });
  
  P1x2B = new PresetPattern(new Tile[][]{
    {T4d1},
    {T4d4}
  });
  
  P2x1A = new PresetPattern(new Tile[][]{
    {T4d2, T4d5}
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

  P7x7G = new PresetPattern(new Tile[][]{
    {T5b1,T5a,T5a2,null,T5b5,T5b3,T5a4},
    {T5a2,null,T5b5,T5b3,T5a4,T5b1,T5a},
    {T5b5,T5b3,T5a4,T5b1,T5a,T5a2,null},
    {T5a4,T5b1,T5a,T5a2,null,T5b5,T5b3},
    {T5a,T5a2,null,T5b5,T5b3,T5a4,T5b1},
    {null,T5b5,T5b3,T5a4,T5b1,T5a,T5a2},
    {T5b3,T5a4,T5b1,T5a,T5a2,null,T5b5}
  });

  P7x7H = new PresetPattern(new Tile[][]{
    {T5b1,T5a,T5b3,T5a4,T5a2,null,T5b5},
    {T5a2,null,T5b5,T5b1,T5a,T5b3,T5a4},
    {T5a,T5b3,T5a4,T5a2,null,T5b5,T5b1},
    {null,T5b5,T5b1,T5a,T5b3,T5a4,T5a2},
    {T5b3,T5a4,T5a2,null,T5b5,T5b1,T5a},
    {T5b5,T5b1,T5a,T5b3,T5a4,T5a2,null},
    {T5a4,T5a2,null,T5b5,T5b1,T5a,T5b3}
  });

  P7x7I = new PresetPattern(new Tile[][]{
    {T5a1,T5b,T5b2,null,T5a5,T5a3,T5b4},
    {T5b2,null,T5a5,T5a3,T5b4,T5a1,T5b},
    {T5a5,T5a3,T5b4,T5a1,T5b,T5b2,null},
    {T5b4,T5a1,T5b,T5b2,null,T5a5,T5a3},
    {T5b,T5b2,null,T5a5,T5a3,T5b4,T5a1},
    {null,T5a5,T5a3,T5b4,T5a1,T5b,T5b2},
    {T5a3,T5b4,T5a1,T5b,T5b2,null,T5a5}
  });

  P7x7J = new PresetPattern(new Tile[][]{
    {T5a1,T5b,T5a3,T5b4,T5b2,null,T5a5},
    {T5b2,null,T5a5,T5a1,T5b,T5a3,T5b4},
    {T5b,T5a3,T5b4,T5b2,null,T5a5,T5a1},
    {null,T5a5,T5a1,T5b,T5a3,T5b4,T5b2},
    {T5a3,T5b4,T5b2,null,T5a5,T5a1,T5b},
    {T5a5,T5a1,T5b,T5a3,T5b4,T5b2,null},
    {T5b4,T5b2,null,T5a5,T5a1,T5b,T5a3}
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
