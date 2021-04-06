class Ant {
  int x, y;
  PVector col = new PVector(0, 0, 0), velocity, position, acceleration;
  int visionRadius = 500;
  boolean hasFood = true;

  Ant(int x, int y){
    this.position = new PVector(x, y);
    this.velocity = PVector.random2D();
    println(velocity);
    this.velocity.setMag(random(1, maxSpeed));
    this.acceleration = new PVector();
  }
  
  void move(ArrayList<Tile> tiles){
    PVector base = new PVector(width/2, height/2);
    
    PVector homesickness = this.homesickness(base);
    
    homesickness.mult(homesick);
    
    this.acceleration.add(homesickness);
  }
  
  void update(){
    this.position.add(this.velocity);
    this.velocity.add(this.acceleration);
    this.velocity.limit(maxSpeed);
    this.acceleration.mult(0);
    
    
    stroke(0,0,0);
    circle(position.x, position.y, 5);
  }
  
  PVector homesickness(PVector position){
    PVector steering = new PVector();
    float d = position.dist(this.position);
    if(d <= 5 && hasFood){
      hasFood = false;
      steering = PVector.random2D();
    } else if(d <= visionRadius && hasFood){
      steering.add(position.sub(this.position));
      steering.setMag(maxSpeed);
      steering.sub(this.velocity);
      steering.limit(maxForce);
    }
    return steering;
  }
  
  PVector getCoords(){
    return position;
  }
  
  void edges() {
    if (this.position.x > width) {
      this.position.x = 0;
    } else if (this.position.x < 0) {
      this.position.x = width;
    }
    if (this.position.y > height) {
      this.position.y = 0;
    } else if (this.position.y < 0) {
      this.position.y = height;
    }
  }
}
