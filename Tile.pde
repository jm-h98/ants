class Tile{
  int x, y, size;
  PVector col;
  
  Tile(int x, int y, int size){
    this.x = x;
    this.y = y;
    this.size = size;
    this.col = new PVector(0,0,0);
  }
  
  void paint(){
     fill(this.col.x, this.col.y, this.col.z);
     stroke(200);
     rect(x*size, y*size, size, size);
  }
}
