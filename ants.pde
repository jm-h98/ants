PFont font;
ArrayList<Ant> ants;
int antCount = 1000;
ArrayList<Food> food;
ArrayList<Lava> lava;
ArrayList<Pheromone> pheromones;
ArrayList<Wall> walls;
int foodStorage = 20;
boolean start = false;
String item = "Food";

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
  font = createFont("Arial Bold",25);
  
  ants = new ArrayList<Ant>();
    
  maxForce = (float) (maxForce * timeScale);
  maxSpeed = (int) (maxSpeed * timeScale);
  
  food = new ArrayList<Food>();
  pheromones = new ArrayList<Pheromone>();
  walls = new ArrayList<Wall>();
  lava = new ArrayList<Lava>();
}

void draw(){
  background(150);
  stroke(207, 174, 117);
  fill(207, 174, 117);
  circle(width/2, height/2, 50);
  
  textFont(font,25);
  fill(200);
  text(int(frameRate)+ " fps",width - 75,25);
  text("Ants: " + ants.size(),15,25);
  text("Food stored: " + foodStorage,15,50);
  text("Selected item: " + item,15,75);
  
  ArrayList<Ant> toDelete3 = new ArrayList<Ant>();
  for(Ant a : ants){
    //move ant
    a.edges();
    a.move();
    a.update();
    for(Lava l : lava){
      if(a.position.dist(l.position) < l.radius)
        toDelete3.add(a);
    }
  }
  for(Ant a : toDelete3)
    ants.remove(a);
  
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
    
  for(Lava l : lava){
    l.paint();
  }
}
 
void mouseReleased() {
  if(item.equals("Food"))
    food.add(new Food(mouseX, mouseY));
  else if(item.equals("Wall"))
    walls.add(new Wall(mouseX, mouseY));
  else if(item.equals("Lava"))
    lava.add(new Lava(mouseX, mouseY));
  else if(item.equals("Ant")){
    if(foodStorage > 1){
      ants.add(new Ant(mouseX, mouseY));
      foodStorage -= 2;
    }
  }
}

void keyPressed(){
  if(key == 's'){
    if(!start)
      for(int i = 0; i < antCount; i++)
        ants.add(new Ant(width/2, height/2));
    start = true;
  }
  if(key == 'w'){
    item = "Wall";
  }
  if(key == 'f'){
    item = "Food";
  }
  if(key == 'l'){
    item = "Lava";
  }
  if(key == 'a'){
    item = "Ant";
  }
}
