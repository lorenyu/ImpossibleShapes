//color[] colors = {#E0E4CC, #F38630, #69D2E7, #A7DBD8}; // a-light
color[] colors = {#444450, #FF766C, #6ECCD2, #49A2CE}; // b-dark
//color[] colors = {#FCEBB6, #F07818, #78C0A8, #F0A830}; // c-light
//color[] colors = {#5E412F, #F07818, #78C0A8, #F0A830}; // d-dark

Pattern pattern;
int patternIndex = 0;
int RANDOM_PATTERN = 0;
int PRESET_PATTERN = 1;
int patternMode = PRESET_PATTERN; 

void setup() {
  size(1600, 800, P2D);

  initTile();
  initPattern();
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
    if (tile != null) {
      tile.draw();
    }
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

void keyPressed() {
  println(key);
  if (key == 'r') {
    patternMode = RANDOM_PATTERN;
    println("Set pattern mode = RANDOM");
  } else if (key == 'p') {
    patternMode = PRESET_PATTERN;
    println("Set patter mode = PRESET");
  } else {
    return;
  }
  patternIndex = 0;
  stepPattern();
}

void stepPattern() {
  fill(colors[0]);
  rect(0,0,width,height);
  
  if (patternMode == RANDOM_PATTERN) {
    pattern = new RandomPattern();
  } else if (patternMode == PRESET_PATTERN) {
    pattern = patterns[patternIndex];
  }

  pattern.draw();
  patternIndex++;
  if (patternIndex >= patterns.length) {
    patternIndex = 0;
  }
}

void mousePressed() {
  stepPattern();
}

void draw() {
}