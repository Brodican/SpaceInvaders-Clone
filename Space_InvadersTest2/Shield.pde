class Shield {
  float posX;
  float posY;
  
  ShieldPiece[] shieldArr = new ShieldPiece[50];
  
  class ShieldPiece {
    float posX;
    float posY;
    boolean dead;
    
    public ShieldPiece(float inX, float inY) {
      posX = inX;
      posY = inY;
    }
    
    public void show() {
      if(!dead) {
        fill(20,200,20);
        rect(posX, posY, 5, 15);
      }
    }
    
    public void Kill() {
      dead = true;
    }
    
    public boolean isDown() {
      return dead;
    }
    
    public float getX() {
      return posX;
    }
    public float getY() {
      return posY;
    }
  }
  
  public Shield(float inX, float inY) {
    posX = inX;
    posY = inY;
    makeShield();
  }
  
  private void makeShield() {
    float xTrack = posX-50;
    float xTrackChange = 5;
    
    for(int i = 0; i < 10; i++) {
      shieldArr[i] = new ShieldPiece(xTrack, 850);
      xTrack+=xTrackChange;
    }
    for(int i = 10; i < 20; i++) {
      xTrack-=xTrackChange;
      shieldArr[i] = new ShieldPiece(xTrack, 860);
    }
    for(int i = 20; i < 30; i++) {
      xTrack+=xTrackChange;
      shieldArr[i] = new ShieldPiece(xTrack, 870);
    }
    for(int i = 30; i < 40; i++) {
      xTrack-=xTrackChange;
      shieldArr[i] = new ShieldPiece(xTrack, 880);
    }
    for(int i = 40; i < 50; i++) {
      xTrack+=xTrackChange;
      shieldArr[i] = new ShieldPiece(xTrack, 890);
    }
    for(int i = 42; i < 48; i++) {
      shieldArr[i].Kill();
    }
  }
  
  public void Destroy(float inX, float inY) {
    for(int i = 0; i < shieldArr.length; i++) {
      if(inY > shieldArr[i].getY()-5 && inY < shieldArr[i].getY()+5) {
        if(inX > shieldArr[i].getX()-5 && inX < shieldArr[i].getX()+5) {
          shieldArr[i].Kill();
        }
      }
    }
  }
  
  public float getX(int i) {
    return shieldArr[i].getX();
  }
  
  public float getY(int i) {
    return shieldArr[i].getY();
  }
  
  public boolean isDown(float inX, float inY) {
    for(int i = 0; i < shieldArr.length; i++) {
      if(inY > shieldArr[i].getY()-5 && inY < shieldArr[i].getY()+5) {
        if(inX > shieldArr[i].getX()-5 && inX < shieldArr[i].getX()+5) {
          return shieldArr[i].isDown();
        }
      }
    }
    return false;
  }
  
  public void show() {
    for(int i = 0; i < shieldArr.length; i++) {
      shieldArr[i].show();
    }
  }
  
  public ShieldPiece[] getShieldArr() {
    return shieldArr;
  }
}