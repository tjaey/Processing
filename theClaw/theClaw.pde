/**
 // NAME    : Avalyn Jasenn
 // COURSE    : Computer Graphics
 //
 // Code     :   3D Interactive Claw
 //             Press 'n' to switch between claw/perspective 
 //             controls and camera placement controls
 //            
 //              >claw controls, single key press to will begin movement, pressing key again will stop movement:
 //                    x = open claw
 //                    c = close claw
 //                    s = rotate claw left
 //                    d = rotate claw right
 //                    a = cable up
 //                    z = cable down
 //                    q = rotate arm right
 //                    w = rotate arm left
 //                    e = move arm claw out
 //                    r = move arm claw in
 //
 //                    p = perspective
 //                    o = orthagonal
 //                
 //                    1 = straight view
 //                    2 = above view
 //                    3 = below view
 //
 //            >camera placement controls
 //                    q = eyeX +
 //                    a = eyeX -
 //                    w = eyeY +
 //                    s = eyeY -
 //                    e = eyeZ +
 //                    d = eyeZ -
 //                    r = centerX +
 //                    f = centerX -
 //                    t = centerY +
 //                    g = centerY -
 //                    y = centerZ +
 //                    h = centerZ -
 //                    u = upX +
 //                    j = upX -
 //                    i = upY +
 //                    k = upY -
 //                    o = upZ +
 //                    l = upZ -
 //
 **/


float eyeX = 0, eyeY = 0, eyeZ = 0, centerX = 0, centerY = 0, centerZ = -2, upX = 0, upY = 1, upZ = 0;
int view = 1; //change control keys
boolean perspective = false;
boolean open = false;
boolean lower = false;
boolean close = false;
boolean lift = false;
boolean animateClaw = false;

//view 1
float[] eye1    = { 0.0, 0.0, 0.0};
float[] center1 = {0.0, 0.0, -2.0};
float[] up1     = {0.0, 1.0, 0.0};

float[] eye2    = { 0.0, 1.6, -0.5};
float[] center2 = {0.0, 0.0, -2.0};
float[] up2     = {0.0, 1.0, 0.0};

float[] eye3    = { 1.7, -0.7, -0.5};
float[] center3 = {0.0, 0.0, -2.0};
float[] up3     = {0.0, 1.0, 0.0};

int cameraCurr = 1;

float[] mountXY = {0,0.8,-2};
//float[] mountSc = {0.1,0.1,0.1};
float mountH = 0.2;
float mountW = 0.6;
float mountD = 0.2;

//float[] armSc = {0.5,0.5,0.5};
float armH = 0.1;
float armW = 1.5;
float armD = 0.1;
float armMin = -armW/4;
float armMax = armW/4;
float armT = 5.5;
float armCurr = 0;
float[] armXY = {armCurr,-(mountH/2)-(armH/2),0}; //translation from mount
float armRotA = 0;
float armRotT = 0;
int armCurrMove = 0; //0 if not currently moving
int armCurrRot = 0; //0 if not currently rotating

//top cube for claw cable
float cube0H = 0.2;
float cube0W = 0.2;
float cube0D = 0.2;
float[] cube0XY = {(-armW/2)+cube0W/2,-(armH/2)-(cube0H/2),0};

//claw cable
float cableMin = 2*cube0H; //minimum length of cable
float cableMax = 0.9;
float cableL = cableMax;
float cableT = 10;
float[] cableXY = {0,0,0}; //no translation from cube
int cableCurrMove = 0; //0 if not currently moving

//bottom cube for claw arm
float cube1H = 0.2;
float cube1W = 0.2;
float cube1D = 0.2;
float[] cube1XY = {0,-cableL,0};

//claw
float claw0W = 0.07;
float claw0L = 0.27;
float claw0D = 0.1;
float[] claw0XY = {0,0,0}; //no translation from cube1
float claw0A = QUARTER_PI*0.7;
float jointD = 0.05;
float[] jointXY = {0,-claw0L,0};
float claw1L = 0.22;
float[] claw1XY = {0,0,0}; //no translation from sphere
float clawClose = -(claw0A*2)+0.05; //rotate back t
float clawOpen = -(claw0A*2)+0.8;
float clawCurrA = clawClose;
float clawCurrT = 0;
float clawRotA = 0; //rotation of claw
float clawRotT = 0;
int clawCurrRot = 0; // 0 if not currently rotating
int clawCurrAng = 0; // 0 if not currently moving claws




void setup() {
  size(640, 640, P3D);
  //hint(DISABLE_OPTIMIZED_STROKE);
}


