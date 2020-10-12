/** //<>// //<>//
 // Pendulum Star exhibit
 // swinging pendulum leaves trail of disappearing orbs through circle
 //
 **/

class E3 {
  PImage light0, light1, light2;

  float[] m = {0, 0, -1};
  float[] l = {-0.3, 0.3, 0};
  float[] r = {0.3, 0.3, 0};
  float[] b = {0, -0.3, 0};

  float rotX = 0;
  float rotY = 0;
  float rotZ = 0;
  float incX = 0.001;
  float incY = 0.001;
  float incZ = 0.03;

  float wRotY = 0;


  float currX;
  float currY;
  float x0; //init x pos
  float y0; //init y pos
  float x1; //next x pos
  float y1; //next y pos
  float z; //z plane
  float radius = 0.7;
  float a = 0;
  float t = 0;
  float aInc = 0.35;
  float tInc = 0.008;
  float testNum = 3;


  ArrayList<Orb> Orbs = new ArrayList<Orb>();
  float[] timeXY0 = new float[2];
  float[] timeXY1 = new float[2];
  float timeD = 0.21;
  float[][] orbColor = {{0.5, 0.9, 1}, {0.82, 0.3, 1}, {1, 1, 0.3}};

  float eyeX = 0, eyeY = 0, eyeZ = 0, centerX = 0, centerY = 0, centerZ = -2, upX = 0, upY = 1, upZ = 0;

  public E3() {
    textureMode(NORMAL);
    light0 = loadImage("e3/light0.png");
    light1 = loadImage("e3/light1.png");
    light2 = loadImage("e3/light2.png");
    //initialize pendulum coords
    x0 = (float)(radius * Math.cos(a * 2 * PI));
    y0 = (float)(radius * Math.sin(a * 2 * PI));
    currX = x0;
    currY = y0;
    a += aInc;
    x1 = (float)(radius * Math.cos(a * 2 * PI));
    y1 = (float)(radius * Math.sin(a * 2 * PI));
    a+= aInc;

    timeXY0[0] = x0;
    timeXY0[1] = y0;
  }


  void drawExbt() {
    pushMatrix();
    rotateX(-PI/3);
    rotateY(wRotY);
    drawOrbs();
    movePendulum();
    popMatrix();    

    wRotY -= 0.0003;
  }

  void movePendulum() {


    if (t >= 1) {   

      x0 = x1;
      y0 = y1;

      x1 = (float)(radius * Math.cos(a * 2 * PI));
      y1 = (float)(radius * Math.sin(a * 2 * PI));

      a += aInc;
      t = 0;
    }

    currX = lerp(x0, x1, t);
    currY = lerp(y0, y1, t);

    float dis = abs(dist(timeXY0[0], timeXY0[1], currX, currY));
    float[] rgb = {1, 1, 1};

    if (dis >= timeD) {
      Orb ball = new Orb(currX, currY, 0.011);
      Orbs.add(ball);
      timeXY0[0] = currX;
      timeXY0[1] = currY;
    }

    pushMatrix();
    translate(currX, currY);
    drawPendulum(0.2);
    popMatrix();

    t += tInc;
  }

  void drawOrbs() {

    for (int i=0; i<Orbs.size(); i++) {
      Orb curr = Orbs.get(i);    
      if (curr.shrink()) {
        curr.drawOrb();
      } else {
        Orbs.remove(i);
      }
    }
  }

  void drawPendulum(float size) {

    rotateZ(rotZ);
    scale(size);

    drawPyramid(1, 0);
    pushMatrix();
    rotateY(PI);
    drawPyramid(1, 1);
    popMatrix();

    pushMatrix();
    rotateY(PI/2);

    drawPyramid(1, 0);
    pushMatrix();
    rotateY(PI);
    drawPyramid(1, 1);
    popMatrix();  
    popMatrix();
    rotX += incX;
    rotY += incY;
    rotZ += incZ;
  }


  void drawPyramid(float size, float c) {
    scale(size);
    //draw top
    beginShape();
    fill(1, 0, c);
    tint(1);
    texture(light1);
    vertex(m[0], m[1], m[2], 0.5, 1);
    vertex(l[0], l[1], l[2], 0, 0);
    vertex(r[0], r[1], r[2], 1, 0);
    endShape(CLOSE);
    //draw right
    beginShape();
    fill(0.5, 0, c);
    texture(light2);
    vertex(m[0], m[1], m[2], 0.5, 1);
    vertex(r[0], r[1], r[2], 0, 0);
    vertex(b[0], b[1], b[2], 1, 0);
    endShape(CLOSE);
    ////draw left
    beginShape();
    fill(0, c, 1);
    texture(light0);
    vertex(m[0], m[1], m[2], 0.5, 1);
    vertex(b[0], b[1], b[2], 0, 0);
    vertex(l[0], l[1], l[2], 1, 0);
    endShape(CLOSE);
  }


  class Orb {

    float x;
    float y;
    float radius;
    float[] rgb = new float[3];
    float fade;

    Orb (float x, float y, float radius) {
      this.x = x;
      this.y = y;
      rgb = orbColor[0];
      this.radius = radius;
      float fade = 1;
    }

    void drawOrb() {
      fill(rgb[0], rgb[1], rgb[2]);
      stroke(rgb[0], rgb[1], rgb[2]);
      pushMatrix();
      translate(x, y);
      sphere(radius);
      popMatrix();
    }

    boolean shrink() {
      radius -= 0.00004;
      if (radius > 0) {
        return true;
      }
      return false;
    }
  }
}
