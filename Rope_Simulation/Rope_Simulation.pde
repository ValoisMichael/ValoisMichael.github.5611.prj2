int numNodes = 25;
float chainLength = 3.8;
float nodeSpacing = chainLength / (numNodes - 1);
float dt = 0.05;
int numSubsteps = 100;
int numRelaxationSteps = 10;
float stiffness = -1.0;

// Rope 1
Node[] nodes1 = new Node[numNodes];
Link[] links1 = new Link[numNodes - 1];

// Rope 2
Node[] nodes2 = new Node[numNodes];
Link[] links2 = new Link[numNodes - 1];

// Initializes both ropes
void setup() {
  for (int i = 0; i < numNodes; i++) {
    float x = (width / 2) + i * 5;
    float y = 100;
    nodes1[i] = new Node(new Vec2(x-20, y), 1.0);
    nodes2[i] = new Node(new Vec2(x+20, y), 1.0);
  }
  nodes1[0].pin();
  nodes2[0].pin();
   
  for (int i = 0; i < numNodes - 1; i++) {
    links1[i] = new Link(nodes1[i], nodes1[i + 1], nodeSpacing, stiffness);
    links2[i] = new Link(nodes2[i], nodes2[i + 1], nodeSpacing, stiffness);
  }

  size(800, 500);
}

// Reset scene
void keyPressed() {
  if (key == 'r' || key == 'R') {
    setup();
  }
}

// Update ropes based on Hooke's Law
void draw() {
  background(0);
  
  fill(92, 8, 2);
  ellipse(width/2, 300, 60, 60);

  for (int substep = 0; substep < numSubsteps; substep++) {
    for (int relaxationStep = 0; relaxationStep < numRelaxationSteps; relaxationStep++) {
      for (Node node : nodes1) {
        float gravity = 1;
        node.applyForce(new Vec2(0, gravity * node.mass));
      }
      for (Node node : nodes2) {
        float gravity = 1;
        node.applyForce(new Vec2(0, gravity * node.mass));
      }
      for (Node node : nodes1) {
        node.collideWithSphere(width/2, 300, 30);
        node.update(dt / numSubsteps);
        node.updatePosition();
      }
      for (Node node : nodes2) {
        node.collideWithSphere(width/2, 300, 30);
        node.update(dt / numSubsteps);
        node.updatePosition();
      }
      for (Link link : links1) {
        link.solve();
      }
      for (Link link : links2) {
        link.solve();
      }
    }
  }

  // Display both ropes
  for (Link link : links1) {
    link.display();
  }
  for (Link link : links2) {
    link.display();
  }
}

// Handle rope grabbing
void mousePressed() {
  for (Node node : nodes1) {
    if (node.isMouseOver(mouseX, mouseY) && !node.pinned) {
      node.dragged = true;
      node.dragOffset.x = node.position.x - mouseX;
      node.dragOffset.y = node.position.y - mouseY;
    }
  }
  for (Node node : nodes2) {
    if (node.isMouseOver(mouseX, mouseY) && !node.pinned) {
      node.dragged = true;
      node.dragOffset.x = node.position.x - mouseX;
      node.dragOffset.y = node.position.y - mouseY;
    }
  }
}
void mouseReleased() {
  for (Node node : nodes1) {
    node.dragged = false;
  }
  for (Node node : nodes2) {
    node.dragged = false;
  }
}
