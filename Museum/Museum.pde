/** //<>//
 // NAME    : Avalyn Jasenn
 // COURSE    : Computer Graphics
 // 
 **/


PImage[] floor = new PImage[3]; //<>//
PImage wall;

int gridSize = 14;
int gridTotal = 2*gridSize;
int[][][] grid = new int[gridTotal][gridTotal][2];
float[] eye1    = { 0.0, 0.0, 0.0};
float[] center1 = {0.0, 0.0, 0.0};
float[] up1     = {0.0, 1.0, 0.0};

boolean view = false;
float eyeX = 0, eyeY = 0, eyeZ = -10, centerX = 0, centerY = 0, centerZ = 0, upX = 0, upY = 1, upZ = 0;

boolean sky = false;

float trZ = 0;
float rotY= 0;

//exhibits

//box
E0 e0;
float e0x = -7;
float e0y = 1;
float e0z = 0;
int[] box0 = {-9, -1};
int[] box1 = {-5, 2};

//wave
E1 e1;
float e1x = 8;
float e1y = -1;
float e1z = 2;
int[] wave0 = {6, -3};
int[] wave1 = {10, 4};
//float[] waveP = {7,4,2,4}; 

//flame
E2 e2;
float e2x = 0;
float e2y = 1;
float e2z = -7;
int[] flame0 = {-1, -9};
int[] flame1 = {2, -5};
float[] flameP = {2, 2, 2, 2};

//pendulum
E3 e3;
float e3x = 0;
float e3y = 1;
float e3z = 7;
int[] pend0 = {-1, 6};
int[] pend1 = {3, 10};
float[] pendP = {3, 3, 3, 3};

//
//User coordinates

float myX = 0;
float myY = 1; 
float myZ = 0;
float dir = 0;
float turnAng = -PI/2;


void setup() {
  size(600, 600, P3D);
  colorMode(RGB, 1f);
  //hint(DISABLE_OPTIMIZED_STROKE);

  background(0, 0, 0.1);
  stroke(1);
  fill(1);
  resetMatrix();

  //initiate exhibits
  e0 = new E0();
  e1 = new E1();
  e2 = new E2();
  e3 = new E3();

  textureMode(NORMAL);
  floor[0] = loadImage("image/floor0.png");
  floor[1] = loadImage("image/floor1.png");
  floor[2] = loadImage("image/floor2.png");
  wall = loadImage("image/wall2.png");

  makeGrid();
}

void draw() {

  perspective(-1, 1, 1, -1);
  clear();
  background(0.15, 0, 0.2);
  resetMatrix();


  rotateY(rotY);
  if (sky) {
    translate(0, 0, -30);
    rotateX(PI/2);
  }

  pushMatrix();
  if (!sky) {
    rotateY(dir*turnAng);
    translate(-myX, -myY, -myZ);
  }


  drawFloor();

  //draw exhibits

  //box
  pushMatrix();
  translate(e0x, e0y, e0z);
  scale(2);
  e0.drawExbt();
  popMatrix();

  //wave
  pushMatrix();
  translate(e1x, e1y, e1z);
  scale(0.5);
  e1.drawExbt();
  popMatrix();

  //flame
  pushMatrix();
  translate(e2x, e2y, e2z);
  scale(2);
  e2.drawExbt();
  popMatrix();

  //pendulum
  pushMatrix();
  translate(e3x, e3y, e3z);
  scale(2);
  e3.drawExbt();
  popMatrix();

  stroke(1);

  popMatrix();
}

