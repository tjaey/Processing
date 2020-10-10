/**
 // NAME    : Avalyn Jasenn
 // COURSE    : Computer Graphics
 //
 // Code      : Draws 9 variations of a house, different pieces or translations of house/scene
 //             create versions
 **/

void setup() {
  size(1000, 800, P3D);
  colorMode(RGB, 1.0);
  noLoop();
  float x = 4.5;
  float y = x*0.8f;
  ortho(-x, x, y, -y);
  resetMatrix();
  hint(DISABLE_OPTIMIZED_STROKE);
}

  //global size vars
  float houseH = 0.5;
  float houseW = 0.6;
  float brickH = 0.05f;
  float brickW = 0.15f;
  
  float doorH = 0.3;
  float doorW = 0.17;
  float[] doorC = {1,0,0.2f};
  float doorX = houseW/4f;
  
  float windowH = 0.22;
  float windowW = 0.27;


  float roofW = 0.8;
  float roofH = 0.45;
  
  float lightW = 0.03f; //bulb width
  float lightH = 0.04f; //bulb height

  float treeH = 0.75;
  float treeW = 0.39;
  float follH = treeH*2/3; //tree folliage height
  float leafL = 0.1f;
  float leafW;
  
  float chimH = roofH*3/5f;
  
  //global color vars
  float[] trimC = {0.4f,0.3f,0.6f};
  float[] glassC = {0.6, 0.6, 1};
  
  float[] brickC = {0.56f,0.64f,0.68f}; //brick color
  float[] brickO = {0.27f,0.35f,0.39f}; //brick outline color
  
  float[] roofC = {0.21f,0.28f,0.31f};
  
  float[] barkC = {0.3f,0.2f,0.18f};


