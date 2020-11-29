class Bullet {
  private float posX;
  private float posY;
  private float speedY;
  private boolean dead;
  
  public Bullet(float inX, float inY, float inSpeed) {
    posX = inX;
    posY = inY;
    speedY = inSpeed;
    dead = false;
  }
  
  public void moveUp() {
    posY-=speedY;
  }
  
  public void moveDown() {
    posY+=speedY;
  }
  
  public void show() {
    fill(255);
    if(dead == false)
      rect(posX, posY, 5, 5);
  }
  
  public float getY() {
    return posY;
  }
  
  public float getX() {
    return posX;
  }
  
  public void Kill(float inX) {
    posX = inX;
    posY = 980;
  }
}