void draw(){
  //background(0);
  if(perspective){
    frustum(-1, 1, 1, -1, 1, 8);
  }
  else{
    ortho(-1, 1, 1, -1, 1, 8);
  }
    
  clear();
  resetMatrix();
  camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);
  
  stroke(255,255,255);
  fill(100,100,100);
  translate(mountXY[0],mountXY[1],mountXY[2]);
  scale(0.8,0.8,0.8);
  drawPrizes();
  drawMount();
  rotateY(armRotA);
  translate(armCurr,armXY[1],armXY[2]);
  drawArm();
  
  translate(cube0XY[0],cube0XY[1],cube0XY[2]);
  fill(100,0,150);
  drawCube0();
  drawCable();
  
  translate(cube1XY[0],-cableL,cube1XY[2]);
  drawCube1();
  
  translate(claw0XY[0],claw0XY[1],claw0XY[2]);
  pushMatrix();
  drawClaw();
  popMatrix();
  rotateY(PI);
  drawClaw();
  translate(0,-0.5,0);
 // sphere(0.1);
 //drawPrizes();
    
  if(animateClaw){   
    initClaw();
  }
  else{
    manualMove();
  }
  
}

void manualMove(){
  if(clawCurrAng == 1){
      autoOpen();
    }
  else if(clawCurrAng == -1){
      autoClose();
  }
  
  if(cableCurrMove == 1){
    autoLower();
  }
  else if(cableCurrMove == -1){
    autoLift();
  }
  
  if(armCurrMove == 1){
    autoArmRight();
  }
  else if(armCurrMove == -1){
    autoArmLeft();
  }
  
  if(clawCurrRot == 1){
    autoClawRotate(1);
  }
  else if(clawCurrRot == -1){
    autoClawRotate(-1);
  }
  
  if(armCurrRot == 1){
    autoArmRotate(1);
  }
  else if(armCurrRot == -1){
    autoArmRotate(-1);
  }
  
}


void drawPrizes(){
 
  float y = -(mountH+armH+cube0H+cableMax+cube1H+claw1L*2);
  float h = 0;
  
  //green ball
  pushMatrix();
  h = 0.2;
  translate(-0.2,y+h/2,0.2);
  fill(0,255,0);
  stroke(0,255,0);
  sphere(0.1);
  popMatrix();
  
  //pink box
  pushMatrix();
  h = 0.15;
  translate(0.4,y+h/2,0.4);
  fill(255,0,255);
  box(0.1,0.15,0.1);
  popMatrix();
  
  //lime green ball
  h = 0.12;
  pushMatrix();
  translate(-0.8,y+h/2,-0.4);
  fill(155,255,0);
  stroke(155,255,0);
  sphere(0.06);
  popMatrix();
  
  //yellow ball
  h = 0.16;
  pushMatrix();
  translate(0.8,y+h/2,-0.26);
  fill(255,255,0);
  stroke(255,255,0);
  sphere(0.08);
  popMatrix();
  
  //blue box
  h = 0.09;
  pushMatrix();
  translate(0.2,y+h/2,-0.45);
  rotateY(PI/3);
  fill(70,0,255);
  box(0.15,0.09,0.16);
  popMatrix();
  
  //teal box
  pushMatrix();
  h = 0.1;
  translate(-0.5,y+h/2,0.45);
  rotateY(-PI/3.2);
  fill(0,155,255);
  box(0.17,0.1,0.11);
  popMatrix();
  
  
  stroke(255);
}


void drawMount(){  
  fill(255,0,230);
  box(mountW,mountH,mountD);
}


void drawArm(){
 fill(0,255,0);
 box(armW,armH,armD);
}

void drawCube0(){
 rotateY(clawRotA); 
 box(cube0W,cube0H,cube0D); 
}

void drawCube1(){
  box(cube1W,cube1H,cube1D);
}

void drawCable(){
  strokeWeight(3);
  stroke(150);
  beginShape(LINES);
  vertex(0,0,0);
  vertex(0,-cableL,0);
  endShape();
  strokeWeight(1);  
}