void draw() {
  background(0, 0, 0);
  
  //bottom level components
  float[] chimT = {0,0};
  float windowRo = 0;
  float[] skyLightSc = {1,1};
  float[] doorRe = {1,1};
  float[] chimSh = {0,0};
  float[] leafSc = {1,1};
  
  
  //high level components
  float[] treeT = {0,0};
  float roofRo = 0;
  float[] houseRe = {1,1};
  float[] treeSh = {0,0};
  float[] treeSc = {1,1};
  
  
  //draw untransformed scene in centre of screen
  drawScene(chimT,windowRo,skyLightSc,doorRe,chimSh,leafSc,treeT,roofRo,houseRe,treeSh,treeSc);
  
  
  //draw remaining scenes from top left to bottom right
  float leftOffset = -3.5;
  float topOffset = 2.4;
  float rightOffset = 3;
  float botOffset = -2.5;
  //
  //top left scene
  pushMatrix();
  translate(leftOffset,topOffset);
  chimT[0] = -0.1; //chimney translated
  chimT[1] = 0;
  windowRo = 0.1;//window rotated
  skyLightSc[0] = 1;
  skyLightSc[1] = 1;
  doorRe[0] = 1;
  doorRe[1] = 1;
  chimSh[0] = 0;
  chimSh[1] = 0;
  leafSc[0] = 1;
  leafSc[1] = 1;

  
  treeT[0] = 0;
  treeT[1] = 0;
  roofRo = 0;
  houseRe[0] = 1;
  houseRe[1] = 1;
  treeSh[0] = 0;
  treeSh[1] = 0.3;//tree sheared
  treeSc[0] = 1;
  treeSc[1] = 1;

  drawScene(chimT,windowRo,skyLightSc,doorRe,chimSh,leafSc,treeT,roofRo,houseRe,treeSh,treeSc);
  popMatrix();
  
  //top middle scene
  pushMatrix();
  translate(0,topOffset);
  chimT[0] = 0;
  chimT[1] = 0;
  windowRo = 0;
  skyLightSc[0] = 1.5;//skylight scaled
  skyLightSc[1] = 1.5;//skylight scaled
  doorRe[0] = -1;//door reflected
  doorRe[1] = 1;
  chimSh[0] = 0;
  chimSh[1] = 0;
  leafSc[0] = 1;
  leafSc[1] = 1;

  
  treeT[0] = 0.3;//tree translated
  treeT[1] = 0.2;//tree translated
  roofRo = 0;
  houseRe[0] = -0.8;//house reflected && scaled
  houseRe[1] = 0.8;//house scaled
  treeSh[0] = 0;
  treeSh[1] = 0;
  treeSc[0] = 1;
  treeSc[1] = 1;
  
  drawScene(chimT,windowRo,skyLightSc,doorRe,chimSh,leafSc,treeT,roofRo,houseRe,treeSh,treeSc);
  popMatrix();
  
  //top right scene
  pushMatrix();
  translate(rightOffset,topOffset);
  chimT[0] = 0;
  chimT[1] = 0;
  windowRo = 0;
  skyLightSc[0] = 1;
  skyLightSc[1] = 1;
  doorRe[0] = -1;//door reflected
  doorRe[1] = 1;
  chimSh[0] = -0.5;//chimney shear
  chimSh[1] = 0.5;//chimney shear
  leafSc[0] = 0.5;//leaf scale
  leafSc[1] = 0.5;//leaf scale

  
  treeT[0] = 0;
  treeT[1] = 0;
  roofRo = 0;
  houseRe[0] = 1;
  houseRe[1] = 1;
  treeSh[0] = 0;
  treeSh[1] = 0;
  treeSc[0] = 1;
  treeSc[1] = 1;
  
  drawScene(chimT,windowRo,skyLightSc,doorRe,chimSh,leafSc,treeT,roofRo,houseRe,treeSh,treeSc);
  popMatrix();
  
  //middle left scene
  pushMatrix();
  translate(leftOffset,0);
  chimT[0] = 0;
  chimT[1] = -0.1;//chimney translated
  windowRo = 0;
  skyLightSc[0] = 1.6;
  skyLightSc[1] = 2;//skylight scaled
  doorRe[0] = 1.3;//door scaled
  doorRe[1] = 1.2;
  chimSh[0] = 0;
  chimSh[1] = 0;
  leafSc[0] = 3;//leaves scaled
  leafSc[1] = 1.6;//leaves scaled

  
  treeT[0] = 0;
  treeT[1] = 0;
  roofRo = 0;
  houseRe[0] = 1;
  houseRe[1] = 1;
  treeSh[0] = 0;
  treeSh[1] = 0;
  treeSc[0] = 1;
  treeSc[1] = 1;
  
  drawScene(chimT,windowRo,skyLightSc,doorRe,chimSh,leafSc,treeT,roofRo,houseRe,treeSh,treeSc);
  popMatrix();
  
  //middle right scene
  pushMatrix();
  translate(rightOffset,0);
  chimT[0] = 0;
  chimT[1] = 0;
  windowRo = -0.2;//window rotated
  skyLightSc[0] = 1;
  skyLightSc[1] = 1;
  doorRe[0] = 1;
  doorRe[1] = 1;
  chimSh[0] = 0;
  chimSh[1] = 0;
  leafSc[0] = 1;
  leafSc[1] = 1;

  
  treeT[0] = 0;
  treeT[1] = 0;
  roofRo = -0.2;//roof rotated
  houseRe[0] = 1;
  houseRe[1] = 1;
  treeSh[0] = 0;
  treeSh[1] = 0;
  treeSc[0] = 1;
  treeSc[1] = 1.5;

  drawScene(chimT,windowRo,skyLightSc,doorRe,chimSh,leafSc,treeT,roofRo,houseRe,treeSh,treeSc);
  popMatrix();
  
  //bottom left scene
  pushMatrix();
  translate(leftOffset,botOffset);
  chimT[0] = 0;
  chimT[1] = 0;
  windowRo = 0;
  skyLightSc[0] = 1;
  skyLightSc[1] = 1;
  doorRe[0] = 0.5;//door scaled
  doorRe[1] = 0.5;//door scaled
  chimSh[0] = 0;
  chimSh[1] = 0;
  leafSc[0] = 1;
  leafSc[1] = 1;

  
  treeT[0] = 0.1;//tree translated
  treeT[1] = -0.12;//tree translated
  roofRo = 0;
  houseRe[0] = 2;//house scaled
  houseRe[1] = 2;//house scaled
  treeSh[0] = 0;
  treeSh[1] = 0;
  treeSc[0] = 1;
  treeSc[1] = 1;

  drawScene(chimT,windowRo,skyLightSc,doorRe,chimSh,leafSc,treeT,roofRo,houseRe,treeSh,treeSc);
  popMatrix();
  
  //bottom middle scene
  pushMatrix();
  translate(0,botOffset);
  chimT[0] = 0.35;//chimney translated
  chimT[1] = 0;
  windowRo = PI/2;
  skyLightSc[0] = 0.5;
  skyLightSc[1] = 0.5;
  doorRe[0] = -1;//door reflected
  doorRe[1] = 1;
  chimSh[0] = 0;
  chimSh[1] = 0;
  leafSc[0] = 2;
  leafSc[1] = 0.2;

  
  treeT[0] = 0;
  treeT[1] = 0;
  roofRo = 0;
  houseRe[0] = 1;
  houseRe[1] = 1;
  treeSh[0] = 0;
  treeSh[1] = 0;
  treeSc[0] = -1;//tree reflected
  treeSc[1] = 1;
  
  drawScene(chimT,windowRo,skyLightSc,doorRe,chimSh,leafSc,treeT,roofRo,houseRe,treeSh,treeSc);
  popMatrix();
  
  //bottom right scene
  pushMatrix();
  translate(rightOffset,botOffset);
  chimT[0] = -0.1;//chimney translated
  chimT[1] = -0.1;//chimney translated
  windowRo = 0;
  skyLightSc[0] = 1.3;//skylight scaled
  skyLightSc[1] = 1;
  doorRe[0] = 1;
  doorRe[1] = 1;
  chimSh[0] = 0;
  chimSh[1] = 0;
  leafSc[0] = 1;
  leafSc[1] = 1.5;//leaves scaled

  
  treeT[0] = -0.1;//tree translated
  treeT[1] = 0;
  roofRo = 0;
  houseRe[0] = -1.3;
  houseRe[1] = 1;
  treeSh[0] = 0;
  treeSh[1] = 0;
  treeSc[0] = 1;
  treeSc[1] = 1;

  drawScene(chimT,windowRo,skyLightSc,doorRe,chimSh,leafSc,treeT,roofRo,houseRe,treeSh,treeSc);
  popMatrix();
}


