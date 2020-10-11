/**
 // NAME    : Avalyn Jasenn
 // COURSE    : Computer Graphics
 // 
 // Code    :  All balls are generated with have a "lifespan", after which 
 //             they disappear for length of their "deathspan", at which time 
 //             a new random ball will be generated in it's place. On collision 
 //             the current colour colour of the slower ball will begin to 
 //             change to the current colour of the faster ball
 //
 **/
 
Ball[] balls = new Ball[9];
color[] colors = new color[10];

float v0 = 0.006; //initial x velocity
float v1 = 0.0008; //intitial y velocity

float m = 1; //mass
float d = 0.1; //diameter
float r = d/2; //radius

void setup() {
  size(640, 640, P3D);
  colorMode(RGB, 1);
  ortho(-1, 1, 1, -1);
  resetMatrix();

  //hint(DISABLE_OPTIMIZED_STROKE);

  //ball colours
  colors[0] = color(0, 100, 100);
  colors[1] = color(155, 0, 100);
  colors[2] = color(255, 66, 0);
  colors[3] = color(0, 0, 155);
  colors[4] = color(0, 93, 0);
  colors[5] = color(100, 0, 100);
  colors[6] = color(155, 200, 0);
  colors[7] = color(255, 0, 70);
  colors[8] = color(200, 0, 0);
  colors[9] = color(100, 30, 200);

  initBalls();
}

void draw() {
  background(0);

  for (int j = 0; j < balls.length; j++) {
    balls[j].drawBall();
  } 

  for (int i = 0; i < balls.length; i++) {
    balls[i].moveBall();
  }
}


//return new ball with given id with random xy && colors[]
Ball newBall(int id) {

  int c = int(random(colors.length));
  float[] vel = new float[2];
  vel[0] = v0;
  vel[1] = v1;
  float[] pos = new float[2];
  pos[0] = random((-1+r), (1-r));
  pos[1] = random((-1+r), (1-r)); 


  Ball ball = new Ball(pos, vel, m, d, colors[c], id);

  return ball;
}


//regenerate new ball to replace dead one
void regenBall(int id) {

  Ball ball = newBall(id);

  boolean hit = true;

  while (hit == true) {

    boolean hitBall = false;

    //check to make sure no collisions with existing balls
    for (int i=0; i<balls.length; i++) { 
      if (i != id) {
        if (ball.checkBallCollision(balls[i])) {
          hitBall = true;
        }
      }
      if (!hitBall && !ball.checkWallCollision()) {   
        //no collision, ball good
        hit = false;
      } else {
        //collision, create new random 
        ball = newBall(i);
      }
    }
    balls[id] = ball;
  }
  
  println("regenerate ball: ",id);
}


//create all initial balls
void initBalls() {

  for (int i =0; i<balls.length; i++) {

    Ball ball = newBall(i);

    boolean hit = true;

    while (hit == true) {

      boolean hitBall = false;

      //check to make sure no collisions with existing balls
      for (int j=0; j<i; j++) {     
        if (ball.checkBallCollision(balls[j])) {
          hitBall = true;
        }
      }
      if (!hitBall && !ball.checkWallCollision()) {   
        //no collision, ball good
        hit = false;
      } else {
        //collision, create new random 
        ball = newBall(i);
      }
    }
    balls[i] = ball;
  }
}




class Ball {
  int id;
  float lifespan; //time till ball death
  float deathspan; //time from death till ball regenerates
  float[] pos; //curr position
  float[] v; //velocity
  float m;  //mass
  float d;  //diameter
  float r;  //radius
  color rgb; //currColor
  color rgb0; //color start fade
  color rgb1; //color target fade
  float colorT; //colorLerp

  int collisionWith;

  float[] lerp0 = new float[2]; //initial point of lerp
  float[] lerp1 = new float[2]; //destination of lerp(at next hit intercept)
  float lerpI;  //lerp increment
  float lerpT; // current lerp point

  Ball (float[] pos, float[] v, float m, float d, color rgb, int id) {
    this.id = id;
    lifespan = random(10000);
    deathspan = random(1000);
    this.pos = pos;
    this.v = v;
    this.m = m;
    this.d = d;
    r = d/2;
    this.rgb = rgb;
    colorT = 1;
    int collisionWith = -1;
    setLerp();
  }

