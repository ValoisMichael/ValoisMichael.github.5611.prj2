float startTime, dt;
float k = 30, damp = 0.7;
float boxSize = 20000;
float clothX = 140, clothY = 200, clothZ = -150;
float sphereX = 0, sphereZ = 0;
float fanForce = 0;

// Cloth arays
int numRows = 20, numCols = 50;
PVector[][] posArray = new PVector[numRows][numCols];
PVector[][] velArray = new PVector[numRows][numCols];
PVector[][] newVelArray = new PVector[numRows][numCols];

PImage img;

// Camera
PVector cameraPos = new PVector(640, 240, 260);
PVector centerPos = new PVector(400, 300, -300);
float rotation = 65;

// Sets up window, texture, and cloth
void setup() {
  fullScreen(P3D);
  img = loadImage("cloth_texture.jpg");
  startTime = millis();
  initializeCloth();
}

void draw() {  
  // Camera Code
  if (keyPressed) {
    handleCameraMovement();
  }
  camera(cameraPos.x, cameraPos.y, cameraPos.z, centerPos.x, centerPos.y, centerPos.z, 0, 1, 0);
  background(0, 0, 0);
  
  // Lighting
  pointLight(255,255,255, 300, 0, 0);
  ambientLight(40, 40, 40);
  
  dt = (millis() - startTime)/1000;
  startTime = millis();
  
  // Cloth simulation
  updateCloth();
  drawCloth();
  
  // Bounding Box
  pushMatrix();
  translate(0, 550, 0);
  fill(50);
  box(boxSize, 10, boxSize);
  popMatrix();
  
  // Sphere controls and display
  pushMatrix();
  if (keyPressed == true) {
     if (key == '3') {
       sphereX = sphereX + 1.5;
     }
     if (key == '1') {
       sphereX = sphereX - 1.5;
     }
     if (key == '2') {
       sphereZ = sphereZ + 1.5;
     }
     if (key == '5') {
       sphereZ = sphereZ - 1.5;
     }
  }
  translate(400 + sphereX, 400, -150 + sphereZ);
  noStroke();
  fill(150);
  sphere(99.5);
  popMatrix();
}

// Handles camera movement
void handleCameraMovement() {
  if (keyPressed == true) {
    // Arrow keys
    if (key == CODED) { 
      if (keyCode == UP) {
        cameraPos.y = cameraPos.y-4;
        centerPos.y = centerPos.y-4;
      } else if (keyCode == DOWN) {
        cameraPos.y = cameraPos.y+4;
        centerPos.y = centerPos.y+4;
      } else if (keyCode == LEFT) {
        PVector strafedir = new PVector(centerPos.z - cameraPos.z, cameraPos.y, cameraPos.x - centerPos.x);
        strafedir.normalize();
        cameraPos.x = cameraPos.x + strafedir.x * 4; 
        cameraPos.z = cameraPos.z + strafedir.z * 4;
        centerPos.x = centerPos.x + strafedir.x * 4; 
        centerPos.z = centerPos.z + strafedir.z * 4;
      } else if (keyCode == RIGHT) {
        PVector strafedir = new PVector(centerPos.z - cameraPos.z, cameraPos.y, cameraPos.x - centerPos.x);
        strafedir.normalize();
        cameraPos.x = cameraPos.x - strafedir.x * 4; 
        cameraPos.z = cameraPos.z - strafedir.z * 4;
        centerPos.x = centerPos.x - strafedir.x * 4; 
        centerPos.z = centerPos.z - strafedir.z * 4;
      }
      // WASD
    } else if (key == 'w') {
      PVector zoomdir = new PVector(cameraPos.x - centerPos.x, cameraPos.y - centerPos.y, cameraPos.z - centerPos.z);
      zoomdir.normalize();
      cameraPos.x = cameraPos.x - zoomdir.x * 4; 
      cameraPos.y = cameraPos.y - zoomdir.y * 4; 
      cameraPos.z = cameraPos.z - zoomdir.z * 4; 
    } else if (key == 's') {
      PVector zoomdir = new PVector(cameraPos.x - centerPos.x, cameraPos.y - centerPos.y, cameraPos.z - centerPos.z);
      zoomdir.normalize();
      cameraPos.x = cameraPos.x + zoomdir.x * 4; 
      cameraPos.y = cameraPos.y + zoomdir.y * 4; 
      cameraPos.z = cameraPos.z + zoomdir.z * 4;
    } else if (key == 'a') {
      rotation++;
      float radius = (sqrt((cameraPos.x - centerPos.x)*(cameraPos.x - centerPos.x) + (cameraPos.z - centerPos.z)*(cameraPos.z - centerPos.z)));
      cameraPos.x = centerPos.x+radius*cos(radians(rotation));
      cameraPos.z = centerPos.z+radius*sin(radians(rotation));
    } else if (key == 'd') {
      rotation--;
      float radius = (sqrt((cameraPos.x - centerPos.x)*(cameraPos.x - centerPos.x) + (cameraPos.z - centerPos.z)*(cameraPos.z - centerPos.z)));
      cameraPos.x = centerPos.x+radius*cos(radians(rotation));
      cameraPos.z = centerPos.z+radius*sin(radians(rotation));
    }  
  }
}

// Initializes the Cloth
void initializeCloth() {
 for (int i = 0; i < numRows; i++) {
    clothZ += 10;
    clothX = 140;
    for (int j = 0; j < numCols; j++) {
      clothX += 10;
      posArray[i] [j] = new PVector(clothX, clothY, clothZ);
      velArray[i] [j] = new PVector(0, 0, 0);
    }
  }
  clothX += 10; 
}

