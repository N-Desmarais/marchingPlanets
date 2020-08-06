// Created by Nicholas Desmarais
// Reference Material: http://paulbourke.net/geometry/polygonise/

import peasy.*;

// Configuration Members (TODO: possibly replace with command line args)
int dimension = 50;
int gap = 2;
float noiseMultiplier = 3;
float isoValue = 40;
float oldIso = isoValue;

// Global members
PeasyCam cam;
point[][][] points = new point[dimension][dimension][dimension];
ArrayList<triangle> triangles = new ArrayList<triangle>();

void setup() {
  // Sketch Setup
  frameRate(30);
  size(500,500,P3D);
  noStroke();
  colorMode(RGB,1);
  
  // Camera Setup
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(1000);
  cam.lookAt(gap*dimension/2,gap*dimension/2,gap*dimension/2);
  
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
  
  if(isoValue != oldIso) {
   triangles.clear();
   iterate(); 
   oldIso = isoValue;
  }
}

void keyPressed() {
  if(keyCode == UP) {
    isoValue += 1;
  }
  if(keyCode == DOWN) {
    isoValue -= 1;
  }
  if(keyCode == LEFT) {
    isoValue -= 5;
  }
  if(keyCode == RIGHT) {
    isoValue += 5;
  }
  return;
}
