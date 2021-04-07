class Food{
  PVector position;
  int nutrition;
  
  Food(int x, int y){
    position = new PVector(x, y);
    nutrition = foodSupply;
  }
  
  void eaten(){
    nutrition--;
  }
  
  void paint(){
    stroke(0,255,0);
    fill(0,255,0);
    circle(position.x, position.y, 5);
  }
}
