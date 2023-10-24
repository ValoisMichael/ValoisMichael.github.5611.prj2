class Link {
  Node node1;  
  Node node2;
  float restLength;  
  float stiffness;   

  Link(Node node1, Node node2, float restLength, float stiffness) {
    this.node1 = node1;
    this.node2 = node2;
    this.restLength = restLength;
    this.stiffness = stiffness;
  }
  
  // Hooke's Law in motion
  void solve() {
    Vec2 delta = node2.position.minus(node1.position);
    float currentLength = delta.magnitude;
    
    float displacement = currentLength - restLength;
    Vec2 springForce = delta.times(-stiffness * (displacement / currentLength));
  
    Vec2 relativeVelocity = node2.velocity.minus(node1.velocity);
    float dampingFactor = 2; 
    Vec2 dampingForce = relativeVelocity.times(dampingFactor);
  
    node1.applyForce(springForce.plus(dampingForce));
    node2.applyForce(springForce.times(-1).plus(dampingForce.times(-1))); 
  }
  
  // Draw rope
  void display() {
    stroke(219, 187, 96); 
    line(node1.position.x, node1.position.y, node2.position.x, node2.position.y);
  }
}
