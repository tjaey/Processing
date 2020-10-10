/** //<>//
 // NAME    : Avalyn (Tiffany) Jasenn
 // COURSE    : Computer Graphics
 // 
 // Code  :  Triangle drawing palette. Choose a color and then a triangle can
 //          be drawn be placing 3 vertices. New vertices can be connected to 
 //          existing triangle vertices by clicking near the existing vertice.
 //          
 //          Triangles and vertices can be selected and moved around the screen 
 //          by clicking and dragging on triangle/near vertice to be moved
 //
 //          Key commands - will translate selected triangle, or world view:
 //                  c = scale negative
 //                  v = scale positive
 //                  w = translate down
 //                  s = translate up
 //                  a = translate left
 //                  d = translate right    
 //                  z = restore view to original(works when no triangle is selected)
 // 
 **/
//<>//
//global vars
//list of vertices
ArrayList<float[]> VERT = new ArrayList<float[]>();
//list of triangles 0:2 VERTs, 3:3 COLOR  
ArrayList<int[]> TRIAD = new ArrayList<int[]>(); 
//list of colors
ArrayList<float[]> COLOR = new ArrayList<float[]>();

void setup() {
  size(500, 500, P3D);
  colorMode(RGB, 1.0);
  background(0);
  fill(1);
  stroke(1);
  strokeWeight(3);
  hint(DISABLE_OPTIMIZED_STROKE);
  //surface.setResizable(true);

  //add triangle palette COLORs
  COLOR.add(pink);
  COLOR.add(red);
  COLOR.add(orange);
  COLOR.add(yellow);
  COLOR.add(olive);
  COLOR.add(green);
  COLOR.add(turquoise);
  COLOR.add(blue);
  COLOR.add(indigo);
  COLOR.add(violet);
}



//triangle build vars
int[] buildTri; //stores indices of verts for triangle in prog
boolean makingTri = false; //tri in progress
//verts of tri in progess
boolean selectV0 = false; 
boolean selectV1 = false;
boolean selectV2 = false;
float[] vert0 = new float[2];
float[] vert1 = new float[2];
float[] vert2 = new float[2];

//triangle select vars
int currTri = -1; //index of selected TRIAD
boolean selectTri = false; //triangle currently selected
boolean deselectTri = false; //triangle deselected with last press
float[] currPoint = new float[2]; //last point pressed XY
boolean movingTri = false; //currently moving a tri

//vertex select vars
int currVert = -1; //index of selected VERT
boolean selectVert = false; //vert currently selected
boolean movingVert = false; //currently moving a vert
float[] snapVert = new float[2]; //VERT snapped to
boolean snap = false; //snapped w last press
float snapRad = 7;

//view vars
float ortho0 = -250;
float ortho1 = 250;
float ortho2 = -250;
float ortho3 = 250;
float[] currOrtho = {ortho0,ortho1,ortho2,ortho3};

//color vars
int fillColor = 0; //current triangle color
float[] pink = {0.91, 0.12, 0.39};
float[] red = {1, 0, 0.2};
float[] orange = {0.98, 0.55, 0};
float[] yellow = {1, 0.92, 0.23};
float[] olive = {0.75,0.79,0.2};
float[] green = {0.11, 0.37, 0.13};
float[] turquoise = {0.15,0.65,0.6};
float[] blue = {0.7, 0.92, 0.95};
float[] indigo = {0.4, 0, 1};
float[] violet = {0.4, 0.11, 0.6};
float[] fillArray = pink;
float[] stColor = {0,1,0};
boolean selectColor = false;
float squareX = -1;
float squareY = -1;


void draw() {
  ortho(currOrtho[0],currOrtho[1],currOrtho[2],currOrtho[3]);
  background(0);
  //translate(worldX,worldY);
  drawColors();

  drawTriangles();

  if (selectV0 == true) { // start new triangle
    buildTri();
  }
}


//
//draws color palette along bottom of canvas
//
void drawColors() {

  //width of each rect
  squareX = width/(float)COLOR.size();
  squareY = height-squareX;

  //draw each square
  for (int i=0; i<COLOR.size(); i++) {

    //stroke curr color selected
    if (fillColor == i) {
      stroke(stColor[0],stColor[1],stColor[2]);
    }

    float[] curr = COLOR.get(i);
    fill(curr[0], curr[1], curr[2]);
    rect((squareX*i), squareY, squareX, squareX);    
    stroke(1);
  }
  //resume selected fill
  fill(fillArray[0], fillArray[1], fillArray[2]);
}

