class Ant {
  float x, y;
  PVector col = new PVector(0, 0, 0);
  int visionRadius = 50;

  Ant(){
    x = (float) Math.random() * width;
    y = (float) Math.random() * height;
  }
  
  void move(){
    
  }
  
  void paint(){
    stroke(col.x, col.y, col.z);
    point(x, y);
    point(x+1, y);
    point(x-1, y);
    point(x, y+1);
    point(x, y-1);
  }
}
