Tile T2a, T2a1, T2a2, T2a3, T2a4, T2a5,
  T2ar, T2ar1, T2ar2, T2ar3, T2ar4, T2ar5,
  T2b, T2b1, T2b2, T2b3, T2b4, T2b5,
  T2c, T2c1, T2c2, T2c3, T2c4, T2c5,
  T2d, T2d1, T2d2,
  T3a, T3a1, T3a2, T3a3, T3a4, T3a5,
  T3b, T3b1, T3b2, T3b3, T3b4, T3b5,
  T3br, T3br1, T3br2, T3br3, T3br4, T3br5,
  T3c, T3c1,
  T3d, T3d1,
  T3e, T3e1, T3e2, T3e3, T3e4, T3e5,
  T4a, T4a1, T4a2, T4a3, T4a4, T4a5,
  T4ar, T4ar1, T4ar2, T4ar3, T4ar4, T4ar5,
  T4b, T4b1, T4b2, T4b3, T4b4, T4b5,
  T4c, T4c1, T4c2, T4c3, T4c4, T4c5,
  T4d, T4d1, T4d2, T4d3, T4d4, T4d5,
  T5a, T5a1, T5a2, T5a3, T5a4, T5a5,
  T5b, T5b1, T5b2, T5b3, T5b4, T5b5,
  T6a, T6a1;

PVector[][] TILE_POINTS;
float TRIANGLE_LENGTH = 10.0;
float TILE_SIDE_LENGTH = TRIANGLE_LENGTH * 3;
float TILE_SPACING = TILE_SIDE_LENGTH + TRIANGLE_LENGTH; 

// Array of adjacencies (dx, dy)
int[][] ADJACENCIES =   new int[][]{{-1,-1},{0,-1},{-1,0},{1, 0},{0,1},{1, 1}};
// Array of surface coordinates (row, col) to test for adjencies (should be same length as adjencies), but
// not the numbers are in (row, col), not (x, y)
int[][] ADJACENCY_TEST = new int[][]{{ 0, 1},{0, 6},{ 2,0},{3,11},{5,5},{5,10}};
// Array of sets of coordinates (row, col) to test when trying to match a tile with an adjacent tile
// (should be same length as adjencies). The adjacency coordinate list also need to correspond 1-1 with
// the reverse adjacency list e.g. the list of coordinates for the (-1,-1) adjacency need to be in the same
// order as the list of coordinates for (1,1) adjacency
int[][][] ADJACENCY_MATCH_TEST = new int[][][]{
  {            {0,2},{0,3}, // corresponds to (-1,-1) adjacency
   {1,0},{1,1}           },
  {{0,3},{0,4},             // corresponds to (0,-1) adjacency
                           {1,7},{1,8}},
  {{1,0},                   // corresponds to (-1,0) adjacency
         {2,1},
               {3,2},
                     {4,3}},
  {{1,8},                   // corresponds to (1,0) adjacency
         {2,9},
               {3,10},
                      {4,11}},
  {{4,3},{4,4},             // corresponds to (0,1) adjacency
                           {5,7},{5,8}},
  {            {4,10},{4,11}, // corresponds to (1,1) adjacency
   {5,8},{5,9}             }
};

// matrix of coordinates to pull from during a rotation
int[][][] ROTATION = new int[][][]{
  {{0,5},{0,6},{1,7},{1,8},{2,9},{2,10},{3,11},  null,  null,  null,  null,  null},
  {{0,3},{0,4},{1,5},{1,6},{2,7}, {2,8}, {3,9},{3,10},{4,11},  null,  null,  null},
  {{0,1},{0,2},{1,3},{1,4},{2,5}, {2,6}, {3,7}, {3,8}, {4,9},{4,10},{5,11},  null},
  { null,{0,0},{1,1},{1,2},{2,3}, {2,4}, {3,5}, {3,6}, {4,7}, {4,8}, {5,9},{5,10}},
  { null, null, null,{1,0},{2,1}, {2,2}, {3,3}, {3,4}, {4,5}, {4,6}, {5,7}, {5,8}},
  { null, null, null, null, null, {2,0}, {3,1}, {3,2}, {4,3}, {4,4}, {5,5}, {5,6}}
};

Tile[] tiles;

class Tile {
  int[][] surfaces;
  ArrayList<int[]> adjacencies;

