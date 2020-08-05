// Created by Nicholas Desmarais
// Reference Material: http://paulbourke.net/geometry/polygonise/

import peasy.*;

// Configuration Members (TODO: possibly replace with command line args)
int dimension = 5;
float isoValue = .5; 

// Global members
PeasyCam cam;
point[][][] points = new point[dimension][dimension][dimension];
ArrayList<triangle> triangles = new ArrayList<triangle>();

void setup() {
  // Sketch Setup
  size(500,500,P3D);
  noStroke();
  colorMode(RGB,1);
  
  // Camera Setup
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(1000);
  cam.lookAt(10*dimension/2,10*dimension/2,10*dimension/2);
  
  // Program Setup
  generatePoints();
  iterate();
    
}

void draw() {
  background(.5);
  
  
  //drawPoints();
  lights();
  drawTriangles();
  
  cam.beginHUD();
  fill(0);
  text(isoValue, 0, 15);
  cam.endHUD();
}

void keyPressed() {
  if(keyCode == UP) {
    isoValue += .01;
  }
  if(keyCode == DOWN) {
    isoValue -= .01;
  }
  if(keyCode == LEFT) {
    isoValue -= .1;
  }
  if(keyCode == RIGHT) {
    isoValue += .1;
  }
  isoValue = constrain(isoValue, 0, 1);
  return;
}