//
//draw scene at current 0,0 coord, with applied selected translations
//
void drawScene(float[] chimT,float windowRo,float[] skyLightSc,float[] doorRe,
float[] chimSh,float[] leafSc,float[] treeT,float roofRo,float[] houseRe,
float[] treeSh,float[] treeSc){
   
  
  //draw the house
  drawHouse(windowRo,doorRe,houseRe);

  pushMatrix();
  //moves coords up by house height to build roof
  translate(0,(houseH*houseRe[1]));
  drawRoof(chimT,skyLightSc,chimSh,roofRo);
  popMatrix();

  pushMatrix();
  //move coords over to side for tree
  translate(treeW*2, -0.05);
  drawTree(leafSc,treeT,treeSh,treeSc);
  popMatrix(); 
}


//
//build house  :  wall,door,window
//
void drawHouse(float windowRo,float[] doorRe,float[] houseRe) {
  
  pushMatrix();
  scale(houseRe[0],houseRe[1]);
  drawWall();

  pushMatrix();
  translate(doorX, 0);
  drawDoor(doorRe);
  popMatrix();

  pushMatrix();
  translate(-(houseW/5f), (houseH/4f));
  drawWindow(windowRo);
  popMatrix();
  
  popMatrix();
}

//
//draw front wall of house  :  rows,bricklines,speckles
//
void drawWall() {

  float rows = 20*houseH;
  float rad = houseW/2f;
  float brickLine;
  float speckDense = 0.01;
  
  fill(brickC[0],brickC[1],brickC[2]);
  stroke(brickO[0],brickO[1],brickO[2]);
  for (int i = 0; i<rows; i++) {//draw brick rows
  
    rect(-rad, brickH*i, houseW, brickH); //draw full horizontal row
    
    //draw brick speckles: points
    for(float j = (-rad+speckDense); j<rad-speckDense; j+=speckDense){ //<>//
      for(float k = speckDense; k < ((i+1)*brickH-speckDense); k+=speckDense){
        int rand = (int)random(0,100);
        if(rand%7 == 0){
          point(j,k);
        }   
      }
    }

    brickLine = -rad+(brickW/2);

    if (i%2 == 0) {
      brickLine = -rad+brickW;
    }
    while (brickLine < houseW/2) {//draw vertical lines to create bricks
      line(brickLine, brickH*(i+1), brickLine, brickH*(i));
      brickLine+= brickW;
    }
  }
  
  fill(1);
  stroke(0);
}


