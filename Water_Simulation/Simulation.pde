float timeStep = 2;
float stepsPerFrame = 2;
float dropSize = 30;
Liquid liquid;

void setup() {
  size(800, 400);
  liquid = new Liquid(timeStep, dropSize);

  float clumpX = width * 0.4;
  float clumpY = height * 0.2;

  // Sets starting water spawn size
  for (float x = clumpX; x < clumpX + 100; x += dropSize * 0.25) {
    for (float y = clumpY; y < clumpY + 200; y += dropSize * 0.25) {
      liquid.particles.add(new Particle(x, y, false));
    }
  }
  
  // Creates Boundaries and Obsticales
  createBorders();
  for (float y = height - 60; y < height; y += dropSize * 0.1) {
    liquid.particles.add(new Particle(width * 0.7, y, true));
    liquid.particles.add(new Particle(width * 0.7 + dropSize * 0.001, y, true));
    liquid.particles.add(new Particle(width * 0.4, y - 30, true));
    liquid.particles.add(new Particle(width * 0.4 + dropSize * 0.001, y - 30, true));
  }
}

void draw() {
  background(101, 188, 235);

  // Draw the sun
  drawEllipses();

  // Handles adding water via mouse
  if (mousePressed) {
    for (int i = 0; i < 4; i++) {
      liquid.particles.add(new Particle(mouseX + random(dropSize), mouseY + random(dropSize), false));
    }
  }
  
  // Update water 
  for (int i = 0; i < stepsPerFrame; i++) {
    liquid.step();
  }
  liquid.plot();
}

// Creates window borders
void createBorders() {
  for (float x = 0; x < width; x += dropSize * 0.1) {
    liquid.particles.add(new Particle(x, height, true));
  }
  for (float y = 150; y < height; y += dropSize * 0.1) {
    liquid.particles.add(new Particle(0, y, true));
    liquid.particles.add(new Particle(width, y, true));
  }
}

// Draws the sun the the sky
void drawEllipses() {
  stroke(140, 202, 211);
  fill(178, 216, 188);
  ellipse(width * 0.7, 50, 80, 80);
  stroke(217, 230, 164);
  fill(255, 244, 140);
  ellipse(width * 0.7, 50, 50, 50);
  stroke(217, 178, 91);
  fill(217, 178, 91);
  ellipse(width * 0.7, height, 30, 130);
  ellipse(width * 0.4, height-60, 30, 70);
}
