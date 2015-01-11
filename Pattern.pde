Pattern P2x2A, P2x2B,
  P7x7A, P7x7B;
  
Pattern[] patterns;

class Pattern {
  Graph graph = new Graph();
  
  void finish() {
    while (step());
  }
  
  boolean step() {
    return false;
  }

  void draw() {
    graph.draw();
  }
}

void initPattern() {
  P2x2A = new PresetPattern(new Tile[][]{
    {T4d4, T4d},
    {T4d2,null}
  });
  
  P2x2B = new PresetPattern(new Tile[][]{
    {T4d1,T4d3},
    {T4d5,null}
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
  
  patterns = new Pattern[]{
    P2x2A, P2x2B, P7x7A, P7x7B
  };
}