//
//prints VERTs of all TRIADs
//
void printVerts() {

  for (int i =0; i<TRIAD.size(); i++) {

    println("TRIAD: ", i);
    int[] tri = TRIAD.get(i);
    println(VERT.get(tri[0]));
    println(VERT.get(tri[1]));
    println(VERT.get(tri[2]));
  }
}

void restoreView(){
 
  currOrtho[0] = ortho0;
  currOrtho[1] = ortho1;
  currOrtho[2] = ortho2;
  currOrtho[3] = ortho3;
  
}


//
// moves selected TRIAD or world view by X,Y
//
void translateTri(float x, float y) {

  //if triangle selcted, translate
  if (selectTri) {

    //println("before translate");
    //printVerts();
    //get selected tri verts
    int[] tri = TRIAD.get(currTri);
    float[] v0 = VERT.get(tri[0]);
    float[] v1 = VERT.get(tri[1]);
    float[] v2 = VERT.get(tri[2]);

    //move verts
    v0[0] += x;
    v0[1] += y;
    v1[0] += x;
    v1[1] += y;    
    v2[0] += x;
    v2[1] += y;    
    println("after translate");
    printVerts();
  }
  else{
    currOrtho[0] += x;
    currOrtho[1] += x;
    currOrtho[2] += y;
    currOrtho[3] += y;
  }
}


//
// scales selected TRIAD or world view
//
void scale(float d) {

  //println("before scale:");
  //printVerts();

  // if triangle selected, scale
  if (selectTri) {
    //println("scaling triangle", currTri, " : ", d);

    //if d is - will scale down
    //get selected tri verts
    int[] tri = TRIAD.get(currTri);
    float[] v0 = VERT.get(tri[0]);
    float[] v1 = VERT.get(tri[1]);
    float[] v2 = VERT.get(tri[2]);

    //center of tri
    float[] center = centerOfTriangle();

    //println("center of triangle: ", center[0], ",", center[1]);
    //calc distance to move each vert
    float disV0x = (v0[0]-center[0])/10*d;
    float disV0y = (v0[1]-center[1])/10*d;
    float disV1x = (v1[0]-center[0])/10*d;
    float disV1y = (v1[1]-center[1])/10*d;  
    float disV2x = (v2[0]-center[0])/10*d;
    float disV2y = (v2[1]-center[1])/10*d;

    //println("disV0x:", disV0x);
    //println("disV0y:", disV0y);

    //move verts
    v0[0] += disV0x;
    v0[1] += disV0y;
    v1[0] += disV1x;
    v1[1] += disV1y;
    v2[0] += disV2x;
    v2[1] += disV2y;

    //println("after scale:");
    //printVerts();
  }
  else{
    
    currOrtho[0] -= 10*d;
    currOrtho[1] += 10*d;
    currOrtho[2] -= 10*d;
    currOrtho[3] += 10*d;
    
  }
}

//
//control selected triangle translations
//
void keyPressed() {

  println(key);


  if (key == 'c') {//scale negative
    scale(-1);
  }

  if (key == 'v') {//scale positive
    scale(1);
  }

  if (key == 'w') {//translate -y :down
    translateTri(0, -10);
  }

  if (key == 'a') {//translate -x :left
    translateTri(-10, 0);
  }

  if (key == 's') {//translate y :up
    translateTri(0, 10);
  }

  if (key == 'd') {//translate x :right
    translateTri(10, 0);
  }
  
  if (key == 'z'){//restore view
    restoreView();
  }
  
}

//
//can translate selected TRIAD | VERT
//
void mouseDragged() {

  float x = mouseX-pmouseX;
  float y = mouseY-pmouseY;
  //println("selectVert: ",selectVert);
  //println("movingVert: ",movingVert);

  //if vertex selected, move it
  if (selectVert == true) {

    movingVert = true;

    float[] vertex = VERT.get(currVert);
    vertex[0] += x;
    vertex[1] += y;
  } else if (selectTri == true) {//if triangle selected, move it

    int[] tri = TRIAD.get(currTri);

    float[] vert0 = VERT.get(tri[0]);
    float[] vert1 = VERT.get(tri[1]);
    float[] vert2 = VERT.get(tri[2]);

    //move verts
    vert0[0] += x;
    vert0[1] += y;
    vert1[0] += x;
    vert1[1] += y;
    vert2[0] += x;
    vert2[1] += y;
  }
}


void mouseReleased() {

  movingVert = false;
  selectVert = false;
  selectColor = false;
}

//
// test VERT select and allow translation of VERT
// test TRIAD select
//
void mousePressed() {

  // mouse pressed @
  float X = mouseX;
  float Y = mouseY;
  currPoint[0] = X;
  currPoint[1] = Y;

  deselectTri = false;
  boolean select0 = selectTri;

  //check if selecting existing vertex
  println("looking for vert");
  currVert = testSelectVertex(X, Y); 
  println("currVert:", currVert);

  if (selectVert == false) {
    println("looking for triangle");
    currTri = testSelectTriangle(X, Y);
    println("currTri:", currTri);
    if (select0 == true && selectTri == false) {
      deselectTri = true;
    }
  }
}

