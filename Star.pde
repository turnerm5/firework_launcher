//This is the actual class that is rendered when the charge explodes

class Star {
  PVector origin;
  PVector location;
  PVector velocity;
  PVector acceleration;

  color particleColor;
  float particleSize;
  
  float opacity;
  
  int lifespan;
  int accelDelay;
  float friction;
  
  //construct the particles!!
  Star(PVector origin_, color color_, int lifespan_) {

    location = origin_.get();
    velocity = new PVector();
    acceleration = new PVector();
    
    particleColor = color_;
    
    //default particle sizes
    particleSize = random(1,4);
    lifespan = lifespan_;
  }
  

  //standard run function
  void run() {
    update();
    display();
    lifespan--;
  }

  //run our physics updates
  void update() {
      velocity.add(acceleration);
      velocity.mult(.95);
      location.add(velocity);
      acceleration.mult(0);
  } 

  //Small function to do what it says
  void changeSize(float particleSize_) {
    particleSize = particleSize_; 
  }
  
  //Allow the charge to change the size of the star
  void multSize(float mult_) {
    particleSize *= mult_; 
  }
  
  //pass along any forces
  void applyForce(PVector force) {
    PVector f = force.get();
    acceleration.add(f); 
  }
  
  //pass along forces, but directly to velocity (more sudden)
  void detonate(PVector force) {
    PVector f = force.get();
    velocity.add(f); 
  }
  

  void display() {
      //they'll fade as they die!
      //map life
      int opacity = (int)map(lifespan,300,0,255,50);
      fill(particleColor, opacity);
      noStroke();
      pushMatrix();
      translate(location.x, location.y, location.z);
      box(particleSize);
      popMatrix();
  }
  
  void checkEdges() {
    if (location.x < 0) {
      location.x = 0;
      velocity.x *= -.97;
    } 
    else if (location.x > width) {
      location.x = width;
      velocity.x *= -.97;
    }

    if (location.y < 0) {
      location.y = 0;
      velocity.y *= -.97;
    } 
    else if (location.y > height - 2) {
      location.y = height;
      velocity.y *= -.97;
    }
  }
  
  boolean isDead() {
    if (lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }
  

  
}