// Handles texturing and rendering the cloth
void drawCloth() {
    for (int i = 0; i < (numRows-1); i++) {
      for (int j = 0; j < (numCols-1); j++) {
        PVector p1 = posArray[i][j];
        PVector p2 = posArray[i][j+1];
        PVector p3 = posArray[i+1][j];
        PVector p4 = posArray[i+1][j+1];
        
        pushMatrix();
        beginShape(TRIANGLES);
        texture(img);
        
        // Triangle 1
        vertex(p1.x, p1.y, p1.z, 0, 0);
        vertex(p2.x, p2.y, p2.z, 20, 0);
        vertex(p3.x, p3.y, p3.z, 0, 20);
        
        // Triangle 2
        vertex(p2.x, p2.y, p2.z, 20, 0);
        vertex(p3.x, p3.y, p3.z, 0, 20);
        vertex(p4.x, p4.y, p4.z, 20, 20);
        
        endShape();
        popMatrix();
      }
    }
}

void updateCloth() {
 newVelArray = velArray;
 
 // Updates the horizontal and vertical spring forces
 for (int i = 0; i < (numRows-1); i++) {
   for (int j = 0; j < numCols; j++) {
     PVector dir = PVector.sub(posArray[i][j], posArray[i+1][j]);
     float len = dir.mag();
     dir.normalize();
     float v1 = dir.dot(velArray[i][j]);
     float v2 = dir.dot(velArray[i+1][j]);
     float force = k * (10 - len) - damp * (v1 - v2);
     newVelArray[i][j] = PVector.add(newVelArray[i][j], PVector.mult(dir, force));
     newVelArray[i+1][j] = PVector.sub(newVelArray[i+1][j], PVector.mult(dir, force));
   }
 }
 for (int i = 0; i < numRows; i++) {
   for (int j = 0; j < (numCols-1); j++) {
     PVector dir = PVector.sub(posArray[i][j], posArray[i][j+1]);
     float len = dir.mag();
     dir.normalize();
     float v1 = dir.dot(velArray[i][j]);
     float v2 = dir.dot(velArray[i][j+1]);
     float force = k * (10 - len) - damp * (v1 - v2);
     newVelArray[i][j] = PVector.add(newVelArray[i][j], PVector.mult(dir, force));
     newVelArray[i][j+1] = PVector.sub(newVelArray[i][j+1], PVector.mult(dir, force));
   }
 }
 
 // Uplies gravity
 PVector grav = new PVector(0, 4, 0);
 for (int i = 0; i < numRows; i++) {
   for (int j = 0; j < numCols; j++) {
     newVelArray[i][j] = PVector.add(newVelArray[i][j], grav);
   }
 }
 
 // Uplies the fan air drag
 for (int i = 0; i < numRows; i++) {
    for (int j = 0; j < numCols; j++) {
      PVector fan = new PVector(0, 0, fanForce);
      newVelArray[i][j].add(fan);
    }
  }
  
 // Uplies drag
 for (int i = 0; i < (numRows-1); i++) {
   for (int j = 0; j < (numCols-1); j++) {
     PVector v1 = newVelArray[i][j];
     PVector v2 = newVelArray[i][j+1];
     PVector v3 = newVelArray[i+1][j];
     PVector v4 = newVelArray[i+1][j+1];
     
     PVector p1 = posArray[i][j];
     PVector p2 = posArray[i][j+1];
     PVector p3 = posArray[i+1][j];
     PVector p4 = posArray[i+1][j+1];
     
     PVector vVector = PVector.add(PVector.add(v1, v2), v3);
     vVector.div(3);
     float vScalar = vVector.mag();
     PVector n = PVector.sub(p3, p1).cross(PVector.sub(p2, p1));
     PVector drag = n.mult(-.0000025 * vScalar * (vVector.dot(n))/(2*n.mag())).div(3);
     newVelArray[i][j] = PVector.add(newVelArray[i][j], drag);
     newVelArray[i][j+1] = PVector.add(newVelArray[i][j+1], drag);
     newVelArray[i+1][j] = PVector.add(newVelArray[i+1][j], drag);
     
     PVector nvVector = PVector.add(PVector.add(v4, v2), v3);
     nvVector.div(3);
     float nvScalar = nvVector.mag();
     PVector nn = PVector.sub(p3, p4).cross(PVector.sub(p2, p4));
     PVector ndrag = nn.mult(-.0000025 * nvScalar * (nvVector.dot(nn))/(2*nn.mag())).div(3);
     newVelArray[i+1][j+1] = PVector.add(newVelArray[i+1][j+1], ndrag);
     newVelArray[i][j+1] = PVector.add(newVelArray[i][j+1], ndrag);
     newVelArray[i+1][j] = PVector.add(newVelArray[i+1][j], ndrag);
   }
 }
 // Sets the top row to be stationary
 for (int i = 0; i < numCols; i++) {
     newVelArray[0][i] = new PVector(0, 0, 0);
 }
 
 //Updates all positions
 PVector spherePos = new PVector(400 + sphereX, 400, -150 + sphereZ);
 for (int i = 0; i < numRows; i++) {
   for (int j = 0; j < numCols; j++) {
     posArray[i][j] = PVector.add(posArray[i][j], PVector.mult(newVelArray[i][j], .01));
     float d = posArray[i][j].dist(spherePos);
     if (d < 101) {
       PVector n = PVector.sub(posArray[i][j], spherePos);
       n.normalize();
       PVector bounce = PVector.mult(n, newVelArray[i][j].dot(n));
       newVelArray[i][j] = PVector.sub(newVelArray[i][j], PVector.mult(bounce, 1.25));
       posArray[i][j] = PVector.add(PVector.mult(n, 102 - d), posArray[i][j]);
     }
   }
 }
 velArray = newVelArray;
}