//
//test for select color & select tri
//select points for triangle verts
//
void mouseClicked() {

  // mouse pressed @
  float X = mouseX;
  float Y = mouseY;
  currPoint[0] = X;
  currPoint[1] = Y;


  if (testSelectColor(X, Y) == false && !deselectTri) { //if click not used to select color or deselect tri
    if (selectV0 == false) { // no triangle in progress

      //if no vertex selected:
      //    check if selecting existing triangle
      if (selectVert == false) {
        println("looking for triangle");
        currTri = testSelectTriangle(X, Y);
        println("currTri:", currTri);
      }
    }
    //println("selectTri:", selectTri);

    //if no vertex or triangle selected, begin new triangle
    if (!selectTri && !movingVert) {
      createVertex(X, Y);
    }
    println("Press at ", mouseX, ",", mouseY);
  }
}

//
//create new TRIAD and 
//create new VERTs or assign TRIAD[x] to snapVert
//
void createVertex(float X, float Y) {

  //param XY
  float[] nextVert = {X, Y};

  //check if XY is close to existing vertex
  int snapVert = testSnap(X, Y);


  if (selectV0 == false) { //create v0

    //create new vertices
    //new triangle
    buildTri = new int[4];
    //new dynamic verts
    buildTri[3] = fillColor;
    vert0 = new float[2];
    vert1 = new float[2];
    vert2 = new float[2];

    if (snapVert < 0) { // if no snap to existing vertex
      buildTri[0] = VERT.size(); //index of v0 
      VERT.add(nextVert); //vert added to VERT list of vertices
      vert0[0] = X;
      vert0[1] = Y;
      println("New vert0 at ", X, " ", Y);
    } else {//snap vertex to existing vertex by index
      buildTri[0] = snapVert; //VERT index
      vert0 = VERT.get(snapVert);
      println("vert0 snapped to vert num: ", snapVert);
    }

    selectV0 = true;
  } else if (selectV1 == false) { //create v1

    if (snapVert < 0) { // if no snap to existing vertex
      buildTri[1] = VERT.size(); //indice of v1 
      VERT.add(nextVert); //vert added to VERT list of vertices
      vert1[0] = X;
      vert1[1] = Y;
      println("New vert1 at ", X, ",", Y);
    } else {//snap vertex to existing vertex by index
      buildTri[1] = snapVert; //VERT index
      vert1 = VERT.get(snapVert);
      println("vert1 snapped to vert num: ", snapVert);
    }   

    selectV1 = true;
  } else { //create v2

    if (snapVert < 0) { // if no snap to existing vertex
      buildTri[2] = VERT.size(); //indice of v2 
      VERT.add(nextVert); //vert added to global list of vertices
      vert2[0] = X;
      vert2[1] = Y;
      println("New vert2 at ", X, ",", Y);
    } else {//snap vertex to existing vertex by index
      buildTri[2] = snapVert; //VERT index
      vert2 = VERT.get(snapVert);
      println("vert2 snapped to vert num: ", snapVert);
    }

    TRIAD.add(buildTri);

    selectV2 = true;
  }
}

//
//find center of selected triangle
//
float[] centerOfTriangle() {

  int[] verts = TRIAD.get(currTri);

  float[] v0 = VERT.get(verts[0]);
  float[] v1 = VERT.get(verts[1]);
  float[] v2 = VERT.get(verts[2]);

  float cX = (v0[0]+v1[0]+v2[0])/3f;
  float cY = (v0[1]+v1[1]+v2[1])/3f;

  float[] center = {cX, cY};
  return center;
}

//
//dynamically build current working triangle
//
void buildTri() {

  //selectV0 is true
  stroke(fillArray[0], fillArray[1], fillArray[2]);
  if (selectV1 == false) { //v0 selected for new triangle
    //first point selected
    //dynamically calc line to curr mouse pos
    line(vert0[0], vert0[1], mouseX, mouseY);
  } else if (selectV2 == false) { //if v1 == true
    //second point selected
    //dynamically calc completion of closed triangle at mouse pos
    line(vert0[0], vert0[1], vert1[0], vert1[1]);
    beginShape();
    vertex(vert0[0], vert0[1]);
    vertex(vert1[0], vert1[1]);
    vertex(mouseX, mouseY);
    endShape(CLOSE);
  } else {
    //third point selected
    //add triangle to TRIAD array
    //addTriangle();
    println(TRIAD.size());


    //clear vertices
    selectV0 = false;
    selectV1 = false;
    selectV2 = false;

    makingTri = false;
  }
  stroke(1);
}

