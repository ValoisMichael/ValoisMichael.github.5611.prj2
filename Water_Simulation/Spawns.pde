class Spawn {
  Area[] areas;
  int numWidth, numHeight;
  float h;

  Spawn(float width, float height, float h) {
    this.h = h;
    numWidth = ceil(width / h);
    numHeight = ceil(height / h);
    areas = new Area[numWidth * numHeight];
    for (int i = 0; i < areas.length; i++) {
      areas[i] = new Area();
    }
  }

  // Creates spawn area
  Area getArea(float x, float y) {
    int indexWidth = floor(x / h);
    int indexHeight = floor(y / h);
    int index = indexWidth * numHeight + indexHeight;
    return (indexWidth >= 0 && indexWidth < numWidth && indexHeight >= 0 && indexHeight < numHeight) ? areas[index] : null;
  }

  // Adds all particles
  void addParticle(Particle p) {
    for (int i = -1; i < 2; i++) {
      for (int j = -1; j < 2; j++) {
        float x = p.position.x + h * float(i);
        float y = p.position.y + h * float(j);
        Area a = getArea(x, y);
        if (a != null) {
          a.particles.add(p);
        }
      }
    }
  }

  void clearSpawn() {
    for (Area area : areas) {
      area.particles.clear();
    }
  }
}

// Stores particles in Area array
class Area {
  ArrayList<Particle> particles;

  Area() {
    particles = new ArrayList<Particle>();
  }
}
