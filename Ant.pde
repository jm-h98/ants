class Ant {
  PImage default_skin = loadImage("ant.png"),
         weeb_skin = loadImage("ant_weeb_skin.png");
  int x, y;
  PVector velocity, position, acceleration;
  int visionRadius = 150, phTick = 0;
  boolean hasFood = false;

  Ant(int x, int y){
    this.position = new PVector(x, y);
    this.velocity = PVector.random2D();
    this.velocity.setMag(random(1, maxSpeed));
    this.acceleration = new PVector();
  }
  
  void move(){
    PVector base = new PVector(width/2, height/2);
    this.acceleration.add(this.homesickness(base));
    this.acceleration.add(this.hungriness());
    this.acceleration.add(PVector.random2D().mult(drunkenness));
    this.acceleration.add(this.attraction(base));
    this.acceleration.add(this.wallRepell());
  }
  
  void update(){
    this.position.add(this.velocity);
    this.velocity.add(this.acceleration);
    this.velocity.limit(maxSpeed);
    this.acceleration.mult(0);
    
    phTick--;
    if(phTick <= 0 && hasFood){
      pheromones.add(new Pheromone((int) position.x, (int) position.y, this));
      phTick = phSpeed;
    }
    paint();
  }
  
  PVector hungriness(){
    PVector steering = new PVector();
    int total = 0;
    for (Food f: food) {
      float d = f.position.dist(this.position);
      if(d <= 5 && !hasFood && f.nutrition > 0){
        f.eaten();
        hasFood = true;
        phTick = (int) (Math.random() * phSpeed);
      } else if (d < visionRadius && !hasFood) {
        steering.add(f.position);
        total++;
      }
    }
    if (total > 0) {
      steering.div(total);
      steering.sub(this.position);
      steering.setMag(maxSpeed);
      steering.sub(this.velocity);
      steering.limit(maxForce);
    }
    return steering.mult(hunger);
  }
  
  PVector attraction(PVector base){
    PVector steering = new PVector();
    int total = 0;
    for (Pheromone p : pheromones) {
      float d = p.position.dist(this.position);
      if (d < visionRadius && p.creator != this) {
        steering.add(p.position);
        total++;
      }
    }
    if (total > 0) {
      if(!hasFood){
        PVector hs = new PVector();
        hs.add(base.sub(this.position));
        hs.setMag(maxSpeed);
        hs.sub(this.velocity);
        hs.limit(maxForce);
        steering.add(hs.mult(-1));
        total++;
      }
      steering.div(total);
      steering.sub(this.position);
      steering.setMag(maxSpeed);
      steering.sub(this.velocity);
      steering.limit(maxForce);
    } 
    return steering.mult(phAttraction);
  }
  
  PVector wallRepell(){
    PVector steering = new PVector();
    int total = 0;
    for (Wall w : walls) {
      float d = w.position.dist(this.position);
      if (d < 22) {
        steering.add(w.position);
        total++;
      }
    }
    if (total > 0) {
      steering.div(total);
      steering.sub(this.position);
      steering.setMag(maxSpeed);
      steering.sub(this.velocity);
      steering.limit(maxForce);
    }
    return steering.mult(-1 * wallValue);
  }
  
  PVector homesickness(PVector base){
    PVector steering = new PVector();
    if(hasFood){
      float d = base.dist(this.position);
      if(d < 25){
        hasFood = false;
        foodStorage++;
      }
      steering.add(base.sub(this.position));
      steering.setMag(maxSpeed);
      steering.sub(this.velocity);
      steering.limit(maxForce);
    } 
    return steering.mult(homesick);
  }
  
  void paint(){
    imageMode(CENTER);
    PImage skin;
    if(hasFood)
      skin = weeb_skin;
    else
      skin = default_skin;
    translate(position.x, position.y);
    rotate(PVector.angleBetween(new PVector(0,1,0), this.velocity) + PI);
    image(skin, 0, 0);
    rotate(-(PVector.angleBetween(new PVector(0,1,0), this.velocity) + PI));
    translate(-position.x, -position.y);
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
