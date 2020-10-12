/**
 // Wave exhibit
 // animated sin wave of spinning triads
 // 
 // copyright: material was referenced and code adapted to create the motion for this exhibit
 //  rights of the referenced code belong to Daniel Shiffman
 //  referenced code can be found at : https://processing.org/examples/sinewave.html
 //
 **/

class E1 {
  PImage text0;
  int xspacing = 50;   // spacing between orbs
  int w;              // width of wave

  float theta = 0.0;  // angle
  float amplitude = 90.0;  // Height of wave
  float period = 600.0;  // frequency
  float dx;  // incX
  float[] yvalues;  // current wave values
  float rot = 0;
  float rotInc = 0.001;

  float eyeX = 0, eyeY = 0, eyeZ = 0, centerX = 0, centerY = 0, centerZ = 0, upX = 0, upY = 0, upZ = 0;
  boolean view = true;

  public E1() {

    w = width+16;
    dx = (TWO_PI / period) * xspacing;
    yvalues = new float[w/xspacing];

    textureMode(NORMAL);
    text0 = loadImage("e1/text2.png");
  }


  void drawExbt() {

    pushMatrix();
    rotateY(PI/2);
    scale(0.015);
    calcWave();
    renderWave(1);  
    popMatrix();
  }

  void calcWave() {
    // Increment angle
    theta += 0.02;

    // For every x val for each y val
    float x = theta;
    for (int i = 0; i < yvalues.length; i++) {
      yvalues[i] = sin(x)*amplitude;
      x+=dx;
    }
  }

  void renderWave(int shape) {
    noStroke();
    fill(1);

    pushMatrix();
    translate(0, 0, -100);
    for (int x = 0; x < yvalues.length; x++) {
      pushMatrix();
      translate(x*xspacing, 640/2+yvalues[x]);
      rot = rot%(2*PI);
      if (shape == 0) {//draw spheres
        sphere(8);
      }
      if (shape == 1) { //draw triangles

        rotateZ(rot);
        scale(5);
        beginShape(TRIANGLES);
        texture(text0);
        vertex(-9, 0, 0, 0, 1);
        vertex(9, 0, 0, 0.5, 0);
        vertex(0, 18, 0, 1, 1);

        vertex(-9, 0, 0, 1, 1);
        vertex(0, 0, -18, 0, 1);
        vertex(0, 18, 0, 0.5, 0);

        vertex(-9, 0, 0, 0.5, 0);
        vertex(0, 0, -18, 0, 1);
        vertex(9, 0, 0, 1, 1);

        vertex(9, 0, 0, 1, 1);
        vertex(0, 0, -18, 0.5, 0);
        vertex(0, 18, 0, 0, 1);
        endShape();
      }
      if (shape == 2) { //draw cubes
        rotateX(rot);
        drawCube(8);
      }
      popMatrix();
      rot+= rotInc;
    }
    popMatrix();
  }


  void drawCube(float size) {

    pushMatrix();
    scale(size, size, size);
    beginShape(QUADS);

    fill(1, 0.5, 0);
    vertex(-1, -1, 1);
    vertex(-1, 1, 1);
    vertex(1, 1, 1);
    vertex(1, -1, 1);

    fill(1, 0.25, 0.25);
    vertex(1, -1, 1);
    vertex(1, -1, -1);
    vertex(1, 1, -1);
    vertex(1, 1, 1);

    fill(0.5, 0.75, 1);
    vertex(1, -1, -1);
    vertex(-1, -1, -1);
    vertex(-1, 1, -1);
    vertex(1, 1, -1);

    fill(0.5, 0.5, 0.75);
    vertex(-1, -1, -1);
    vertex(-1, -1, 1);
    vertex(-1, 1, 1);
    vertex(-1, 1, -1);

    fill(0.8, 0.5, 0.5);
    vertex(-1, 1, 1);
    vertex(1, 1, 1);
    vertex(1, 1, -1);
    vertex(-1, 1, -1);

    fill(0.9, 1, 0.2);
    vertex(1, -1, 1);
    vertex(-1, -1, 1);
    vertex(-1, -1, -1);
    vertex(1, -1, -1);

    endShape();
    popMatrix();
  }
}
