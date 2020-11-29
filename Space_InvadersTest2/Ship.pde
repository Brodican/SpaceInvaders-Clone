class Ship {
  
  private float posX;
  private float posY;
  
  public Ship(float inX, float inY) {
    posX = inX;
    posY = inY;
  }
  
  public void draw() {
    movement();
  }
  
  private void movement() {
    
  }
  
  private void show() {
    fill(50, 250, 50);
    rect(posX, posY, 31, 10);
    rect(posX+12, posY-8, 8, 8);
  }
  
  private void move(float spdChange) {
    posX+=spdChange;
  }
  
  public float getX() {
    return posX;
  }
  
  public float getY() {
    return posY;
  }
  
}