//
//test if point xp,yp is withing the triangle
//
boolean pointInTriangle(float x0, float y0, float x1, float y1, float x2, float y2, float xp, float yp) {
  int sign;
  float[] v1 = new float[2], v2 = new float[2];

  v1[0] = x1 - x0;
  v1[1] = y1 - y0;
  v2[0] = xp - x0;
  v2[1] = yp - y0;
  float cross1 = cross(v1, v2);

  v1[0] = x2 - x1;
  v1[1] = y2 - y1;
  v2[0] = xp - x1;
  v2[1] = yp - y1;
  float cross2 = cross(v1, v2);

  v1[0] = x0 - x2;
  v1[1] = y0 - y2;
  v2[0] = xp - x2;
  v2[1] = yp - y2;
  float cross3 = cross(v1, v2);

  return ((cross1 <= 0) && (cross2 <= 0) && (cross3 <= 0)) || ((cross1 >= 0) && (cross2 >= 0) && (cross3 >= 0));
}

//
//calculate cross product of v1 x v2
//
float cross(float[] v1, float[] v2) {
  return v1[0] * v2[1] - v1[1] * v2[0];
}

//
// test if XY is within the color swatch row
//  true: assign new fill color
//
boolean testSelectColor(float X, float Y) {

  //if XY in color swatch row
  if (!selectV0 && Y >= squareY && Y < height) {
    fillColor = floor(X/squareX); 
    fillArray = COLOR.get(fillColor);
    fill(fillArray[0], fillArray[1], fillArray[2]);
    println("found color: ", fillColor);
    selectColor = true;
    return true;
  }

  return false;
}


//
// test if XY is within the any existing TRIADs
//  true: select TRIAD, return index
//
int testSelectTriangle(float X, float Y) {

  boolean found = false;
  //float[][] curr = null;
  int[] tri = null;
  //test all existing triangles
  for (int i = 0; i<TRIAD.size(); i++) {

    //curr triangle
    tri = TRIAD.get(i);

    float[] vert0 = VERT.get(tri[0]);
    float[] vert1 = VERT.get(tri[1]);
    float[] vert2 = VERT.get(tri[2]);  
    float[] vertP = currPoint;

    //point in triangle test
    found = pointInTriangle(vert0[0], vert0[1], vert1[0], vert1[1], vert2[0], vert2[1], vertP[0], vertP[1]);

    if (found) { //return curr triangle if found
      selectTri = true;
      println("point ", X, " ", Y, " in triangle ", i);
      return i;
    }
  }

  //point not found in any triangle
  selectTri = false;
  println("point not in triangle");
  return -1;
}

//
// test if XY is selects an existing VERT
//  true: select VERT, return index
//
int testSelectVertex(float X, float Y) {

  //check if snap to existing vertex
  currVert = testSnap(X, Y);

  //if snap select vertex in VERT
  if (currVert > -1) { //if snap
    //assign selected snapVert
    snapVert = VERT.get(currVert);
    selectVert = true;
    //return index of VERT
    return currVert;
  }

  //if no slected vertex return -1
  selectVert = false;
  return currVert;
}

//
//draw all existing TRIADs
//
void drawTriangles() {

  for (int i = 0; i<TRIAD.size(); i++) {
    
    //draw stroke if current triangle is selected
    if (selectTri && currTri == i) {
      stroke(stColor[0],stColor[1],stColor[2]);
    }
    int[] currTri = TRIAD.get(i);

    float[] v0 = VERT.get(currTri[0]);
    float[] v1 = VERT.get(currTri[1]);
    float[] v2 = VERT.get(currTri[2]);
    float[] col = COLOR.get(currTri[3]);
    fill(col[0], col[1], col[2]);
    beginShape();
    vertex(v0[0], v0[1]);
    vertex(v1[0], v1[1]);
    vertex(v2[0], v2[1]);
    endShape(CLOSE);
    stroke(1);
  }
  //return triangle fill color in use
  fill(fillArray[0], fillArray[1], fillArray[2]);
}

//
//test if XY is within snapRad of any existing VERTs
// true: returns index of VERT
//
int testSnap(float x, float y) {

  for (int i = 0; i<VERT.size(); i++) { //check each triangle
    float[] curr = VERT.get(i);

    float x0 = curr[0];
    float y0 = curr[1];

    float dist = dist(x, y, x0, y0);

    if (dist < snapRad) {
      println("snap to vert ", i);
      snap = true;
      return i;
    }
  }    

  //no snap
  snap = false;
  return -1;
}