void drawClaw(){
  
  rotateZ(claw0A);

  float x = claw0W/2;
  float y = claw0L;
  float z = claw0D/2;
  
  beginShape(QUADS);
  //back
  fill(255,255,0);
  vertex(-x,0,z);
  vertex(-x,-y,z);
  vertex(x,-y,z);
  vertex(x,0,z);
  //front
  fill(0,255,255);
  vertex(-x,0,-z);
  vertex(-x,-y,-z);
  vertex(x,-y,-z);
  vertex(x,0,-z);
  //top
  fill(0,0,255);
  vertex(-x,0,z);
  vertex(-x,0,-z);
  vertex(x,0,-z);
  vertex(x,0,z);
  //bottom
  fill(255,0,255);
  vertex(-x,-y,z);
  vertex(-x,-y,-z);
  vertex(x,-y,-z);
  vertex(x,-y,z);
  //left
  fill(125,125,125);
  vertex(-x,0,z);
  vertex(-x,0,-z);
  vertex(-x,-y,-z);
  vertex(-x,-y,z);
  //right
  fill(0,255,0);
  vertex(x,0,z);
  vertex(x,0,-z);
  vertex(x,-y,-z);
  vertex(x,-y,z);
  
  endShape();
  
  //draw joint
  stroke(120,0,175);
  translate(jointXY[0],jointXY[1],jointXY[2]);
  sphere(jointD);
  stroke(150);
  y = claw1L;
  
  rotateZ(clawCurrA);
  beginShape(QUADS);
  //back
  fill(255,255,0);
  vertex(-x,0,z);
  vertex(-x,-y,z);
  vertex(x,-y,z);
  vertex(x,0,z);
  //front
  fill(0,255,255);
  vertex(-x,0,-z);
  vertex(-x,-y,-z);
  vertex(x,-y,-z);
  vertex(x,0,-z);
  //top
  fill(0,0,255);
  vertex(-x,0,z);
  vertex(-x,0,-z);
  vertex(x,0,-z);
  vertex(x,0,z);
  //bottom
  fill(255,0,255);
  vertex(-x,-y,z);
  vertex(-x,-y,-z);
  vertex(x,-y,-z);
  vertex(x,-y,z);
  //left
  fill(125,125,125);
  vertex(-x,0,z);
  vertex(-x,0,-z);
  vertex(-x,-y,-z);
  vertex(-x,-y,z);
  //right
  fill(0,255,0);
  vertex(x,0,z);
  vertex(x,0,-z);
  vertex(x,-y,-z);
  vertex(x,-y,z);
  
  endShape();  
}


void autoClawRotate(int d){
  
  println("autoClawRotate");
  float frames = 260;
  float inc = 10/frames;
    
  clawRotT += d*inc;
    
    if(clawRotT >= 10){
      clawRotT = 0;
    }
    if(clawRotT <= -1){
      clawRotT = 9;
    }
    
    clawRotA = lerp(0,2*PI,clawRotT/10);

}
  

void autoArmRotate(int d){
  
  println("autoArmRotate");
  float frames = 350;
  float inc = 10/frames;
    
  armRotT += d*inc;
    
    if(armRotT >= 10){
      armRotT = 0;
    }
    if(armRotT <= -1){
      armRotT = 9;
    }
    
    armRotA = lerp(0,2*PI,armRotT/10);

}

boolean autoArmLeft(){
  println("autoArmLeft");
  float frames = 220;
  float inc = 10/frames;
  
  if(armT > 0){
    armT -= inc;
    armCurr = lerp(armMin,armMax,armT/10);
    return false;
  }
  
  armT = 0;
  //lower = true;
  armCurrMove = 0;
  println("arm left");
  return true;    
  
}

boolean autoArmRight(){
  println("autoArmRight");
  float frames = 220;
  float inc = 10/frames;
  
  if(armT < 10){
    armT += inc;
    armCurr = lerp(armMin,armMax,armT/10);
    return false;
  }
  
  armT = 10;
  //lower = true;
  armCurrMove = 0;
  println("arm right");
  return true;    
  
}

void initClaw(){
  
  animateClaw = true;
  
  if(!open){
    autoOpen();
  }
  else if(!lower){
    autoLower();
  }
  else if(!close){
    autoClose();
  }
  else if(!lift){
    autoLift();
  }
  else{
    println("done animation");
    animateClaw = false;
    open = false;
    lower = false;
    close = false;
    lift = false;
  }
 
  
}

boolean autoOpen(){
  
  println("autoOpen");
  float frames = 120;
  float inc = 10/frames;
  
  if(clawCurrT < 10){
    clawCurrT += inc;
    clawCurrA = lerp(clawClose,clawOpen,clawCurrT/10); 
    return false;
  }
  
  clawCurrT = 10;
  open = true;
  clawCurrAng = 0;
  println("claw open");
  return true;
  
}

boolean autoLower(){
  
  println("autoLower");
  float frames = 120;
  float inc = 10/frames;
  
  if(cableT < 10){
    cableT += inc;
    cableL = lerp(cableMin,cableMax,cableT/10);
    return false;
  }
  
  cableT = 10;
  lower = true;
  cableCurrMove = 0;
  println("claw lowered");
  return true;
}

boolean autoClose(){

  println("autoClose");
  float frames = 120;
  float inc = 10/frames;
  
  if(clawCurrT > 0){
    clawCurrT -= inc;
    clawCurrA = lerp(clawClose,clawOpen,clawCurrT/10); 
    return false;
  }
  
  clawCurrT = 0;
  close = true;
  clawCurrAng = 0;
  println("claw close");
  return true;  
}

boolean autoLift(){
  
  println("autoLift");
  float frames = 120;
  float inc = 10/frames;
  
  if(cableT > 0){
    cableT -= inc;
    cableL = lerp(cableMin,cableMax,cableT/10);
    return false;
  }
  
  cableT = 0;
  lift = true;
  cableCurrMove = 0;
  println("cable raised");
  return true;  
}