//
// draw door  :  door, window, doorknob
//
void drawDoor(float[] doorRe) {

  //draw outline of door
  pushMatrix();
  scale(doorRe[0],doorRe[1]);
  fill(doorC[0],doorC[1],doorC[2]);
  beginShape();
  vertex(-(doorW/2), 0);
  vertex(-(doorW/2), doorH);
  vertex((doorW/2), doorH);
  vertex((doorW/2), 0);
  endShape(CLOSE);

  //draw doorknob
  fill(0.4f,0,0);
  ellipse(-(doorW/4f), doorH/2f, doorW/6f, doorH/6f);

  //drawWindow
  fill(glassC[0],glassC[1],glassC[2]);
  stroke(trimC[0],trimC[1],trimC[2]);
  rect(-(doorW/4f), (doorH-(doorH/3f)), (doorW/2), (doorW/3));
  
  fill(1);
  popMatrix();
}

//
//draw window  : fill,curtains,window frame
//
void drawWindow(float windowRo) {

  //fill window: rectangle
  pushMatrix();
  rotate(windowRo);
  noStroke();
  fill(glassC[0],glassC[1],glassC[2]);
  rect(-(windowW/2f), 0, windowW, windowH);

  stroke(0);
  fill(1, 1, 1);

  //draw left curtain: triangle
  noStroke();
  fill(0.94f,0.95f,0.76f);
  beginShape();
  vertex(-(windowW/2f), windowH);
  vertex(-(windowW/2f), windowH-(windowH/2));
  vertex(-(windowW/4), windowH);
  endShape(CLOSE);

  //draw right curtain: triangle
  beginShape();
  vertex((windowW/2f), windowH);
  vertex((windowW/2f), windowH-(windowH/2));
  vertex((windowW/4), windowH);
  endShape(CLOSE);

  //draw centre window frame: lines
  noFill();
  stroke(0.4f,0.3f,0.6f);
  strokeWeight(2);
  line(0, 0, 0, windowH);//centre x
  line(-(windowW/2f), (windowH/2f), (windowW/2f), (windowH/2f));//centre y
  line((-windowW/2f),0,(-windowW/2f),windowH);//left
  line((windowW/2f),0,(windowW/2f),windowH);//right
  line((-windowW/2),windowH,(windowW/2),windowH);//top
  line((-windowW/2),0,(windowW/2),0);//bottom
  strokeWeight(1);

  fill(1, 1, 1);
  popMatrix();
}

