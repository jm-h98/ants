ArrayList<Ant> ants;
int antCount = 1000;
ArrayList<Food> food;
ArrayList<Pheromone> pheromones;
boolean onPressed = false;
ArrayList<Wall> walls;


float maxForce = 1, maxSpeed = 5;
double timeScale = 0.5;
float homesick = 0.1,
      hunger = 0.5,
      drunkenness = 0.25,
      phAttraction = 0.05,
      wallValue = 1.5;
int pheromoneStrength = 200, phSpeed = 40, foodSupply = 200;

void settings(){
  size(1920, 1080, P2D);
}

void setup() {
  //fullScreen(P2D);
  frameRate(60);
  colorMode(RGB);
  
  ants = new ArrayList<Ant>();
  for(int i = 0; i < antCount; i++)
    ants.add(new Ant(width/2, height/2));
    
  maxForce = (float) (maxForce * timeScale);
  maxSpeed = (int) (maxSpeed * timeScale);
  
  food = new ArrayList<Food>();
  food.add(new Food(100, 100));
  
  pheromones = new ArrayList<Pheromone>();
  walls = new ArrayList<Wall>();
}

void draw(){
  background(150);
  stroke(207, 174, 117);
  fill(207, 174, 117);
  circle(width/2, height/2, 50);
  
  if(onPressed && (mouseButton == LEFT))
    food.add(new Food(mouseX, mouseY));
  else if(onPressed && (mouseButton == RIGHT))
    walls.add(new Wall(mouseX, mouseY));
    
  println("Framerate: " + frameRate);
  
  for(Ant a : ants){
    //move ant
    a.edges();
    a.move();
    a.update();
  }
  
  ArrayList<Food> toDelete = new ArrayList<Food>();
  for(Food f : food){
    f.paint();
    if(f.nutrition <= 0)
      toDelete.add(f);
  }
  for(Food f : toDelete)
    food.remove(f);
    
  ArrayList<Pheromone> toDeleteP = new ArrayList<Pheromone>();
  for(Pheromone p : pheromones){
    p.paint();
    p.weaken();
    if(p.strength <= 0)
      toDeleteP.add(p);
  }
  for(Pheromone p : toDeleteP)
    pheromones.remove(p);
   
  for(Wall w : walls)
    w.paint();
}

void mousePressed() {
  onPressed = true;
}
 
void mouseReleased() {
  onPressed = false;
}
