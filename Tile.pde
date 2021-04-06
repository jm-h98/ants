class Tile{
  int x, y, size, type = 0;
  PVector col;
  boolean hasAnt = false;
  PVector position;
  
  Tile(int x, int y, int size){
    this.x = x;
    this.y = y;
    position = new PVector(x, y);
    this.size = size;
    this.col = new PVector(255,255,255);
  }
  
  void changeType(String type){
    if(type == "base"){
      this.type = 1;
      this.col = new PVector(207, 174, 117);
    }
  }
  
  void hasAnt(){
    hasAnt = true;
  }
  
  void paint(){
    if(hasAnt)
      fill(0,0,0);
    else
      fill(this.col.x, this.col.y, this.col.z);
    stroke(230);
    rect(x*size, y*size, size, size);
    hasAnt = false;
  }
  
  int getType(){
    return type;
  }
}