  public float posX() {
    return pos[0];
  }
  public float posY() {
    return pos[1];
  }
  public float vX() {
    return v[0];
  }
  public float vY() {
    return v[1];
  }
  public float rad() {
    return r;
  }
  public void setPosX(float x) {
    pos[0] = x;
  }
  public void setPosY(float y) {
    pos[1] = y;
  }
  public void setVX(float x) {
    v[0] = x;
  }
  public void setVY(float y) {
    v[1] = y;
  }
  public int ID() {
    return id;
  }
  public float mass() {
    return m;
  }
  public float[] vel() {
    return v;
  }
  //flag that collision has already been processed in frame
  public void hadCollision(int id) {
    collisionWith = id;
  }
  public color RGB() {
    return rgb;
  } 
  //set rgb to lerp fad to rgbFade
  public void fadeColor(color rgbFade) {
    rgb0 = rgb;
    rgb1 = rgbFade;
    colorT = 0;
  }
  //returns true if lifespan > 0
  boolean notDead() {
    if (lifespan <= 0) {
      return false;
    }
    return true;
  }

  //increment ball position and life/deathspan regeneration
  void moveBall() {
    //print("x was:",pos[0]," y was:",pos[1]);
    lifespan --;
    if (lifespan <= 0) { //ball dead
      if (deathspan <= 0) {
        regenBall(ID());//if death over, regenerate
      } else {
        if(deathspan == 0){
          println("kill ball: ",id);
        }
        deathspan --;
      }
    } else {
      checkWallCollision();

      //check for collisions with all alive balls
      for (int i = 0; i<balls.length; i++) {
        if (i != id && i != collisionWith) {
          checkBallCollision(balls[i]);
        }
      }
      collisionWith = -1; //reset collision flag

      //increment pos
      lerpT ++;
      float x = lerp(lerp0[0], lerp1[0], lerpT*lerpI);
      float y = lerp(lerp0[1], lerp1[1], lerpT*lerpI);
      setPosX(x);
      setPosY(y);
    }

    //print("new x:",pos[0]," new y:",pos[1]);
  }

  //set start and end point of lerp for current ball movement
  void setLerp() {
    //println("setLerp");
    float x = posX();
    float y = posY();
    float count = 0;
    lerp0[0] = x; 
    lerp0[1] = y;

    //find x or y intersection
    while (x > -1 && x < 1 && y > -1 && y < 1) {

      x += vX();
      y += vY();
      count ++;
    }

    lerp1[0] = x;
    lerp1[1] = y;
    lerpI = 1/count;
    lerpT = 0;
  }

  //check for collision with given ball
  boolean checkBallCollision(Ball b) {
    if (b.notDead()) { //if dead, don't check
      float d2 = abs(sq(posX()-b.posX())+sq(posY()-b.posY()));
      float radii2 = sq(rad()+b.rad());

      //if distance squared is less than radii squared, collision occured
      if (d2 < radii2) {
        println("collision: ball ", id, " & ", b.ID());
        handleCollision(b);
        return true;
      }
    }
    return false;
  }

  //transfers colorFade
  void swapColor(Ball b) {

    //slower v ball will fade to faster v color
    float v = (abs(vX())+abs(vY()))/2; //this v
    float bV = (abs(b.vX())+abs(b.vY()))/2; //other ball v

    if ( v > bV) {
      b.fadeColor(RGB());
    } else {
      fadeColor(b.RGB());
    }
  }