void makeGrid() {


  for (int i=0; i<gridTotal; i++) {
    for (int j=0; j<gridTotal; j++) {
      grid[i][j][0] = (int)random(2);
      grid[i][j][1] = 3;
    }
  }  

  //box
  for (int i=box0[0]; i<box1[0]; i++) {
    for (int j=box0[1]; j<box1[1]; j++) {
      grid[gridSize+i][gridSize+j][1] = 7;
    }
  }

  //wave
  for (int i=wave0[0]; i<wave1[0]; i++) {
    for (int j=wave0[1]; j<wave1[1]; j++) {
      grid[gridSize+i][gridSize+j][1] = 7;
    }
  }  

  //flame
  for (int i=flame0[0]; i<flame1[0]; i++) {
    for (int j=flame0[1]; j<flame1[1]; j++) {
      grid[gridSize+i][gridSize+j][1] = 7;
    }
  }  

  //pendulum
  for (int i=pend0[0]; i<pend1[0]; i++) {
    for (int j=pend0[1]; j<pend1[1]; j++) {
      grid[gridSize+i][gridSize+j][1] = 7;
    }
  }
}

void drawFloor() {

  pushMatrix();
  translate(-0.5, -1, -0.5);

  for (int i = -gridSize; i<gridSize; i++) {
    for (int j = -gridSize; j<gridSize; j++) {



      int rand = (int)random(3);


      beginShape();
      noStroke();
      tint(1);
      int currI = i+gridSize;
      int currJ = j+gridSize;
      int text = grid[currI][currJ][0];
      float tnt = (grid[currI][currJ][1])/10f;
      tint(tnt);
      texture(floor[text]);

      vertex(i, 0, j, 0, 0);
      vertex(i+1, 0, j, 1, 0);
      vertex(i+1, 0, j+1, 1, 1);
      vertex(i, 0, j+1, 0, 1);
      endShape();

      if ( currI == 0) {
        drawWall(i, j, i, j+1);
      }
      if (currI == gridTotal-1) {
        drawWall(i+1, j, i+1, j+1);
      }

      if (currJ == 0) {
        drawWall(i, j, i+1, j);
      }
      if (currJ == gridTotal-1) {
        drawWall(i, j+1, i+1, j+1);
      }
    }
  }
  popMatrix();
}

void drawWall(int x0, int z0, int x1, int z1) {

  float h = 4;
  for (int i=0; i<h; i++) {
    beginShape();
    fill(0.5);
    tint(0.7);
    texture(wall);
    vertex(x0, i, z0, 0, 0);
    vertex(x0, i+1, z0, 0, 1);
    vertex(x1, i+1, z1, 1, 1);
    vertex(x1, i, z1, 1, 0);
    endShape();
  }
}

boolean isPath(float x, float z) {

  int xI = (int)(x+gridSize);
  int zI = (int)(z+gridSize);

  if (grid[xI][zI][1] == 7) {
    return false;
  }

  return true;
}

void move(int x) {
  float n = gridSize;

  if (dir == 0) { //north
    n = myZ + x;
    if (n > -gridSize && n < gridSize-1) { 
      if (isPath(myX, n)) {
        myZ = n;
      }
    }
  }
  if (dir == 1) { //east
    n = myX + x;
    if (n > -gridSize && n < gridSize-1) {
      if (isPath(n, myZ)) {   
        myX = n;
      }
    }
  }
  if (dir == 2) { //south
    n = myZ - x;
    if (n > -gridSize && n < gridSize-1) {
      if (isPath(myX, n)) {
        myZ = n;
      }
    }
  }
  if (dir == 3) { //west
    n = myX - x;
    if ( n > -gridSize && n < gridSize-1) {
      if (isPath(n, myZ)) {
        myX = n;
      }
    }
  }
}

void keyPressed() {

  if (key == 'r') {
    sky = !sky;
  }

  switch(key) {
  case 's': 

    move(1);
    break;
  case 'w':

    move(-1);
    break;
  case 'd':
    println("dir is:"+dir);
    dir += 1;
    println("added 1 to dir is:"+dir);
    dir = dir % 4;
    println("4 mod dir is:"+dir);
    break;
  case 'a':
    dir = dir-1;
    if (dir <= -1) {
      dir = 3;
    }
    break;
  }
  println("currXY: "+myX+","+myZ);
  println("currDir: "+dir);
}