void cameraSwitch(int v){
  
  if(v == 1){
    eyeX = eye1[0];
    eyeY = eye1[1];
    eyeZ = eye1[2];
    centerX = center1[0];
    centerY = center1[1];
    centerZ = center1[2];
    upX = up1[0];
    upY = up1[1];
    upZ = up1[2];   
  }
  else if(v == 2){
    eyeX = eye2[0];
    eyeY = eye2[1];
    eyeZ = eye2[2];
    centerX = center2[0];
    centerY = center2[1];
    centerZ = center2[2];
    upX = up2[0];
    upY = up2[1];
    upZ = up2[2];   
  }
  else if(v == 3){
    eyeX = eye3[0];
    eyeY = eye3[1];
    eyeZ = eye3[2];
    centerX = center3[0];
    centerY = center3[1];
    centerZ = center3[2];
    upX = up3[0];
    upY = up3[1];
    upZ = up3[2];   
  }
  
}


void keyPressed() {
  
  if(key == 'n'){
    view *= -1;
    if(view == -1){
      println("manual view controls:");
      println("  eye(q/a,w/s,e/d)");
      println("  center(r/f,t/g,y/h)");
      println("  up(u/j,i/k,o/l)");
      println("press n to switch back to normal claw controls");
    }
    else{
      println("normal claw controls");
    }
  }
  
  if(view < 0){
    switch (key) {
    case 'q':
      eyeX += 0.1;
      break;
    case 'w':
      eyeY += 0.1;
      break;
    case 'e':
      eyeZ += 0.1;
      break;
    case 'a':
      eyeX -= 0.1;
      break;
    case 's':
      eyeY -= 0.1;
      break;
    case 'd':
      eyeZ -= 0.1;
      break;
    case 'r':
      centerX += 0.1;
      break;
    case 't':
      centerY += 0.1;
      break;
    case 'y':
      centerZ += 0.1;
      break;
    case 'f':
      centerX -= 0.1;
      break;
    case 'g':
      centerY -= 0.1;
      break;
    case 'h':
      centerZ -= 0.1;
      break;
    case 'u':
      upX += 0.1;
      break;
    case 'i':
      upY += 0.1;
      break;
    case 'o':
      upZ += 0.1;
      break;
    case 'j':
      upX -= 0.1;
      break;
    case 'k':
      upY -= 0.1;
      break;
    case 'l':
      upZ -= 0.1;
      break;
      
    }
    
    println("\n");
    println("eye    = (", eyeX+"," , eyeY+"," , eyeZ+"," , ")"); 
    println("center = (", centerX+"," , centerY+"," , centerZ+"," , ")"); 
    println("up     = (", upX+"," , upY+"," , upZ+"," , ")"); 
  
}else{
      
      switch(key){
        case 'x':
          if(clawCurrAng == 1){
            clawCurrAng = 0;
          }
          else{
          clawCurrAng = 1;
          }
          break;
        case 'c':
          if(clawCurrAng == -1){
            clawCurrAng = 0;
          }
          else{
            clawCurrAng = -1;
          }
          break;
        case 's':
          if(clawCurrRot == -1){
            clawCurrRot = 0;
          }
          else{
            clawCurrRot = -1;
          }
          break;
        case 'd':
          if(clawCurrRot == 1){
            clawCurrRot = 0;
          }
          else{
            clawCurrRot = 1;
          }
          break;
        case 'a':
          if(cableCurrMove == -1){
            cableCurrMove = 0;
          }
          else{
            cableCurrMove = -1;
          }
          break;
        case 'z':
          if(cableCurrMove == 1){
            cableCurrMove = 0;
          }
          else{
            cableCurrMove = 1;
          }
          break;
        case 'q':
          if(armCurrRot == 1){
            armCurrRot = 0;
          }
          else{
            armCurrRot = 1;
          }
          break;
        case 'w':
          if(armCurrRot == -1){
            armCurrRot = 0;
          }
          else{
            armCurrRot = -1;
          }
          break;
        case 'e':
          //moveArmLeft();
          if(armCurrMove == -1){
            armCurrMove = 0;
          }
          else{
            armCurrMove = -1;
          }
          break;
        case 'r':
          if(armCurrMove == 1){
            armCurrMove = 0;
          }
          else{
            armCurrMove = 1;
          }
          break;
        case 'o':
          perspective = false;
          break;
        case 'p':
          perspective = true;
          break;
        case ' ':
          animateClaw = true;
          break;
        case '1':
          cameraSwitch(1);
          break;
        case '2':
          cameraSwitch(2);
          break;
        case '3':
          cameraSwitch(3);
          break;
      }
   }


}
