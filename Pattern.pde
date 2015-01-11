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
  initTile();
  initPresetPattern();
  
  patterns = new Pattern[]{
    P1x1A, P1x1B, P2x2A, P2x2B, P3x3A, P3x3B, P7x7A, P7x7B, P7x7C, P7x7E, P7x7F, P13x13A, P13x13B
  };
}

