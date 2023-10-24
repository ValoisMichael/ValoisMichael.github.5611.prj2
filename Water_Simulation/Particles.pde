class Particle {
  PVector position;
  PVector velocity;
  PVector positionPrev;
  PVector deltaX;
  ArrayList<Particle> neighbors;
  float density, densityNear, pressure, pressureNear;
  boolean rigid;

  Particle(float x, float y, boolean r) {
    position = new PVector(x, y);
    velocity = new PVector();
    neighbors = new ArrayList<Particle>();
    deltaX = new PVector(0, 0);
    rigid = r;
  }

  // Draws each particle with given color based on pressure
  void plot() {
    strokeWeight(10);
    if (rigid) {
      stroke(217, 178, 91);
    } else {
      float hue = map(pressure, -0.07, -0.01, 245, 0);
      if (position.y > 398 || position.x >= width || position.x <= 0) {
        stroke(217, 178, 91);
      } else {
        stroke(hue - 10, hue + 20, 235);
      }
    }
    point(position.x, position.y);
  }

  void findNeighbors(Spawn s) {
    Area a = s.getArea(position.x, position.y);
    if (a != null) {
      neighbors = a.particles;
    }
  }
}
