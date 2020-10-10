/**
 // NAME    : Avalyn Jasenn
 // COURSE    : Computer Graphics
 //
 // Code      : creates 'geometric flower' with diamond shaped petals in a purple-red gradient
 //
 **/

void setup(){
 size(640,640,P3D);
 colorMode(RGB,100);
 background(0);
 noStroke();
 ortho(-1,1,1,-1);
 resetMatrix();
}

void draw(){
  
  //init colours to create gradiant
  int r = 11;
  int g = 10;
  int b = 23;
  
  float x,y,x1,y1,x2,y2;
  float radius = 0.11f;// init radius size
  float inc = PI; //increment angle by
  float t = PI; 
  
  //draw flower
  beginShape();
  stroke(90); //white outline for petals
  
  while (radius < 0.95) {
    
    t+=inc;
    
    //calculate vertices of petal
    x = (float)(radius * Math.cos(t * 2 * PI));
    y = (float)(radius * Math.sin(t * 2 * PI));
    x1 = (float)((radius/2) * Math.cos((t-0.04f) * 2 * PI));
    y1 = (float)((radius/2) * Math.sin((t-0.04f) * 2 * PI));
    x2 = (float)((radius/2) * Math.cos((t+0.04f) * 2 * PI));
    y2 = (float)((radius/2) * Math.sin((t+0.04f) * 2 * PI)); //<>//

    //draw vertices of petal and create gradiant
    fill(r,g,b);
    r = (r+10)%100;
    b = (b+12)%100;
    vertex(0.0f, 0.0f);   
    fill(r-10,g,b);
    vertex(x1,y1); //<>//
    vertex(x, y);
    vertex(x2,y2);
    
    //increase petal length
    radius = radius*1.01f;
    
  }
  endShape(CLOSE);
  
} 
