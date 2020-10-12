/** //<>// //<>// //<>// //<>// //<>// //<>//
 // Box exhibit
 // rotating box with center vertices on each side that move in and out
 //
 **/
class E0 {
  PImage door0, door1, door2, door3, door4, door5, door6;


  float rot = 0;
  float rot0 = PI;
  float mid = 1;
  float rotX = 0;
  float rotY = 0;
  float rotZ = 0;
  float inc = 0.001;
  float incX = 0.001;
  float incY = 0.0007;
  float incZ = 0;

  boolean inflate = true;

  float[][] back = {{-1, 1, 1}, {1, 1, 1}, {1, -1, 1}, {-1, -1, 1}, {0, 0, 1}}; //begin bottom left, counterclockwise, last is centre
  float[][] front = {{-1, 1, -1}, {1, 1, -1}, {1, -1, -1}, {-1, -1, -1}, {0, 0, -1}};
  float[][] left = {front[0], back[0], back[3], front[3], {-1, 0, 0}};
  float[][] right = {back[1], front[1], front[2], back[2], {1, 0, 0}};
  float[][] bottom = {front[0], front[1], back[1], back[0], {0, 1, 0}};
  float[][] top = {front[2], front[3], back[3], back[2], {0, -1, 0}};
  
  //create float arrays with coordinates for square vertices

  float eyeX = 0, eyeY = 0, eyeZ = 0, centerX = 0, centerY = 0, centerZ = -2, upX = 0, upY = 1, upZ = 0;

  public E0() {

    textureMode(NORMAL);
    door0 = loadImage("e0/door0.png"); //front
    door1 = loadImage("e0/door1.png"); //top
    door2 = loadImage("e0/door2.png"); //back
    door3 = loadImage("e0/door3.png"); //left
    door4 = loadImage("e0/door4.png"); //right
    door5 = loadImage("e0/door7.png"); 
    door6 = loadImage("e0/door8.png");
  }


  void drawExbt() {

    noStroke();

    if (rot >= 2*PI) {
      rot = 0;
    }
    pushMatrix();
    //translate(0, 0, -4);


    rotateX(rotX);
    rotateY(rotY);
    rotateZ(rotZ);
    drawCube0(0.25);

    popMatrix();

    moveMid(0.001);
    rotX += incX;
    rotY += incY;
    rotZ += incZ;
  }


  void moveMid(float inc) {
    if (inflate) {

      if (mid <= 2) {
        mid += inc;
      } else {
        inflate = false;
      }
    } else {

      if (mid > 2*inc) {
        mid -= inc;
      } else {
        inflate = true;
      }
    }
  }

