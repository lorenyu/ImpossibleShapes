color[] colors = {#E0E4CC, #F38630, #69D2E7, #A7DBD8};

Pattern pattern;

void setup() {
  size(1600, 800);

  pattern = new Pattern();
  initTile();
  testColorMatching();
  testTileAdjacencies();
  
  fill(colors[0]);
  rect(0,0,width,height);
  noStroke();
  
  drawTiles();
}

void drawTiles() {
  pushMatrix();
  translate(0, TILE_SIDE_LENGTH * 2);
  int col = 0;
  int[] numPerCol = new int[]{
    24, 21, 16, 24, 24
  };
  int row = 0;
  for (Tile tile : tiles) {
    translate(TILE_SIDE_LENGTH * 2, 0);
    tile.draw();
    fill(0);
    rect(-1,-1,2,2);
    col++;
    if (col >= numPerCol[row]) {
      translate(-TILE_SIDE_LENGTH * 2 * numPerCol[row], TILE_SIDE_LENGTH * 2);
      row++;
      col = 0;
    }
  }
  popMatrix();
}

void drawTiles(Tile[] tiles) {
  pushMatrix();
  translate(0, TILE_SIDE_LENGTH * 2);
  int col = 0;
  int numPerCol = 24;
  int row = 0;
  for (Tile tile : tiles) {
    translate(TILE_SIDE_LENGTH * 2, 0);
    tile.draw();
    fill(0);
    rect(-1,-1,2,2);
    col++;
    if (col >= numPerCol) {
      translate(-TILE_SIDE_LENGTH * 2 * numPerCol, TILE_SIDE_LENGTH * 2);
      row++;
      col = 0;
    }
  }
  popMatrix();
}

void draw() {
//void mousePressed() {
  fill(colors[0]);
  rect(0,0,width,height);
  if (!pattern.step()) {
    println("Done.");
  }
  pattern.draw();
}


