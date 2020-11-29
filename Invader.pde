class Invader {

  private float initX;
  private float initY;  
  private float posX;
  private float posY;
  
  private int invNum;
  
  private boolean dead;
  private boolean shotBullet;
  
  private float bulletX;
  private float bulletY;
  private float bulletSpeed;
  
  private boolean animationFrame;
  
  PImage inv11 = createImage(30, 30,RGB);
  PImage inv12 = createImage(30, 30,RGB);
  PImage inv2 = createImage(30, 30,RGB);
  
  public Invader(float inX, float inY, int inNum) {
    initX = inX;
    initY = inY;
    posX = inX;
    posY = inY;
    invNum = inNum;
    bulletSpeed = 11;
    dead = false;
    shotBullet = false;
    inv11 = loadImage("inv1-1.jpg");
    inv12 = loadImage("inv1-2.jpg");
    inv2 = loadImage("inv2.jpg");
  }
  
  public float getPosX() {
    return posX;
  }
  
  public float getPosY() {
    return posY;
  }
  
  public boolean isDead() {
    return dead;
  }
  
  public boolean hasShot() {
    return shotBullet;
  }

  public void setPosX(float inX) {
    posX = inX;
  }

  public void setPosY(float inY) {
    posY = inY;
  }
  
  public void show() {
    image(inv11,posX,posY,30,30);
  }
  
  public int show(float playerX, float playerY) {
      
    if(!dead && (invNum == 2 || invNum == 1)) {
      if(animationFrame) {
        image(inv11,posX,posY,30,30);
      }
        
      if(!animationFrame) {
        image(inv12,posX,posY,30,30);    
      }
    }
      
    if(!dead && (invNum == 3 || invNum == 4 || invNum == 5))
      image(inv2,posX,posY,30,30);
      
    if(shotBullet) {
      rect(bulletX, bulletY, 5, 10);
      bulletY+=bulletSpeed;
      if(collisionCheck(playerX, playerY) == 1) {
        return 1;
      }
    }
    return 0;
  }
  
  //@overloads
  public int show(float playerX, float playerY, float shieldX, float shieldY) {
    if(!dead)
      rect(posX, posY, 10, 10);
      
    if(shotBullet) {
      fill(255,200,200);
      rect(bulletX, bulletY, 15, 10);
      bulletY+=bulletSpeed;
      if(collisionCheck(playerX, playerY) == 1) {
        return 1;
      }
      if(collisionCheckShield(shieldX, shieldY) == 1) {
        return 2;
      }
    }
    return 0;
  }
  
  private int collisionCheck(float playerX, float playerY) {
    if(bulletY > playerY-5 && bulletY < playerY + 5) {
      if(bulletX > playerX-20 && bulletX < playerX+20) {
        shotBullet = false;
        return 1;
      }
    }
    return 0;
  }
  
  public int collisionCheckShield(float shieldX, float shieldY) {
    if(bulletY > shieldY-5 && bulletY < shieldY + 5) {
      if(bulletX > shieldX-5 && bulletX < shieldX+5) {
        shotBullet = false;
        return 1;
      }
    }
    return 0;
  }
  
  public void moveRight() {
    posX+=10;
  }
  
  public void moveLeft() {
    posX-=10;
  }
  
  public void incPosY() {
    posY+=40;
  }
  
  public void Kill() {
    dead = true;
  }
  
  public void Revive() {
    dead = false;
    posX = initX;
    posY = initY;
  }
  
  public void Shoot() {
    if(!dead) { // Only shoots if invader is present
      bulletX = posX;
      bulletY = posY;
      shotBullet = true;
    }
  }
  
  public void bullReset() {
    shotBullet = false;
  }
  
  public void SwitchImg() {
    animationFrame = !animationFrame;
  }
  
}