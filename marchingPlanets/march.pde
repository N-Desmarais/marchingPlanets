void iterate() {
  // This function iterates through each matrix cube
  // Calling the polygonise function
  
  for(int z = 0; z < dimension - 1; z++) {
    for(int y = 0; y < dimension - 1; y++) {
      for(int x = 0; x < dimension - 1; x++) {
      point[] cubePoints = getPoints(x,y,z);
      polygonise(cubePoints);
      }
    }
  }
}

point[] getPoints(int x, int y, int z) {
  // gets the vertex points on a matrix cube
  // cube "origin" is bottom corner x y z
  
  point[] cubePoints = new point[8];
  
  cubePoints[0] = points[x][y][z];
  cubePoints[1] = points[x][y][z+1]; 
  cubePoints[2] = points[x+1][y][z+1]; 
  cubePoints[3] = points[x+1][y][z]; 
  cubePoints[4] = points[x][y+1][z]; 
  cubePoints[5] = points[x][y+1][z+1]; 
  cubePoints[6] = points[x+1][y+1][z+1]; 
  cubePoints[7] = points[x+1][y+1][z]; 
  
  return cubePoints;
}

void polygonise(point[] cubePoints) {
  // Checks whether each cube points value is lower than isovalue
  // if so bitwise or with 2 to the power of the vertex number
  // cubeindex used to look up triangulation table for surface
  vertex[] vertices = new vertex[12];
  
  int cubeindex = 0;
  for(int i = 0; i < 8; i++) {
    if(cubePoints[i].val < isoValue) cubeindex |= (int)pow(2, i);
  }
  
  // Cube is inside or outside the surface
  if(edgeTable[cubeindex] == 0) return;
  
  // Vertices where cube intersects the surface
  if((edgeTable[cubeindex] & 1) != 0) vertices[0] = interpolate(cubePoints[0],cubePoints[1]);
  if((edgeTable[cubeindex] & 2) != 0) vertices[1] = interpolate(cubePoints[1],cubePoints[2]);
  if((edgeTable[cubeindex] & 4) != 0) vertices[2] = interpolate(cubePoints[2],cubePoints[3]);
  if((edgeTable[cubeindex] & 8) != 0) vertices[3] = interpolate(cubePoints[3],cubePoints[0]);
  if((edgeTable[cubeindex] & 16) != 0) vertices[4] = interpolate(cubePoints[4],cubePoints[5]);
  if((edgeTable[cubeindex] & 32) != 0) vertices[5] = interpolate(cubePoints[5],cubePoints[6]);
  if((edgeTable[cubeindex] & 64) != 0) vertices[6] = interpolate(cubePoints[6],cubePoints[7]);
  if((edgeTable[cubeindex] & 128) != 0) vertices[7] = interpolate(cubePoints[7],cubePoints[4]);
  if((edgeTable[cubeindex] & 256) != 0) vertices[8] = interpolate(cubePoints[0],cubePoints[4]);
  if((edgeTable[cubeindex] & 512) != 0) vertices[9] = interpolate(cubePoints[1],cubePoints[5]);
  if((edgeTable[cubeindex] & 1024) != 0) vertices[10] = interpolate(cubePoints[2],cubePoints[6]);
  if((edgeTable[cubeindex] & 2048) != 0) vertices[11] = interpolate(cubePoints[3],cubePoints[7]);
  
  // Create Triangles
  for(int j = 0; triTable[cubeindex][j] != -1; j+=3) {
    triangle t = new triangle();
    t.v1 = vertices[triTable[cubeindex][j]];
    t.v2 = vertices[triTable[cubeindex][j+1]];
    t.v3 = vertices[triTable[cubeindex][j+2]];
    triangles.add(t);
  }
  
}

vertex interpolate(point p1, point p2) {
 // Linear interpolation between two points, taken from paul bourke

 float mu;
 vertex p = new vertex(0,0,0);
 
 if(abs(isoValue-p1.val) < 0.00001) return new vertex(p1.x,p1.y,p1.z);
 if(abs(isoValue-p2.val) < 0.00001) return new vertex(p2.x,p2.y,p2.z);
 if(abs(p1.val-p2.val) < 0.00001) return new vertex(p1.x,p1.y,p1.z);
 
 mu = (isoValue - p1.val) / (p2.val - p1.val);
 p.x = p1.x + mu * (p2.x - p1.x);
 p.y = p1.y + mu * (p2.y - p1.y);
 p.z = p1.z + mu * (p2.z - p1.z);
 
 return p;
}
