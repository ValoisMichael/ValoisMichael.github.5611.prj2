// Same Vec2 code from HW 2
class Vec2 {
  float x, y, magnitude;
  
  Vec2(float x, float y){
    this.x = x;
    this.y = y;
    this.magnitude = sqrt(x*x + y*y);
  }
   
  Vec2 times(float rhs){
    return new Vec2(x*rhs, y*rhs);
  }
  
  void mul(float rhs){
    x *= rhs;
    y *= rhs;
  }
  
  Vec2 minus(Vec2 rhs){
    return new Vec2(x-rhs.x, y-rhs.y);
  }
  
  void subtract(Vec2 rhs){
    x -= rhs.x;
    y -= rhs.y;
  }
  
  Vec2 plus(Vec2 rhs){
    return new Vec2(x+rhs.x, y+rhs.y);
  }
  
  void add(Vec2 rhs){
    x += rhs.x;
    y += rhs.y;
  }

  void normalize(){
    x /= magnitude;
    y /= magnitude;
  }
  
  float cross(Vec2 rhs){
    return ((x * rhs.y) - (y * rhs.x));
  }
  
  float dot(Vec2 rhs){
    return ((x * rhs.x) + (y * rhs.y));
  }
  
  float distance(Vec2 v2) {
    float dx = x - v2.x;
    float dy = y - v2.y;
    return sqrt(dx * dx + dy * dy);
  }
  
  String toString() {
    return "Vec2(" + x + ", " + y + ")";
  }
}