//
//draw roof : chimney,roof,skylight,christmas lights
//
void drawRoof(float[] chimT,float[] skyLightSc,float[] chimSh,float roofRo) {

  pushMatrix();
  rotate(roofRo);
  //main roof triangle measurements
  float roofRadius = roofW/2;
  float leftX = -roofRadius;
  float rightX = roofRadius;
  float midY = roofH;


  //draw chimney in background
  fill(brickC[0],brickC[1],brickC[2]);
  float chimW = roofW/6;
  float chimRad = chimW/2;
  float chimRows = 20*chimH;
  float chimX = (-roofW/6.4f);
  float chimY = roofH/3.5f;
  float brickH = 0.05;
  float speckDense = 0.1f;
  
  float chimBaseX = (-(roofW/6.4f));
  float chimBaseY = 0;
  

  pushMatrix();
  translate(chimBaseX+chimT[0],chimBaseY+chimT[1]);
  shearX(chimSh[0]);
  shearY(chimSh[1]);
  stroke(0);

  for (int i=0; i<chimRows; i++) {   
    rect(chimX, chimY, chimW, brickH);
    chimY += brickH;
  }

  //brickLine down chimney
  stroke(brickO[0],brickO[1],brickO[2]);
  line(chimX+chimW/3, 0, chimX+chimW/3, chimY);

  //chimney cap
  fill(0.81f,0.84f,0.86f);
  float capH = brickH*1.1;
  float capW = chimW/7f;

  beginShape();
  vertex(chimX-capW, chimY);
  vertex(chimX-capW, chimY+capH);
  vertex(chimX+chimW+capW, chimY+capH);
  vertex(chimX+chimW+capW, chimY); 
  endShape();

  popMatrix();

  //main roof : big triangle
  stroke(0);
  fill(0.21f,0.28f,0.31f);
  beginShape();
  vertex(leftX, 0);
  vertex(0, midY);
  vertex(rightX, 0);
  endShape(CLOSE);

  //skylight : arc
  pushMatrix();
  scale(skyLightSc[0],skyLightSc[1]);
  stroke(trimC[0],trimC[1],trimC[2]);
  fill(glassC[0],glassC[1],glassC[2]);
  arc(0, roofH/7f, roofW/3.5f, roofH/2.5f, 0, PI, CHORD);
  popMatrix();
  
  fill(1);
  stroke(0);

  //christmas lights: ellipses

  float lightX = leftX;//current light x
  float lightY = 0; //current light y
  float lightSpan = 0.09f; //distance between lights
  int count = 0; //

  stroke(1);//white around bulbs
  fill(1, 0, 0);
  while (lightX<(rightX-(lightSpan/2))) {
    ellipse(lightX, lightY, lightW, lightH);
    lightX+= lightSpan;
    fill(1, 0, 0);
    if (count%2 == 0) {
      fill(0, 1, 0);
    }
    count++;
  }
  ellipse(rightX, lightY, lightW, lightH);
  stroke(0, 0, 0);
  fill(1, 1, 1);
  popMatrix();
}

//
// draw tree  :  trunk,branch cut-out,knot,leaves
//
void drawTree(float[] leafSc,float[] treeT,float[] treeSh,float[] treeSc) {

  leafW = leafL/2;
  
  pushMatrix();
  translate(treeT[0],treeT[1]);
  scale(treeSc[0],treeSc[1]);
  shearX(treeSh[0]);
  shearY(treeSh[1]);
  
  //trunk base: rectangle
  stroke(0.39f,0.12f,0.09f);
  fill(barkC[0],barkC[1],barkC[2]);
  float trunkH = treeH*3/4;
  float trunkW = treeW/2;
  float trunkX = -treeW/4;

  rect(trunkX, 0, trunkW, trunkH);

  //branch cut-out: small black triangle
  fill(0, 0, 0);
  noStroke();
  beginShape();
  vertex(trunkX, trunkH);
  vertex(trunkW/2, trunkH);
  vertex(0, (trunkH/4f));
  endShape(CLOSE);
  fill(1, 1, 1);

  //knot in trunk: two ellipses
  //big outer ellipse
  fill(0.36f,0.25f,0.21f);
  stroke(0.39f,0.12f,0.09f);
  float knotX = trunkX/2;
  float knotY = trunkH/4;
  float knotH = trunkH*3/7f;
  float knotW = trunkW/4;
  ellipse(knotX, knotY, knotW, knotH);

  //little inner ellipse
  stroke(0.3f,0.2f,0.15f);
  knotX -= 0.005f;
  knotY -= 0.01f;
  knotH = knotH*2/3f;
  knotW = knotW/2f;
  ellipse(knotX, knotY, knotW, knotH);
  
  stroke(0);
  fill(1);

  //draw leaves
  
  float follH = treeH*2/3;
  pushMatrix();
  translate(0, treeH/2);
  drawLeaves(leafSc);

  popMatrix();
  
  popMatrix();
}