  void drawCube0(float size) {

    rotateX(PI/2);
    scale(size);

    //draw back
    beginShape(TRIANGLE_FAN);
    //fill(0,0,1);
    tint(1);
    texture(door2);
    vertex(back[4][0]*mid, back[4][1]*mid, back[4][2]*mid, 0.5, 0.5);
    vertex(back[0][0], back[0][1], back[0][2], 0, 1);
    vertex(back[1][0], back[1][1], back[1][2], 1, 1);  
    vertex(back[2][0], back[2][1], back[2][2], 1, 0);  
    vertex(back[3][0], back[3][1], back[3][2], 0, 0); 
    vertex(back[0][0], back[0][1], back[0][2], 0, 1);
    endShape();

    //draw front
    beginShape(TRIANGLE_FAN);
    //fill(1,0,0);
    texture(door4);
    vertex(front[4][0]*mid, front[4][1]*mid, front[4][2]*mid, 0.5, 0.5);
    vertex(front[0][0], front[0][1], front[0][2], 0, 1);
    vertex(front[1][0], front[1][1], front[1][2], 1, 1);
    vertex(front[2][0], front[2][1], front[2][2], 1, 0);
    vertex(front[3][0], front[3][1], front[3][2], 0, 0);
    vertex(front[0][0], front[0][1], front[0][2], 0, 1);
    endShape();

    //draw left
    beginShape(TRIANGLE_FAN);
    //fill(0,1,1);
    texture(door3);
    vertex(left[4][0]*mid, left[4][1]*mid, left[4][2]*mid, 0.5, 0.5);
    vertex(left[0][0], left[0][1], left[0][2], 0, 1);
    vertex(left[1][0], left[1][1], left[1][2], 1, 1);
    vertex(left[2][0], left[2][1], left[2][2], 1, 0);
    vertex(left[3][0], left[3][1], left[3][2], 0, 0);
    vertex(left[0][0], left[0][1], left[0][2], 0, 1);
    endShape();

    //draw right
    beginShape(TRIANGLE_FAN);
    //fill(1,1,0);
    texture(door1);
    vertex(right[4][0]*mid, right[4][1]*mid, right[4][2]*mid, 0.5, 0.5);
    vertex(right[0][0], right[0][1], right[0][2], 0, 1);
    vertex(right[1][0], right[1][1], right[1][2], 1, 1);
    vertex(right[2][0], right[2][1], right[2][2], 1, 0);
    vertex(right[3][0], right[3][1], right[3][2], 0, 0);
    vertex(right[0][0], right[0][1], right[0][2], 0, 1);
    endShape();

    //draw top
    beginShape(TRIANGLE_FAN);
    //fill(1,0,1);
    texture(door5);
    vertex(top[4][0]*mid, top[4][1]*mid, top[4][2]*mid, 0.5, 0.5);
    vertex(top[0][0], top[0][1], top[0][2], 0, 1);
    vertex(top[1][0], top[1][1], top[1][2], 1, 1);
    vertex(top[2][0], top[2][1], top[2][2], 1, 0);
    vertex(top[3][0], top[3][1], top[3][2], 0, 0);
    vertex(top[0][0], top[0][1], top[0][2], 0, 1);
    endShape();

    //draw bottom
    beginShape(TRIANGLE_FAN);
    //fill(0.5,0.5,0);
    texture(door6);
    vertex(bottom[4][0]*mid, bottom[4][1]*mid, bottom[4][2]*mid, 0.5, 0.5);
    vertex(bottom[0][0], bottom[0][1], bottom[0][2], 0, 1);
    vertex(bottom[1][0], bottom[1][1], bottom[1][2], 1, 1);
    vertex(bottom[2][0], bottom[2][1], bottom[2][2], 1, 0);
    vertex(bottom[3][0], bottom[3][1], bottom[3][2], 0, 0);
    vertex(bottom[0][0], bottom[0][1], bottom[0][2], 0, 1);
    endShape();
  }

  void drawCubeFace(float size) {

    scale(size);
    beginShape(TRIANGLE_FAN);
    vertex(back[4][0], back[4][1], back[4][2]);
    fill(1, 0, 0);
    vertex(back[0][0], back[0][1], back[0][2]);
    fill(0, 1, 0);
    vertex(back[1][0], back[1][1], back[1][2]);  
    fill(0, 0, 1);
    vertex(back[2][0], back[2][1], back[2][2]); 
    fill(0.5, 0.5, 0);
    vertex(back[3][0], back[3][1], back[3][2]); 
    fill(0, 0.5, 0.5);
    vertex(back[0][0], back[0][1], back[0][2]);
    endShape();
  }


  void drawCube(float size) {

    //right top and bottom rotate around x axis

    scale(size);

    beginShape(QUADS);

    fill(255, 0, 0);
    vertex(-1, -1, 1);
    vertex(-1, 1, 1);
    vertex(1, 1, 1);
    vertex(1, -1, 1);

    fill(0, 255, 0);
    vertex(1, -1, 1);
    vertex(1, -1, -1);
    vertex(1, 1, -1);
    vertex(1, 1, 1);

    fill(0, 0, 255);
    vertex(1, -1, -1);
    vertex(-1, -1, -1);
    vertex(-1, 1, -1);
    vertex(1, 1, -1);

    fill(0, 255, 255);
    vertex(-1, -1, -1);
    vertex(-1, -1, 1);
    vertex(-1, 1, 1);
    vertex(-1, 1, -1);

    fill(255, 0, 255);
    vertex(-1, 1, 1);
    vertex(1, 1, 1);
    vertex(1, 1, -1);
    vertex(-1, 1, -1);

    fill(255, 255, 0);
    vertex(1, -1, 1);
    vertex(-1, -1, 1);
    vertex(-1, -1, -1);
    vertex(1, -1, -1);

    endShape();
  }
}
