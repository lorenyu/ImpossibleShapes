interface Pattern {
  void draw();
}

void initPattern() {
  initTile();
  initPresetPattern();
  
  patterns = new Pattern[]{
    P1x1A, P1x1B,
    P1x2A, P1x2B,
    P2x1A,
    P2x2A, P2x2B,
    P3x3A, P3x3B, P3x3C, P3x3D,
    P7x7A, P7x7B, P7x7C, P7x7D, P7x7E, P7x7F,
    P7x7G, P7x7H, P7x7I, P7x7J,
    P13x13A, P13x13B
  };
}

