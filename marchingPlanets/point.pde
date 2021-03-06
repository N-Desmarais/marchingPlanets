class point {
  // This class represents a matrix point + its density value
  
  int x;
  int y;
  int z;
  float val;
  
  point(int xVal, int yVal, int zVal, float value) {
    x = xVal; y = yVal; z = zVal; val = value;
  }
  
  // I use box here cause sphere lags alot
 void draw() {
    if(val <= isoValue) {
      pushMatrix();
      
      translate(x, y, z);
      fill(val);
      box(1);
      
      popMatrix();
    }
  }
}

void generatePoints() {
  // generates all points in cube of specified dimension
  // points spaced 10 pixels apart from each other
  
  for(int x = 0; x < dimension; x++) {
    for(int y = 0; y < dimension; y++) {
      for(int z = 0; z < dimension; z++) {
        //float val = dist (0,0,0,10*x,10*y,10*z)
        float noise = dist(gap*x,gap*y,gap*z,gap*dimension/2,gap*dimension/2,gap*dimension/2) + noise(x,y,z) * noiseMultiplier;
        //if(random(0,1) > .5) noise = 0 - noise;
        points[x][y][z] = new point(gap*x,gap*y,gap*z,noise);
      }
    }
  }
}

void drawPoints() {
  // calls the draw function for each point in the cube
  
  for(int x = 0; x < dimension; x++) {
    for(int y = 0; y < dimension; y++) {
      for(int z = 0; z < dimension; z++) {
        points[x][y][z].draw();
      }
    }
  }
}
