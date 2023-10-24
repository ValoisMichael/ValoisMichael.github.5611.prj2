class Node {
  Vec2 position;   
  Vec2 velocity;  
  Vec2 force;     
  float mass; 
  boolean pinned; 
  boolean dragged = false; 
  Vec2 dragOffset = new Vec2(0, 0);

  Node(Vec2 position, float mass) {
    this.position = position;
    this.velocity = new Vec2(0, 0);
    this.force = new Vec2(0, 0);
    this.mass = mass;
    this.pinned = false;
  }

  // Updates node's movement
  void update(float dt) {
    if (!pinned) {
      Vec2 acceleration = this.force.times(1.0 / this.mass);
      this.velocity.add(acceleration.times(dt));
      this.position.add(this.velocity.times(dt));
      this.force = new Vec2(0, 0);
    }
  }
  void updatePosition() {
    if (dragged) {
      position.x = mouseX + dragOffset.x;
      position.y = mouseY + dragOffset.y;
    }
  }
  
  // Gravity
  void applyForce(Vec2 externalForce) {
    if (!pinned) {
      this.force.add(externalForce);
    }
  }

  // Sets top node to a fixed status
  void pin() {
    pinned = true;
  }
  
  // Used for rope grabbing
  boolean isMouseOver(float mouseX, float mouseY) {
    float d = dist(mouseX, mouseY, position.x, position.y);
    return d < 10;
  }
  
  // Calculates collision detection and effect with sphere
  void collideWithSphere(float sphereX, float sphereY, float sphereRadius) {
    float d = dist(sphereX, sphereY, position.x, position.y);
    if (d < sphereRadius) {

      Vec2 collisionNormal = new Vec2(position.x - sphereX, position.y - sphereY);
      collisionNormal.normalize();
      
      float dot = velocity.dot(collisionNormal);
      if (dot < 0) {
        Vec2 reflection = collisionNormal.times(1.5 * dot).minus(velocity);
        velocity = reflection;
      }
    }
  }
}
