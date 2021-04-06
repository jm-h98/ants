ArrayList<Ant> ants;
int antCount = 100, tileSize = 20;
PVector base;
Tile[][] tiles = new Tile[30][20];

void settings(){
  size(tiles.length*tileSize, tiles[0].length*tileSize, P2D);
}

void setup() {
  //fullScreen(P2D);
  frameRate(60);
  colorMode(RGB);
  for(int i = 0; i < tiles.length; i++){
    for(int j = 0; j < tiles[0].length; j++){
      tiles[i][j] = new Tile(i, j, tileSize);
    }
  }
  base = new PVector(width/2, height/2);
  ants = new ArrayList<Ant>();
  for(int i = 0; i < antCount; i++)
    ants.add(new Ant());
}

void draw(){
  background(100);
  for(int i = 0; i < tiles.length; i++){
    for(int j = 0; j < tiles[0].length; j++){
      tiles[i][j].paint();
    }
  }
  
  stroke(255, 255, 255);
  circle(base.x, base.y, 20);
  
  for(Ant a : ants){
    a.paint();
  }
}
