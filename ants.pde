ArrayList<Ant> ants;
int antCount = 100, tileSize = 10;
Tile[][] tiles = new Tile[160][90];

float maxForce = 1, maxSpeed = 5;
double timeScale = 0.5;
float homesick = 2;

void settings(){
  size(tiles.length*tileSize, tiles[0].length*tileSize, P2D);
}

void setup() {
  //fullScreen(P2D);
  frameRate(30);
  colorMode(RGB);
  for(int i = 0; i < tiles.length; i++){
    for(int j = 0; j < tiles[0].length; j++){
      tiles[i][j] = new Tile(i, j, tileSize);
      
      //generate base
      if(i >= (int)(tiles.length/2) - 2 && i <= (int)(tiles.length/2) + 1){
        if(j >= (int)(tiles[0].length/2) - 2 && j <= (int)(tiles[0].length/2) + 1){
          tiles[i][j].changeType("base");
        }
      }
    }
  }
  ants = new ArrayList<Ant>();
  for(int i = 0; i < antCount; i++)
    ants.add(new Ant((int)(Math.random() * height), (int)(Math.random() * width)));
    
  maxForce = (float) (maxForce * timeScale);
  maxSpeed = (int) (maxSpeed * timeScale);
}

void draw(){
  background(100);
  println("Framerate: " + frameRate);
  ArrayList<Tile> tileArray = new ArrayList<Tile>();
  
  for(int i = 0; i < tiles.length; i++){
    for(int j = 0; j < tiles[0].length; j++){
      tiles[i][j].paint();
    }
  }
  
  for(int i = 0; i < tiles.length; i++){
    for(int j = 0; j < tiles[0].length; j++){
      tileArray.add(tiles[i][j]);
    }
  }
  
  for(Ant a : ants){
    //move ant
    a.edges();
    a.move(tileArray);
    a.update();
  }
}
