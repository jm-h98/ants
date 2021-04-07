class Pheromone{
  PVector position;
  int strength;
  Ant creator;
  
  Pheromone(int x, int y, Ant creator){
    this.position = new PVector(x, y);
    this.strength = pheromoneStrength;
    this.creator = creator;
  }
  
  void weaken(){
    strength--;
  }
  
  void paint(){
    int str = (int) (strength/pheromoneStrength) * 255;
    stroke(0,0,str);
    fill(0,0,str);
    circle(position.x, position.y, 2);
    //point(position.x, position.y);
  }
}
