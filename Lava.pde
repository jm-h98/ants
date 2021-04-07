class Lava{
  PVector position;
  int radius = 20;
  
  Lava(int x, int y){
    this.position = new PVector(x, y);
  }
  
  void paint(){
    stroke(255,0,0);
    fill(255,0,0);
    circle(position.x, position.y, radius);
  }
}