//
//draw leaves  :  background & foreground leaf bunches
//
void drawLeaves(float[] leafSc) {

  float x, y; //coords for curr bunch of leaves
  float treeRad = treeW/2;
  float numBunches = treeW*30f;
  float bunchDense = 0.23;
  float radius = treeW/5f;
  float maxIncRad = 0.01f; 
  float t = 0;
  float tInc = 0.05;
  float maxIncT = 0.1f;
  
  int bg = 0;
  int fg = 1;
  
  float levels = 4;
  float follInc = follH/levels;
  
  
  //draw dark green background leaves
   //centre folliage bunch
  for(float i = 0; i<follH; i+=follInc){
    for(float j = (-treeRad); j<treeW; j+=bunchDense){
      pushMatrix();
      translate(j,i);
      drawLeafBunch(leafSc,bg);
      popMatrix();
    }
  }
  
  // draw bright green foreground leaves
  //centre folliage bunch
  bunchDense = 0.25;
  for(float i = 0; i<follH; i+=follInc){
    for(float j = (-treeRad); j<treeW; j+=bunchDense){
      pushMatrix();
      translate(j,i);
      drawLeafBunch(leafSc,fg);
      popMatrix();
    }
  }
  
}

//
//draw bunch of leaves in same general radius
//
void drawLeafBunch(float[] leafSc,int shade) {

  float x, y;
  float inc = 0.05;
  float t = 0f;
  float numLeaves = 9;

  //draw bunch
  for (int i = 0; i<numLeaves; i++) {
    float radius = random(0,0.08f);
    x = (float)(radius * Math.cos(t * 2 * PI));
    y = (float)(radius * Math.sin(t * 2 * PI));
    float angle = random(0, 2*PI);
    pushMatrix();
    rotate(angle);
    translate(x, y);
    drawLeaf(leafSc,shade);
    popMatrix();
    t+= random(0.03,0.09);
  }
}

//
// draw a single leaf(stem,ellipse,vein)
void drawLeaf(float[] leafSc,int shade) {
  
  //scale(4);
  pushMatrix();
  scale(leafSc[0],leafSc[1]);

  noStroke();
  
  float leafRadW = leafW/2f;
  float leafRadL = leafL/2f;
  float leafY;

  float stemL = leafL/5f;
  float stemW = stemL/2f;
  float stemRad = stemW/2f;

  leafY = stemL+leafRadL;


  //draw stem: rectangle
  fill(barkC[0],barkC[1],barkC[2]);
  rect(-stemRad, 0, stemW, stemL*1.1);

  //draw leaf: ellipse
  fill(0.39f, 0.78f, 0); //bright green
  if(shade == 0){//background leaf
    fill(0.2f, 0.43f, 0);
  }
  ellipse(0, leafY, leafW, leafL);
  fill(1);

  //draw vein down centre: line
  stroke(0.6f, 0.69f, 0.375f);
  line(0, stemL, 0, stemL+leafL);


  stroke(0);
  popMatrix();
}
