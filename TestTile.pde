void testTile() {
  testColorMatching();
  testTileAdjacencies();
  testRotateCounterClockwise();
}

void testTileAdjacencies() {
  assert T2a1.adjacencies.size() == 2;
  assert arrayEquals(T2a1.adjacencies.get(0), new int[]{1,0});
  assert arrayEquals(T2a1.adjacencies.get(1), new int[]{1,1});
  assert T3br2.adjacencies.size() == 3;
  assert arrayEquals(T3br2.adjacencies.get(0), new int[]{0,-1});
  assert arrayEquals(T3br2.adjacencies.get(1), new int[]{0,1});
  assert arrayEquals(T3br2.adjacencies.get(2), new int[]{1,1});
  assert T4c3.adjacencies.size() == 4;
  assert arrayEquals(T4c3.adjacencies.get(0), new int[]{0,-1});
  assert arrayEquals(T4c3.adjacencies.get(1), new int[]{-1,0});
  assert arrayEquals(T4c3.adjacencies.get(2), new int[]{0,1});
  assert arrayEquals(T4c3.adjacencies.get(3), new int[]{1,1});
}

void testColorMatching() {
  assert arrayEquals(T2d.getColorMap(T2d, new int[]{0,-1}), new int[]{0,1,2,-1});
  assert arrayEquals(T2d.getColorMap(T2d, new int[]{0,1}), new int[]{0,1,2,-1});
  assert arrayEquals(T2d.getColorMap(T2d, new int[]{-1,0}), new int[]{0,-1,-1,-1});
  assert arrayEquals(T2d.getColorMap(T4ar, new int[]{0,-1}), new int[]{0,2,3,-1});
  assert arrayEquals(T3e.getColorMap(T2a, new int[]{-1,-1}), new int[]{0,-1,2,3});
  assert arrayEquals(T5b1.getColorMap(T2c, new int[]{-1,0}), new int[]{0,-1,1,3});
  assert arrayEquals(T4b2.getColorMap(T4b3, new int[]{0,-1}), new int[]{0,-1,2,1});
  for (int[] adjacency : ADJACENCIES) {
    assert T6a.getColorMap(T6a, adjacency) != null;
  }
}

void testRotateCounterClockwise() {
  Tile t = new Tile(new int[][]{ // c
    { 1, 2, 3, 0, 4, 5, 6, 0, 0, 0, 0, 0},
    { 0, 7, 8, 9,10,11,12,13, 0, 0, 0, 0},
    {14,15,16,17,18,19,20,21,22,23,24, 0},
    { 0,25,26,27,28,29,30,31,32,33,34,35},
    { 0, 0, 0, 0,36,37,38,39,40,41,42, 0},
    { 0, 0, 0, 0, 0,43,44,45, 0,46,47,48}
  });
  assert arrayEquals2D(t.rotateCounterClockwise().surfaces, new int[][]{ // c
    { 5, 6,13, 0,23,24,35, 0, 0, 0, 0, 0},
    { 0, 4,11,12,21,22,33,34, 0, 0, 0, 0},
    { 2, 3, 9,10,19,20,31,32,41,42,48, 0},
    { 0, 1, 7, 8,17,18,29,30,39,40,46,47},
    { 0, 0, 0, 0,15,16,27,28,37,38,45, 0},
    { 0, 0, 0, 0, 0,14,25,26, 0,36,43,44}
  });
}