  Tile(int[][] surfaces) {
    this.surfaces = new int[surfaces.length][surfaces[0].length];
    for (int i = 0; i < this.surfaces.length; i++) {
      arrayCopy(surfaces[i], this.surfaces[i]);
    }

    assert ADJACENCIES.length == ADJACENCY_TEST.length;
    this.adjacencies = new ArrayList<int[]>(); 
    for (int i = 0; i < ADJACENCIES.length; i++) {
      int row = ADJACENCY_TEST[i][0];
      int col = ADJACENCY_TEST[i][1];
      if (this.surfaces[row][col] != 0) {
        this.adjacencies.add(ADJACENCIES[i]);
      }
    }
  }

  Tile(Tile t) {
    this(t.surfaces);
  }
  
  void draw() {
    draw(colors);
  }
  
  void draw(color[] colors) {
    for (int i = 0; i < this.surfaces.length; i++) {
      for (int j = 0; j < this.surfaces[i].length; j++) {
        color colorIndex = this.surfaces[i][j];
        if (colorIndex == 0) {
          continue;
        }
        if (i >= (j/2.0) + 3 ) {
          continue;
        }
        if (i < j/2.0 - 3) {
          continue;
        }
//        stroke(colors[colorIndex]);
        fill(colors[colorIndex]);
        PVector p1, p2, p3;
        if (j % 2 == 0) {
          p1 = TILE_POINTS[i][j/2];
          p2 = TILE_POINTS[i+1][j/2];
          p3 = TILE_POINTS[i+1][j/2+1];
        } else {
          p1 = TILE_POINTS[i][j/2];
          p2 = TILE_POINTS[i+1][j/2+1];
          p3 = TILE_POINTS[i][j/2+1];
        }
        triangle(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
      }
    }
  }

  boolean matches(Tile other, int[] adjacency) {
    return getColorMap(other, adjacency) != null;
  }

  int[] getColorMap(Tile other, int[] adjacency) {
    int[] otherAdjacency = new int[]{-adjacency[0],-adjacency[1]};
    int[][] adjacencyMatchCoords;
    int[][] otherAdjacencyMatchCoords;
    int adjacencyIndex = -1;
    int otherAdjacencyIndex = -1;
    for (int i = 0; i < ADJACENCIES.length; i++) {
      if (adjacency[0] == ADJACENCIES[i][0] &&
          adjacency[1] == ADJACENCIES[i][1]) {
        adjacencyIndex = i;
      }
      if (otherAdjacency[0] == ADJACENCIES[i][0] &&
          otherAdjacency[1] == ADJACENCIES[i][1]) {
        otherAdjacencyIndex = i;
      }
    }
    if (adjacencyIndex == -1 || otherAdjacencyIndex == -1) {
      return null;
    }
    int[] colorMap = new int[4];
    for (int i = 0; i < colorMap.length; i++) {
      colorMap[i] = -1;
    }
    for (int i = 0; i < ADJACENCY_MATCH_TEST[adjacencyIndex].length; i++) {
      int row = ADJACENCY_MATCH_TEST[adjacencyIndex][i][0];
      int col = ADJACENCY_MATCH_TEST[adjacencyIndex][i][1];
      int otherRow = ADJACENCY_MATCH_TEST[otherAdjacencyIndex][i][0];
      int otherCol = ADJACENCY_MATCH_TEST[otherAdjacencyIndex][i][1];
      if (colorMap[this.surfaces[row][col]] == -1) {
        colorMap[this.surfaces[row][col]] = other.surfaces[otherRow][otherCol];
        continue;
      }
      if (colorMap[this.surfaces[row][col]] != other.surfaces[otherRow][otherCol]) {
        return null;
      }
    }
    return colorMap;
  }
  
  Tile flipHorizontal() {
    int[][] newSurfaces = new int[surfaces.length][surfaces[0].length];
    for (int i = 0; i < newSurfaces.length; i++) {
      int offset = 2*i - 5;
      for (int j = 0; j < newSurfaces[i].length; j++) {
        newSurfaces[i][j] = surfaces[i][(surfaces[i].length - j - 1 + offset + surfaces[i].length) % surfaces[i].length];        
      }
    }
    return new Tile(newSurfaces);
  }
  
  Tile rotateCounterClockwise() {
    int[][] newSurfaces = new int[surfaces.length][surfaces[0].length];
    for (int i = 0; i < newSurfaces.length; i++) {
      int offset = 2*i - 5;
      for (int j = 0; j < newSurfaces[i].length; j++) {
        if (ROTATION[i][j] != null) {
          int row = ROTATION[i][j][0];
          int col = ROTATION[i][j][1];
          newSurfaces[i][j] = surfaces[row][col];
        } else {
          newSurfaces[i][j] = 0;
        }
      }
    }
    return new Tile(newSurfaces);
  }
}

void initTile() {
  initTilePoints();
  
  T2a = new Tile(new int[][]{ // A
    {0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,1,1,2,0,0,0,0,0},
    {0,0,0,0,1,1,2,2,2,0,0,0},
    {0,0,0,0,1,1,2,2,3,2,2,0},
    {0,0,0,0,0,1,2,2,0,3,3,2}
  });
  T2a1 = T2a.rotateCounterClockwise();
  T2a2 = T2a1.rotateCounterClockwise();
  T2a3 = T2a2.rotateCounterClockwise();
  T2a4 = T2a3.rotateCounterClockwise();
  T2a5 = T2a4.rotateCounterClockwise();
  T2ar = T2a.flipHorizontal();
  T2ar1 = T2ar.rotateCounterClockwise();
  T2ar2 = T2ar1.rotateCounterClockwise();
  T2ar3 = T2ar2.rotateCounterClockwise();
  T2ar4 = T2ar3.rotateCounterClockwise();
  T2ar5 = T2ar4.rotateCounterClockwise();
  T2b = new Tile(new int[][]{ // c
    {0,0,0,0,1,1,2,0,0,0,0,0},
    {0,0,0,0,1,1,2,2,0,0,0,0},
    {0,0,0,0,1,1,2,2,0,0,0,0},
    {0,0,0,0,0,3,3,2,2,0,0,0},
    {0,0,0,0,0,0,0,3,3,2,2,0},
    {0,0,0,0,0,0,0,0,0,3,3,2}
  });
  T2b1 = T2b.rotateCounterClockwise();
  T2b2 = T2b1.rotateCounterClockwise();
  T2b3 = T2b2.rotateCounterClockwise();
  T2b4 = T2b3.rotateCounterClockwise();
  T2b5 = T2b4.rotateCounterClockwise();
  T2c = new Tile(new int[][]{ // r
    {0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,1,1,1,1,1,1,1,0},
    {0,0,0,0,1,1,2,3,3,3,3,3},
    {0,0,0,0,1,1,2,2,0,0,0,0},
    {0,0,0,0,0,1,2,2,0,0,0,0}
  });
  T2c1 = T2c.rotateCounterClockwise();
  T2c2 = T2c1.rotateCounterClockwise();
  T2c3 = T2c2.rotateCounterClockwise();
  T2c4 = T2c3.rotateCounterClockwise();
  T2c5 = T2c4.rotateCounterClockwise();
  T2d = new Tile(new int[][]{ // I
    {0,0,0,0,1,1,2,0,0,0,0,0},
    {0,0,0,0,1,1,2,2,0,0,0,0},
    {0,0,0,0,1,1,2,2,0,0,0,0},
    {0,0,0,0,1,1,2,2,0,0,0,0},
    {0,0,0,0,1,1,2,2,0,0,0,0},
    {0,0,0,0,0,1,2,2,0,0,0,0}
  });
  T2d1 = T2d.rotateCounterClockwise();
  T2d2 = T2d1.rotateCounterClockwise();
  T3a = new Tile(new int[][]{ // tau
    {0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0},
    {1,1,1,1,1,1,2,0,0,0,0,0},
    {0,3,3,3,1,1,2,2,2,0,0,0},
    {0,0,0,0,1,1,2,2,3,2,2,0},
    {0,0,0,0,0,1,2,2,0,3,3,2}
  });
  T3a1 = T3a.rotateCounterClockwise();
  T3a2 = T3a1.rotateCounterClockwise();
  T3a3 = T3a2.rotateCounterClockwise();
  T3a4 = T3a3.rotateCounterClockwise();
  T3a5 = T3a4.rotateCounterClockwise();
  T3b = new Tile(new int[][]{ // T
    {0,0,0,0,1,1,2,2,0,0,0,0},
    {0,0,0,0,1,1,2,2,0,0,0,0},
    {0,0,0,0,1,1,1,1,1,1,1,0},
    {0,0,0,0,1,1,2,3,3,3,3,3},
    {0,0,0,0,1,1,2,2,0,0,0,0},
    {0,0,0,0,0,1,2,2,0,0,0,0}
  });
  T3b1 = T3b.rotateCounterClockwise();
  T3b2 = T3b1.rotateCounterClockwise();
  T3b3 = T3b2.rotateCounterClockwise();
  T3b4 = T3b3.rotateCounterClockwise();
  T3b5 = T3b4.rotateCounterClockwise();
  T3br = T3b.flipHorizontal();
  T3br1 = T3br.rotateCounterClockwise();
  T3br2 = T3br1.rotateCounterClockwise();
  T3br3 = T3br2.rotateCounterClockwise();
  T3br4 = T3br3.rotateCounterClockwise();
  T3br5 = T3br4.rotateCounterClockwise();
  T3c = new Tile(new int[][]{
    {0,0,0,0,1,1,2,0,0,0,0,0},
    {0,0,0,0,1,1,2,2,0,0,0,0},
    {1,1,1,1,1,1,2,2,0,0,0,0},
    {0,3,3,3,3,3,3,2,2,0,0,0},
    {0,0,0,0,0,0,0,3,3,2,2,0},
    {0,0,0,0,0,0,0,0,0,3,3,2}
  });
  T3c1 = T3c.rotateCounterClockwise();
  T3d = new Tile(new int[][]{
    {0,0,0,0,1,1,2,0,0,0,0,0},
    {0,0,0,0,1,1,2,2,0,0,0,0},
    {3,3,3,3,3,1,2,2,0,0,0,0},
    {0,2,2,2,2,2,1,3,3,0,0,0},
    {0,0,0,0,0,0,0,1,1,3,3,0},
    {0,0,0,0,0,0,0,0,0,1,1,3}
  });
  T3d1 = T3d.rotateCounterClockwise();
  T3e = new Tile(new int[][]{
    {3,2,2,0,1,1,2,2,0,0,0,0},
    {0,3,3,2,2,1,2,2,0,0,0,0},
    {0,0,0,3,3,2,1,1,1,1,1,0},
    {0,0,0,0,0,3,3,3,3,3,3,3},
    {0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0}
  });
  T3e1 = T3e.rotateCounterClockwise();
  T3e2 = T3e1.rotateCounterClockwise();
  T3e3 = T3e2.rotateCounterClockwise();
  T3e4 = T3e3.rotateCounterClockwise();
  T3e5 = T3e4.rotateCounterClockwise();
  T4a = new Tile(new int[][]{ // pi
    {0,0,0,0,1,1,2,2,0,0,0,0},
    {0,0,0,0,1,1,2,2,0,0,0,0},
    {0,0,0,0,1,1,1,1,1,1,1,0},
    {0,0,0,0,1,1,2,3,3,3,3,3},
    {0,0,0,0,1,1,2,2,3,2,2,0},
    {0,0,0,0,0,1,2,2,0,3,3,2}
  });
  T4a1 = T4a.rotateCounterClockwise();
  T4a2 = T4a1.rotateCounterClockwise();
  T4a3 = T4a2.rotateCounterClockwise();
  T4a4 = T4a3.rotateCounterClockwise();
  T4a5 = T4a4.rotateCounterClockwise();
  T4ar = T4a.flipHorizontal();
  T4ar1 = T4ar.rotateCounterClockwise();
  T4ar2 = T4ar1.rotateCounterClockwise();
  T4ar3 = T4ar2.rotateCounterClockwise();
  T4ar4 = T4ar3.rotateCounterClockwise();
  T4ar5 = T4ar4.rotateCounterClockwise();
  T4b = new Tile(new int[][]{ // dagger
    {0,0,0,0,1,1,2,0,0,0,0,0},
    {0,0,0,0,1,1,2,2,0,0,0,0},
    {1,1,1,1,1,1,2,2,0,0,0,0},
    {0,3,3,3,1,1,2,2,2,0,0,0},
    {0,0,0,0,1,1,2,2,3,2,2,0},
    {0,0,0,0,0,1,2,2,0,3,3,2}
  });
  T4b1 = T4b.rotateCounterClockwise();
  T4b2 = T4b1.rotateCounterClockwise();
  T4b3 = T4b2.rotateCounterClockwise();
  T4b4 = T4b3.rotateCounterClockwise();
  T4b5 = T4b4.rotateCounterClockwise();
  T4c = new Tile(new int[][]{ // dagger
    {3,2,2,0,1,1,2,0,0,0,0,0},
    {0,3,3,2,2,1,2,2,0,0,0,0},
    {0,0,0,3,3,2,1,1,1,1,1,0},
    {0,0,0,0,1,1,2,3,3,3,3,3},
    {0,0,0,0,1,1,2,2,0,0,0,0},
    {0,0,0,0,0,1,2,2,0,0,0,0}
  });
  T4c1 = T4c.rotateCounterClockwise();
  T4c2 = T4c1.rotateCounterClockwise();
  T4c3 = T4c2.rotateCounterClockwise();
  T4c4 = T4c3.rotateCounterClockwise();
  T4c5 = T4c4.rotateCounterClockwise();
  T4d = new Tile(new int[][]{ // star bottom
    {3,2,2,0,0,0,0,0,0,0,0,0},
    {0,3,3,2,2,0,0,0,0,0,0,0},
    {1,1,1,3,3,2,1,1,1,1,1,0},
    {0,3,3,3,3,3,3,3,3,3,3,3},
    {0,0,0,0,0,0,0,3,3,2,2,0},
    {0,0,0,0,0,0,0,0,0,3,3,2}
  });
  T4d1 = T4d.rotateCounterClockwise();
  T4d2 = T4d1.rotateCounterClockwise();
  T4d3 = T4d2.rotateCounterClockwise();
  T4d4 = T4d3.rotateCounterClockwise();
  T4d5 = T4d4.rotateCounterClockwise();
  T5a = new Tile(new int[][]{ // star top
    {1,3,3,0,1,1,2,0,0,0,0,0},
    {0,1,1,3,1,1,2,2,0,0,0,0},
    {3,3,3,3,3,1,2,2,3,3,3,0},
    {0,2,2,2,2,2,1,3,3,2,2,2},
    {0,0,0,0,0,0,0,1,1,3,3,0},
    {0,0,0,0,0,0,0,0,0,1,1,3}
  });
  T5a1 = T5a.rotateCounterClockwise();
  T5a2 = T5a1.rotateCounterClockwise();
  T5a3 = T5a2.rotateCounterClockwise();
  T5a4 = T5a3.rotateCounterClockwise();
  T5a5 = T5a4.rotateCounterClockwise();
  T5b = new Tile(new int[][]{ // star bottom
    {3,2,2,0,1,1,2,0,0,0,0,0},
    {0,3,3,2,2,1,2,2,0,0,0,0},
    {1,1,1,3,3,2,1,1,1,1,1,0},
    {0,3,3,3,3,3,3,3,3,3,3,3},
    {0,0,0,0,0,0,0,3,3,2,2,0},
    {0,0,0,0,0,0,0,0,0,3,3,2}
  });
  T5b1 = T5b.rotateCounterClockwise();
  T5b2 = T5b1.rotateCounterClockwise();
  T5b3 = T5b2.rotateCounterClockwise();
  T5b4 = T5b3.rotateCounterClockwise();
  T5b5 = T5b4.rotateCounterClockwise();
  T6a = new Tile(new int[][]{ // 6-point star
    {1,3,3,0,1,1,2,0,0,0,0,0},
    {0,1,1,3,1,1,2,2,0,0,0,0},
    {3,3,3,3,3,1,2,2,3,3,3,0},
    {0,2,2,2,2,2,1,3,3,2,2,2},
    {0,0,0,0,1,1,2,1,1,3,3,0},
    {0,0,0,0,0,1,2,2,0,1,1,3}
  });
  T6a1 = T6a.rotateCounterClockwise();
  
  tiles = new Tile[]{
    T2a, T2a1, T2a2, T2a3, T2a4, T2a5,
    T2ar, T2ar1, T2ar2, T2ar3, T2ar4, T2ar5,
    T2b, T2b1, T2b2, T2b3, T2b4, T2b5,
    T2c, T2c1, T2c2, T2c3, T2c4, T2c5,
    T2d, T2d1, T2d2,
    T3a, T3a1, T3a2, T3a3, T3a4, T3a5,
    T3b, T3b1, T3b2, T3b3, T3b4, T3b5,
    T3br, T3br1, T3br2, T3br3, T3br4, T3br5,
    T3c, T3c1,
    T3d, T3d1,
    T3e, T3e1, T3e2, T3e3, T3e4, T3e5,
    T4a, T4a1, T4a2, T4a3, T4a4, T4a5,
    T4ar, T4ar1, T4ar2, T4ar3, T4ar4, T4ar5,
    T4b, T4b1, T4b2, T4b3, T4b4, T4b5,
    T4c, T4c1, T4c2, T4c3, T4c4, T4c5,
    T4d, T4d1, T4d2, T4d3, T4d4, T4d5,
    T5a, T5a1, T5a2, T5a3, T5a4, T5a5,
    T5b, T5b1, T5b2, T5b3, T5b4, T5b5,
    T6a, T6a1
  };

}

void initTilePoints() {
  TILE_POINTS = new PVector[7][7];
  float centerX = TILE_SIDE_LENGTH / 2;
  float centerY = TILE_SIDE_LENGTH * sqrt(3)/2;
  for (int i = 0; i < 7; i++) {
    float rowX = i * (-TRIANGLE_LENGTH/2);
    float y = i * sqrt(3)/2 * TRIANGLE_LENGTH - centerY;
    for (int j = 0; j < 7; j++) {
      float x = rowX + j * TRIANGLE_LENGTH - centerX;
      TILE_POINTS[i][j] = new PVector(x,y);
    }
  }
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

