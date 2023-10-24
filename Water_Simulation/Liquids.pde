class Liquid {
  ArrayList<Particle> particles;
  PVector gravity;
  float deltaTime, kNear, k, h, rho0;
  Spawn spawn;

  Liquid(float deltaTime, float h) {
    particles = new ArrayList<Particle>();
    gravity = new PVector(0, 0.01).mult(deltaTime);
    this.deltaTime = deltaTime;
    kNear = 0.01;
    k = 0.007;
    this.h = h;
    rho0 = 10;
    spawn = new Spawn(width, height, h);
  }

  // Update particles position using SPH
  void step() {
    for (Particle p : particles) {
      if (!p.rigid) p.velocity.add(gravity);
      p.positionPrev = p.position.copy();
      p.position.add(PVector.mult(p.velocity, deltaTime));
    }
    
    // Handles movement calculation
    spawn.clearSpawn();
    for (Particle p : particles) spawn.addParticle(p);

    for (Particle p : particles) {
      p.findNeighbors(spawn);
      p.density = p.densityNear = 0;

      for (Particle pNeighbor : p.neighbors) {
        if (pNeighbor != p) {
          float r = (pNeighbor.position.dist(p.position));
          float q = r / h;
          if (q < 1) {
            float temp = 1 - q, tempSquared = temp * temp;
            p.density += tempSquared;
            p.densityNear += tempSquared * temp;
          }
        }
      }

      p.pressure = k * (p.density - rho0);
      p.pressureNear = kNear * p.densityNear;
      p.deltaX.mult(0);

      for (Particle pNeighbor : p.neighbors) {
        float r = (pNeighbor.position.dist(p.position));
        float q = r / h;
        if (q < 1) {
          PVector rVec = pNeighbor.position.copy().sub(p.position).normalize();
          PVector displacement = rVec.copy().mult(deltaTime * deltaTime * (p.pressure * (1 - q) + p.pressureNear * (1 - q) * (1 - q))).mult(0.5);
          if (!pNeighbor.rigid) pNeighbor.position.add(displacement);
          p.deltaX.sub(displacement);
        }
      }

      if (!p.rigid) p.position.add(p.deltaX);
    }

    // Constrains each particle
    for (Particle p : particles) {
      if (p.position.x < 0 || p.position.x > width || p.position.y < 0 || p.position.y > height) {
        p.position.x = constrain(p.position.x, 0, width);
        p.position.y = constrain(p.position.y, 0, height);
      }
      p.velocity = p.position.copy().sub(p.positionPrev).div(deltaTime);
    }
  }
  
  void plot() {
    for (Particle p : particles) p.plot();
  }
}
