class Wall{
  PVector position;
  
  Wall(int x, int y){
    this.position = new PVector(x, y);
  }
  
  void paint(){
    stroke(100);
    fill(100);
    circle(position.x, position.y, 20);
  }
}