  //calculates and assigns changed velocities of ball collision
  void handleCollision(Ball b) {

    float[] xy0 = {posX(), posY()};
    float[] initV0 = vel();
    float m0 = mass();
    float[] xy1 = {b.posX(), b.posY()};
    float[] initV1 = b.vel();
    float m1 = b.mass();

    //set collision flag on other ball
    b.hadCollision(ID());
    swapColor(b);

    //find normal vector 
    float[] n = normalize(xy0, xy1);
    //find unit normal vector
    float[] un = findUnitNormVect(n);
    //find unit tangent vector 
    float[] ut = findUnitTanVect(un);

    //project velocities onto the unit normal and unit tangent vectors using dot product
    float projNorm0 = findDotProduct(un, initV0);
    float projTan0 = findDotProduct(ut, initV0);
    float projNorm1 = findDotProduct(un, initV1);
    float projTan1 = findDotProduct(ut, initV1);

    //post-collision normal velocities
    float n0 = (projNorm0*(m0-m1))+(2*m1*projNorm1);
    float d0 = m0+m1;
    float normVel0 = n0/d0;

    float n1 = (projNorm1*(m1-m0))+(2*m0*projNorm0);
    float d1 = m0+m1;
    float normVel1 = n1/d1;

    //convert into vectors
    float[] normVect0 = multiply(normVel0, un);
    float[] tanVect0 = multiply(projTan0, ut);
    float[] normVect1 = multiply(normVel1, un);
    float[] tanVect1 = multiply(projTan1, ut);

    //calc final velocities by adding normal and tangent vectors for each
    float[] v0 = add(normVect0, tanVect0);
    float[] v1 = add(normVect1, tanVect1); 

    setVX(v0[0]);
    setVY(v0[1]);
    setLerp();
    b.setVX(v1[0]);
    b.setVY(v1[1]);
    b.setLerp();
    println();
  }

  //return normalize of the given vector
  float[] normalize(float[] v0, float[] v1) {

    float[] normalV = {(v1[0]-v0[0]), (v1[1]-v0[1])};
    //println("normalized: (", v0[0], ",", v0[1], ")(", v1[0], ",", v1[1], ")");
    //println("  to: (", normalV[0], ",", normalV[1], ")");
    return normalV;
  }

  //return unit normal for the normal vector
  float[] findUnitNormVect(float[] n) {

    float d = sqrt((n[0]*n[0]) + (n[1]*n[1]));
    float[] un = {(n[0]/d), (n[1]/d)};
    //println("Unit normal vector for: (", n[0], ",", n[1], ")");
    //println("  is: (", un[0], ",", un[1], ")");
    return un;
  }

  //return unit tangent vector for given normal vector
  float[] findUnitTanVect(float[] un) {
    float[] ut = {-un[1], un[0]};
    //println("Unit tangent vector for: (", un[0], ",", un[1], ")");
    //println("  is: (", ut[0], ",", ut[1], ")");     
    return ut;
  }

  //return dot product of the two given vectors
  float findDotProduct(float[] v0, float[] v1) {

    float dot = (v0[0]*v1[0]) + (v0[1]*v1[1]);
    //println("dot product for: (", v0[0], ",", v0[1], ")(", v1[0], ",", v1[1], ")");
    //println("  is: ", dot);   
    return dot;
  }

  //return product of given scalar and vector
  float[] multiply(float s, float[] v) {

    float[] v0 = {(s*v[0]), (s*v[1])};
    //println("multiply scaler: ", s, " with vector: (", v[0], ",", v[1], ")");
    //println("  for: (", v0[0], ",", v0[1], ")");
    return v0;
  }

  //return sum of given vectors
  float[] add(float[] v0, float[] v1) {

    float[] x = {(v0[0]+v1[0]), (v0[1]+v1[1])};
    //println("add vector : (", v0[0], ",", v0[1], ") with vector: (", v1[0], ",", v1[1], ")");
    //println("  for: (", x[0], ",", x[1], ")");
    return x;
  }

  //returns true if ball collided with any border & inverts velocity
  boolean checkWallCollision() {

    boolean collide = false;

    if (posX() >= (1-r)) {
      setVX(vX() * -1);
      collide = true;
    }
    if (posX() <= (-1+r)) {
      setVX(vX() * -1);
      collide = true;
    }
    if (posY() >= (1-r)) {
      setVY(vY() * -1);
      collide = true;
    }
    if (posY() <= (-1+r)) {
      setVY(vY() * -1);
      collide = true;
    }
    if (collide) {
      setLerp();
    }

    return collide;
  }

  //draw ball and lerp color
  void drawBall() {
    if (lifespan > 0) {
      if (colorT < 1) {
        colorT += 0.001;
        rgb = lerpColor(rgb0, rgb1, colorT);
      }
      fill(rgb);
      ellipse(posX(), posY(), d, d);
    }
  }
}
