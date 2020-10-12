/** //<>// //<>// //<>// //<>//
 // Flame exhibit
 // rotating polygon with fading flame textures
 //
 **/
class E2 {

  PImage[] fire;
  int[][] face;
  PImage[] side;
  float tint0 = 0.97;
  float[] tint;
  float[] incT;
  float incMin = 0.001;
  float incMax = 0.003;


  float[][] gemXY;
  int numGems = 10;
  float tMin = -1;
  float tMax = 1;

  float rotY = 0;
  float rotZ = 0;
  float incY = 0.006;
  float incZ = 0;
  float rotMin = -0.005;
  float rotMax = -0.001;

  public E2() {

    noStroke();
    fill(1);

    fire = new PImage[6];
    face = new int[6][2];
    tint = new float[6];
    incT = new float[6];
    gemXY = new float[numGems][3];

    textureMode(NORMAL);
    fire[0] = loadImage("e2/fire0.png");
    fire[1] = loadImage("e2/fire1.png");
    fire[2] = loadImage("e2/fire2.png");
    fire[3] = loadImage("e2/fire3.png");
    fire[4] = loadImage("e2/fire4.png");
    fire[5] = loadImage("e2/fire5.png");

    for (int i=0; i<fire.length; i++) {
      face[i][0] = (int)random(6); 
      face[i][1] = (int)random(6);
      tint[i] = tint0;
      incT[i] = random(incMin, incMax);
    }

    for (int i=0; i<numGems; i++) {
      gemXY[i][0] = random(tMin, tMax);
      gemXY[i][1] = random(tMin, tMax);
      gemXY[i][2] = random(tMin, tMax);
    }
  }

  void drawExbt() {

    pushMatrix();
    rotateY(rotY);

    drawGem(0.2);


    popMatrix();

    fadeFire();

    rotY += incY;
  }



  void drawFire(float size) {


    scale(size);

    for (int i=0; i<numGems; i++) {

      pushMatrix();
      translate(gemXY[i][0], gemXY[i][1], gemXY[i][2]);
      drawGem(0.1);
      popMatrix();
    }
  }


  void drawGem(float size) {

    int x = 0;
    scale(size, (size*2.5), size);

    rotateX(PI/4);
    rotateZ(PI/4);



    //draw front index 0
    beginShape();
    fill(1);
    tint(1, tint0);
    texture(fire[face[0][0]]);
    vertex(-1, -1, 1, 0, 1);
    vertex(1, -1, 1, 1, 1);
    vertex(1, 1, 1, 1, 0);
    vertex(-1, 1, 1, 0, 0);
    endShape(CLOSE);

    beginShape();
    fill(1);
    tint(1, tint[0]);
    texture(fire[face[0][1]]);

    vertex(-1, -1, 1, 0, 1);
    vertex(1, -1, 1, 1, 1);
    vertex(1, 1, 1, 1, 0);
    vertex(-1, 1, 1, 0, 0);
    endShape(CLOSE);


    //draw back index 1
    beginShape();
    tint(1, tint0);
    texture(fire[face[1][0]]);
    vertex(-1, -1, -1, 0, 1);
    vertex(1, -1, -1, 1, 1);
    vertex(1, 1, -1, 1, 0);
    vertex(-1, 1, -1, 0, 0);
    endShape(CLOSE);
    beginShape();
    tint(1, tint[1]);
    texture(fire[face[1][1]]);
    vertex(-1, -1, -1, 0, 1);
    vertex(1, -1, -1, 1, 1);
    vertex(1, 1, -1, 1, 0);
    vertex(-1, 1, -1, 0, 0);
    endShape(CLOSE);

    //draw bottom left index 2
    beginShape();
    tint(1, tint0);
    texture(fire[face[2][0]]);
    vertex(-1, -1, -1, 0, 1);
    vertex(-1, -1, 1, 1, 1);
    vertex(-1, 1, 1, 1, 0);
    vertex(-1, 1, -1, 0, 0);
    endShape(CLOSE);
    beginShape();
    tint(1, tint[2]);
    texture(fire[face[2][1]]);
    vertex(-1, -1, -1, 0, 1);
    vertex(-1, -1, 1, 1, 1);
    vertex(-1, 1, 1, 1, 0);
    vertex(-1, 1, -1, 0, 0);
    endShape(CLOSE);

    //draw top right index 3
    beginShape();
    tint(1, tint0);
    texture(fire[face[3][0]]);
    vertex(1, -1, -1, 0, 1);
    vertex(1, -1, 1, 1, 1);
    vertex(1, 1, 1, 1, 0);
    vertex(1, 1, -1, 0, 0);
    endShape(CLOSE);
    beginShape();
    tint(1, tint[3]);
    texture(fire[face[3][1]]);
    vertex(1, -1, -1, 0, 1);
    vertex(1, -1, 1, 1, 1);
    vertex(1, 1, 1, 1, 0);
    vertex(1, 1, -1, 0, 0);
    endShape(CLOSE);

    //draw top left face 4
    beginShape();
    tint(1, tint0);
    texture(fire[face[4][0]]);
    vertex(-1, 1, 1, 0, 1);
    vertex(1, 1, 1, 1, 1);
    vertex(1, 1, -1, 1, 0);
    vertex(-1, 1, -1, 0, 0);
    endShape();
    beginShape();
    tint(1, tint[4]);
    texture(fire[face[4][1]]);
    vertex(-1, 1, 1, 0, 1);
    vertex(1, 1, 1, 1, 1);
    vertex(1, 1, -1, 1, 0);
    vertex(-1, 1, -1, 0, 0);
    endShape();

    //draw bottom right index 5
    beginShape();
    tint(1, tint0);
    texture(fire[face[5][0]]);
    vertex(-1, -1, 1, 0, 1);
    vertex(1, -1, 1, 1, 1);
    vertex(1, -1, -1, 1, 0);
    vertex(-1, -1, -1, 0, 0);
    endShape();
    beginShape();
    tint(1, tint[5]);
    texture(fire[face[5][1]]);
    vertex(-1, -1, 1, 0, 1);
    vertex(1, -1, 1, 1, 1);
    vertex(1, -1, -1, 1, 0);
    vertex(-1, -1, -1, 0, 0);
    endShape();
  }

  void fadeFire() {
    int x =0;
    for (int i=0; i<6; i++) {

      tint[i] -= incT[i];

      if (tint[i] <= 0) {
        face[i][1] = face[i][0];
        x = (int)random(6);
        while (x == face[i][0]) {
          x = (int)random(6);
        }
        face[i][0] = x;
        incT[i] = random(incMin, incMax);
        tint[i] = tint0;
      }
    }
  }
}
