 class triangle {
  // class represents a triangle belonging to an isosurface
   
  vertex v1;
  vertex v2;
  vertex v3;
  
  PShape tri;
  
  void makeShape() {
   tri = createShape();
   tri.beginShape(TRIANGLES);
   tri.fill(v1.x/(gap*dimension),v1.y/(gap*dimension),v1.z/(gap*dimension));
   tri.vertex(v1.x,v1.y,v1.z);
   tri.vertex(v2.x,v2.y,v2.z);
   tri.vertex(v3.x,v3.y,v3.z);
   tri.endShape();
  }
  
  void draw() {
   shape(tri,0,0);
  }
}


class vertex {
  // class represents a vertex on a  triangle
  // difference from point class is no value + floating point

 vertex(float xVal, float yVal, float zVal) {
  x = xVal; y = yVal; z = zVal; 
 }
 
 float x;
 float y;
 float z;
}

void drawTriangles() {
 // calls the draw function for all triangles
 
 for(int i = 0; i < triangles.size(); i++) {
   triangle t = triangles.get(i);
   t.draw();
 }
}
