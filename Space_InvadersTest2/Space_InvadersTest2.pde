/**** BUGS ****
Invader bullet turn white once all lives are lost
**** BUGS ****/


import java.util.*;
import java.lang.management.ManagementFactory;
import java.lang.management.OperatingSystemMXBean;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;

Ship player = new Ship(500, 980); // Initialises ship at bottom centre of screen
Shield shield1 = new Shield(250, 100);
Shield shield2 = new Shield(500, 100);
Shield shield3 = new Shield(750, 100);

Invader[] invaders1 = new Invader[11];
Invader[] invaders2 = new Invader[11];
Invader[] invaders3 = new Invader[11];
Invader[] invaders4 = new Invader[11];
Invader[] invaders5 = new Invader[11]; // 5 arrays of invaders for seperate movement

//Bullet[] invBullets = new Bullet[50]; // Bullet limit of 50
//Bullet[] playerBullets = new Bullet[50]; // Bullet limit of 50
// Using arrays for bullets for easier collision checks (for loops) // Not anymore

Bullet playerBullet;

//int invBulletCount; // Keep count of invader bullets
//int playerBulletCount; // Keep count of player bullets
// Obsolete

int curInv; // Tracks invader array to be moved on x axis

boolean downFlag; // Tracks whether invaders have reached a side of the screen, causing them to be moved down if so
boolean downDone; // For finishing the down movement
boolean rightFlag;
//boolean bulletDelay; // Obsolete

boolean aPressed;
boolean dPressed;
boolean sPressed;

boolean playerBulletDead;
boolean playerBulletExists; // Keeps track of the existance of a player bullet

int posCountX; // For spacing of invaders
int collisionConstX;
int collisionConstY;
int shieldConst;

int playerLives;
int invaderCount;
int frameCountCheck;
int bulletDelayCount;
boolean bulletDelayed;

boolean paused; // "Menu" items
boolean showData;

int score; // GUI items

boolean gameOver;

final static String ICON  = "iconSI.png";
final static String TITLE = "Utku's Space Invaders";

PImage inv11 = createImage(30, 30,RGB);
PImage inv12 = createImage(30, 30,RGB);
PImage inv2 = createImage(30, 30,RGB);

boolean animationFrame = true;

//int bulletDelayCount; // Obsolete

void setup() {
  size(1000,1000);
  background(10);
  frameRate(120);
  
  posCountX = 80;
  collisionConstX = 20;
  collisionConstY = 5;
  shieldConst = 50;
  frameCountCheck = 11;
  
  playerLives = 3;
  invaderCount = 55;
  bulletDelayCount = 0;
  
  score = 0;
  
  SetupInvs();
  
  curInv = 1;
  downFlag = false;
  rightFlag = true;
  
  changeAppIcon( loadImage(ICON) );
  changeAppTitle(TITLE);
  
  inv11 = loadImage("inv1-1.jpg");
  inv12 = loadImage("inv1-2.jpg");
  inv2 = loadImage("inv2.jpg");
  
}

void draw() {
  background(10);
  
  if(showData) {
    fill(255);
    textSize(12); 
    text(frameRate, 10, 10); 
  }
  
  ShowScore();
  ShowLives();
  
  if(true) {
    if(frameCount%frameCountCheck==0) { // Invaders frameCountCheck frames. This decreases as they are killed
      MoveInvs();
    }
  }
    
  if(bulletDelayed) {
    bulletDelayCount++;
  }
  
  if(bulletDelayCount == 100) {
    bulletDelayed = false;
    bulletDelayCount = 0;
  }
  
  ShowInvaders();
  ShowShields();
  
  if(!bulletDelayed)
    ShowPlayerBullet();
    
  InputControl();
  player.show();
  
  if(invaderCount == 0)
    GameOver();
    
  //println(frameRate);
}

void ShowInvaders() {
  Random rand = new Random();
  int randShot = rand.nextInt(40)+1;
  int randInvArr = rand.nextInt(5)+1;
  for(int i = 0; i < invaders1.length; i++) {
    if(invaders1[i].show(player.getX(), player.getY()) == 1) {
      LifeLost();
    }     
    if(invaders2[i].show(player.getX(), player.getY()) == 1) {
      LifeLost();
    }
    if(invaders3[i].show(player.getX(), player.getY()) == 1) {
      LifeLost();
    }
    if(invaders4[i].show(player.getX(), player.getY()) == 1) {
      LifeLost();
    }
    if(invaders5[i].show(player.getX(), player.getY()) == 1) {
      LifeLost();
    }
  }
  if(randShot == 30) {
    if(randInvArr == 1) {
      int randInv = rand.nextInt(11);
      invaders1[randInv].Shoot();
    }
    if(randInvArr == 2) {
      int randInv = rand.nextInt(11);
      invaders2[randInv].Shoot();
    }
    if(randInvArr == 3) {
      int randInv = rand.nextInt(11);
      invaders3[randInv].Shoot();
    }
    if(randInvArr == 4) {
      int randInv = rand.nextInt(11);
      invaders4[randInv].Shoot();
    }
    if(randInvArr == 5) {
      int randInv = rand.nextInt(11);
      invaders5[randInv].Shoot();
    }
  }
}

void ShowShields() {
  shield1.show();
  shield2.show();
  shield3.show();
  for(int i = 0; i < shieldConst; i++) {
    float x1 = shield1.getX(i);
    float y1 = shield1.getY(i);
    float x2 = shield2.getX(i);
    float y2 = shield2.getY(i);
    float x3 = shield3.getX(i);
    float y3 = shield3.getY(i);
    for(int j = 0; j < invaders1.length; j++) {
      if(!shield1.isDown(x1, y1)) {
        if(invaders1[j].collisionCheckShield(x1, y1) == 1) {
          shield1.Destroy(x1, y1);
        }
          
        if(invaders2[j].collisionCheckShield(x1, y1) == 1) {
          shield1.Destroy(x1, y1);
        }
          
        if(invaders3[j].collisionCheckShield(x1, y1) == 1) {
          shield1.Destroy(x1, y1);
        }
          
        if(invaders4[j].collisionCheckShield(x1, y1) == 1) {
          shield1.Destroy(x1, y1);
        }
          
        if(invaders5[j].collisionCheckShield(x1, y1) == 1) {
          shield1.Destroy(x1, y1);
        }
      }
    }
    for(int j = 0; j < invaders1.length; j++) {
      if(!shield2.isDown(x2, y2)) {
        if(invaders1[j].collisionCheckShield(x2, y2) == 1) {
          shield2.Destroy(x2, y2);
        }
          
        if(invaders2[j].collisionCheckShield(x2, y2) == 1) {
          shield2.Destroy(x2, y2);
        }
          
        if(invaders3[j].collisionCheckShield(x2, y2) == 1) {
          shield2.Destroy(x2, y2);
        }
          
        if(invaders4[j].collisionCheckShield(x2, y2) == 1) {
          shield2.Destroy(x2, y2);
        }
          
        if(invaders5[j].collisionCheckShield(x2, y2) == 1) {
          shield2.Destroy(x2, y2);
        }
      }
    }
    for(int j = 0; j < invaders1.length; j++) {
      if(!shield3.isDown(x3, y3)) {
        if(invaders1[j].collisionCheckShield(x3, y3) == 1) {
          shield3.Destroy(x3, y3);
        }
          
        if(invaders2[j].collisionCheckShield(x3, y3) == 1) {
          shield3.Destroy(x3, y3);
        }
          
        if(invaders3[j].collisionCheckShield(x3, y3) == 1) {
          shield3.Destroy(x3, y3);
        }
          
        if(invaders4[j].collisionCheckShield(x3, y3) == 1) {
          shield3.Destroy(x3, y3);
        }
          
        if(invaders5[j].collisionCheckShield(x3, y3) == 1) {
          shield3.Destroy(x3, y3);
        }
      }
    }
  }

}

//void ShowBullets() {
//  for(int i = 0; i < playerBullets.length; i++) {
//    if(playerBullets[i] != null) {
//      playerBullets[i].show();
//      playerBullets[i].moveUp();
//    }
//  }  
//  for(int i = 0; i < playerBullets.length; i++) {
//    if(playerBullets[i] != null) {
//      if(playerBullets[i].getY() < 50) {
//        println("A bullet is high " + i + " y pos: " + playerBullets[i].getY());
//        playerBullets[i] = null;
//        playerBulletCount--;
//      }
//    }
//  }  
//}

void ShowPlayerBullet() {
  if(playerBulletExists) {
    playerBullet.show();
    playerBullet.moveUp();
    if(playerBullet!=null)
      checkCollisions();
  }  
}

void InputControl() { // Handles movement of player and ensures there is a delay between bullet shots
  if(aPressed && player.getX() >= 4) {
    player.move(-4); 
  }
  
  if(dPressed && player.getX() < width-31) {
    player.move(4);
  }
  
  //if(sPressed && bulletDelay == false) {
  //  println("Bullet " + playerBulletCount + " fired");
  //  playerBullets[playerBulletCount] = new Bullet(player.getX(), player.getY(), 5);
  //  playerBulletCount++;
  //  bulletDelay = true;
  //}
  
  if(sPressed && !playerBulletExists && !playerBulletDead && !bulletDelayed) {
    playerBullet = new Bullet(player.getX()+12, player.getY(), 8);
    playerBulletExists = true;
  }
}

void keyPressed(KeyEvent e) {
  if (key == CODED) {
    switch(keyCode) {
      case LEFT: aPressed = true;
      break;
      case RIGHT: dPressed = true;
      break;
      case 113: showData = !showData;
      break;
    }
  }
  else {
    switch(key) {
      case 'a': aPressed = true;
      break;
      case 'd': dPressed = true;
      break;
      case ' ': sPressed = true;
      break;
      case 'p' : if(paused){paused=false;loop();} else{paused=true;noLoop();} 
      break;
      case 'r' : GameOver();
    }
  }
}

void keyReleased(KeyEvent e) {
  if (key == CODED) {
    if (keyCode == LEFT) {
      aPressed = false;
    }
    else if (keyCode == RIGHT) {
      dPressed = false;
    }
  }
  else {
    if(key == 'a') {
      aPressed = false;
    }
    else if(key == 'd') {
      dPressed = false;
    }
    else if (key == ' ') {
      sPressed = false;
    }
  }
}

void checkCollisions() {
    boolean isShield = false;
    if(playerBullet.getY() > invaders1[0].getPosY()-collisionConstY && playerBullet.getY() < invaders1[0].getPosY()+collisionConstY) {
      println("bullet at 1s");
      for(int i = 0; i < invaders1.length; i++) {
        if(playerBullet != null) {
          if(playerBullet.getX() > invaders1[i].getPosX()-collisionConstX && playerBullet.getX() < invaders1[i].getPosX()+collisionConstX) {
            if(!invaders1[i].isDead()) {
              invaders1[i].Kill();
              playerBulletDead = true;
            }
          }
        }
      }
    }
    if(playerBullet != null) {
      if(playerBullet.getY() > invaders2[0].getPosY()-collisionConstY && playerBullet.getY() < invaders2[0].getPosY()+collisionConstY) {
        println("bullet at 2s");
        for(int i = 0; i < invaders1.length; i++) {
          if(playerBullet != null) {
            if(playerBullet.getX() > invaders2[i].getPosX()-collisionConstX && playerBullet.getX() < invaders2[i].getPosX()+collisionConstX) {
              if(!invaders2[i].isDead()) {
                invaders2[i].Kill();
                playerBulletDead = true;
              }
            }
          }
        }
      }
    }
    if(playerBullet != null) {
      if(playerBullet.getY() > invaders3[0].getPosY()-collisionConstY && playerBullet.getY() < invaders3[0].getPosY()+collisionConstY) {
        println("bullet at 3s");
        for(int i = 0; i < invaders1.length; i++) {
          if(playerBullet != null) {
            if(playerBullet.getX() > invaders3[i].getPosX()-collisionConstX && playerBullet.getX() < invaders3[i].getPosX()+collisionConstX) {
              if(!invaders3[i].isDead()) {
                invaders3[i].Kill();
                playerBulletDead = true;
              }
            }
          }
        }
      }
    }
    if(playerBullet != null) {
      if(playerBullet.getY() > invaders4[0].getPosY()-collisionConstY && playerBullet.getY() < invaders4[0].getPosY()+collisionConstY) {
        println("bullet at 4s");
        for(int i = 0; i < invaders1.length; i++) {
          if(playerBullet != null) {
            if(playerBullet.getX() > invaders4[i].getPosX()-collisionConstX && playerBullet.getX() < invaders4[i].getPosX()+collisionConstX) {
              if(!invaders4[i].isDead()) {
                invaders4[i].Kill();
                playerBulletDead = true;
              }
            }
          }
        }
      }
    }
    if(playerBullet != null) {
      if(playerBullet.getY() > invaders5[0].getPosY()-collisionConstY && playerBullet.getY() < invaders5[0].getPosY()+collisionConstY) {
        println("bullet at 5s");
        for(int i = 0; i < invaders1.length; i++) {
          if(playerBullet != null) {
            if(playerBullet.getX() > invaders5[i].getPosX()-collisionConstX && playerBullet.getX() < invaders5[i].getPosX()+collisionConstX) {
              if(!invaders5[i].isDead()) {
                invaders5[i].Kill();
                playerBulletDead = true;
              }
            }
          }
        }
      }
    }
    int shieldWidthConst = 10;
    int shieldHeightConst = 5;
    for(int i = 0; i < shieldConst; i++) {
      float x1 = shield1.getX(i);
      float y1 = shield1.getY(i);
      float x2 = shield2.getX(i);
      float y2 = shield2.getY(i);
      float x3 = shield3.getX(i);
      float y3 = shield3.getY(i);
      float playerBulletX = playerBullet.getX();
      float playerBulletY = playerBullet.getY();
      if(playerBullet != null && !shield1.isDown(x1, y1)) {
        if(y1 > playerBulletY-shieldHeightConst && y1 < playerBulletY+shieldHeightConst) {
          if(x1 > playerBulletX-shieldWidthConst && x1 < playerBulletX+shieldWidthConst) {
            shield1.Destroy(x1, y1);
            playerBulletDead = true;
            isShield = true;
          }
        }
      }
      if(playerBullet != null && !shield2.isDown(x2, y2)) {
        if(y2 > playerBulletY-shieldHeightConst && y2 < playerBulletY+shieldHeightConst) {
          if(x2 > playerBulletX-shieldWidthConst && x2 < playerBulletX+shieldWidthConst) {
            shield2.Destroy(x2, y2);
            playerBulletDead = true;
            isShield = true;  
          }
        }
      }
      if(playerBullet != null && !shield3.isDown(x3, y3)) {
        if(y3 > playerBulletY-shieldHeightConst && y3 < playerBulletY+shieldHeightConst) {
          if(x3 > playerBulletX-shieldWidthConst && x3 < playerBulletX+shieldWidthConst) {
            shield3.Destroy(x3, y3);
            playerBulletDead = true;
            isShield = true;            
          }
        }    
      }
      if(playerBulletDead) {
        println("Broke out");
        break;
      }
    }
    if(playerBullet != null) {
      if(playerBullet.getY() < 50) {
        playerBullet = null;
        playerBulletExists = false;
      }
    }
    if(playerBulletDead == true) {
      playerBullet = null;
      playerBulletExists = false;
      playerBulletDead = false;
      
      if(isShield) {
        bulletDelayed = true;
        score-=10; 
      }
        
      if(!isShield)
        InvaderKilled();
    }
}

void InvaderKilled() {
  invaderCount--;
  if(invaderCount%5 == 0 && frameCountCheck != 1) 
    frameCountCheck--;
  
  if(invaderCount == 1)
    frameCountCheck = 1;
  
  score+=100;
}

void InvMove1() {
  if(downFlag == false) {
    for(int i = 0; i < invaders1.length; i++){
      invaders1[i].SwitchImg();
      if(rightFlag == true) {
        invaders1[i].moveRight();
      }
      if(rightFlag == false) {
        invaders1[i].moveLeft();
      }
    }
    
  }
  curInv++;
}

void InvMove2() {
  if(downFlag == false) {
    for(int i = 0; i < invaders2.length; i++){
      invaders2[i].SwitchImg();
      if(rightFlag == true) {
        invaders2[i].moveRight();
      }
      if(rightFlag == false) {
        invaders2[i].moveLeft();
      }
    }
  }
  curInv++;
}

void InvMove3() {
  if(downFlag == false) {
    for(int i = 0; i < invaders3.length; i++){
      invaders3[i].SwitchImg();
      if(rightFlag == true) {
        invaders3[i].moveRight();
      }
      if(rightFlag == false) {
        invaders3[i].moveLeft();
      }
    }
  }
  curInv++;
}

void InvMove4() {
  if(downFlag == false) {
    for(int i = 0; i < invaders4.length; i++){
      invaders4[i].SwitchImg();
      if(rightFlag == true) {
        invaders4[i].moveRight();
      }
      if(rightFlag == false) {
        invaders4[i].moveLeft();
      }
    }
  }
  curInv++;
}

void InvMove5() {
  if(downFlag == false) { // Move on x-axis if not yet at edge of screen
    for(int i = 0; i < invaders5.length; i++){
      invaders5[i].SwitchImg();
      if(rightFlag == true) {
        invaders5[i].moveRight();
      }
      if(rightFlag == false) {
        invaders5[i].moveLeft();
      }
    }
  }
  if(rightFlag == true) {
    for(int i = 0; i < invaders1.length; i++){
      if(invaders1[i].getPosX() == 960 && invaders1[i].isDead() == false && downDone == false) { // Moves down once when invaders reach edge
        downFlag = true; // Will be set to false after movement down
        rightFlag = false;
      }  
      if(invaders2[i].getPosX() == 960 && invaders2[i].isDead() == false && downDone == false) { // Moves down once when invaders reach edge
        downFlag = true; // Will be set to false after movement down
        rightFlag = false;
      }  
      if(invaders3[i].getPosX() == 960 && invaders3[i].isDead() == false && downDone == false) { // Moves down once when invaders reach edge
        downFlag = true; // Will be set to false after movement down
        rightFlag = false;
      }  
      if(invaders4[i].getPosX() == 960 && invaders4[i].isDead() == false && downDone == false) { // Moves down once when invaders reach edge
        downFlag = true; // Will be set to false after movement down
        rightFlag = false;
      }  
      if(invaders5[i].getPosX() == 960 && invaders5[i].isDead() == false && downDone == false) { // Moves down once when invaders reach edge
        downFlag = true; // Will be set to false after movement down
        rightFlag = false;
      }  
    }
  }
  if(rightFlag == false) {
    for(int i = 0; i < invaders1.length; i++){
      if(invaders1[i].getPosX() == 40 && invaders1[i].isDead() == false && downDone == false) {
        downFlag = true;
        rightFlag = true;
      }
      if(invaders2[i].getPosX() == 40 && invaders2[i].isDead() == false && downDone == false) {
        downFlag = true;
        rightFlag = true;
      }     
      if(invaders3[i].getPosX() == 40 && invaders3[i].isDead() == false && downDone == false) {
        downFlag = true;
        rightFlag = true;
      }     
      if(invaders4[i].getPosX() == 40 && invaders4[i].isDead() == false && downDone == false) {
        downFlag = true;
        rightFlag = true;
      }     
      if(invaders5[i].getPosX() == 40 && invaders5[i].isDead() == false && downDone == false) {
        downFlag = true;
        rightFlag = true;
      }     
    }
  }
  downDone = false;
  curInv = 1;
}

void InvMove1Down() {
  for(int i = 0; i < invaders1.length; i++) {
    invaders1[i].incPosY();
  }  
  downFlag = false; // Down movement has occured
  downDone = true; // 1st array moved down last, checks off the down movement of invaders
}

void InvMove2Down() {
  for(int i = 0; i < invaders2.length; i++) {
    invaders2[i].incPosY();
  }  
}

void InvMove3Down() {
  for(int i = 0; i < invaders3.length; i++) {
    invaders3[i].incPosY();
  }  
}

void InvMove4Down() {
  for(int i = 0; i < invaders4.length; i++) {
    invaders4[i].incPosY();
  }  
}

void InvMove5Down() {
  for(int i = 0; i < invaders5.length; i++) {
    invaders5[i].incPosY();
  }  
}

void SetupInvs() {
  for(int i = 0; i < invaders1.length; i++) {
    invaders1[i] = new Invader(posCountX, 80, 1);
    invaders2[i] = new Invader(posCountX, 120, 2);
    invaders3[i] = new Invader(posCountX, 160, 3);
    invaders4[i] = new Invader(posCountX, 200, 4);
    invaders5[i] = new Invader(posCountX, 240, 5);
    posCountX+=80;
  }
  for(int i = 0; i < invaders1.length; i++) {
    invaders1[i].show();
    invaders2[i].show();
    invaders3[i].show();
    invaders4[i].show();
    invaders5[i].show();
  }
}

void MoveInvs() {
  if(downFlag == true) {
    InvMove2Down();
    InvMove3Down();
    InvMove4Down();
    InvMove5Down();
    InvMove1Down();
  }
  else {
    switch(curInv) {
      case 1: InvMove1();
      break;
      case 2: InvMove2();
      break;
      case 3: InvMove3();
      break;
      case 4: InvMove4();
      break;
      case 5: InvMove5();
      break;
    }
  }
}

void GameOver() {
  for(int i = 0; i < invaders1.length; i++) {
    invaders1[i].Revive();
  }

  for(int i = 0; i < invaders2.length; i++) {
    invaders2[i].Revive();
  }  

  for(int i = 0; i < invaders3.length; i++) {
    invaders3[i].Revive();
  }  

  for(int i = 0; i < invaders4.length; i++) {
    invaders4[i].Revive();
  }  

  for(int i = 0; i < invaders5.length; i++) {
    invaders5[i].Revive();
  }  
  
  frameCountCheck = 11;
  delay(1500);
}

void LifeLost() {
  if(playerLives == 0) {
    fill(255);
    text("Game Over", 440, 500);
    playerLives = 3;
    score = 0;
    delay(1500);
    GameOver();
  }
  else {
    playerLives--;
    score-=500;
    ResetBullets();
  }
  delay(1500);
}

void ResetBullets() {
  for(int i = 0; i < invaders1.length; i++) {
    invaders1[i].bullReset();
  }

  for(int i = 0; i < invaders2.length; i++) {
    invaders2[i].bullReset();
  }  

  for(int i = 0; i < invaders3.length; i++) {
    invaders3[i].bullReset();
  }  

  for(int i = 0; i < invaders4.length; i++) {
    invaders4[i].bullReset();
  }  

  for(int i = 0; i < invaders5.length; i++) {
    invaders5[i].bullReset();
  }    
}

void ShowScore() {
  fill(255);
  textSize(18); 
  text("<SCORE>", 463, 20);   
  text(score, 500, 40);   
  
  text("UtkuKorp", 800, 20); 
}

void ShowLives() {
  int lifePosX = 100;
  int lifePosY = 20;
  for(int i = 0; i < playerLives; i++) {
    fill(50, 250, 50);
    rect(lifePosX, lifePosY, 31, 10);
    rect(lifePosX+12, lifePosY-8, 8, 8);  
    lifePosX+=50;
  }
}

void changeAppIcon(PImage img) {
  final PGraphics pg = createGraphics(16, 16, JAVA2D);

  pg.beginDraw();
  pg.image(img, 0, 0, 16, 16);
  pg.endDraw();

  frame.setIconImage(pg.image);
}

void changeAppTitle(String title) {
  surface.setTitle(title);
}

void printUsage() {
  OperatingSystemMXBean operatingSystemMXBean = ManagementFactory.getOperatingSystemMXBean();
  for (Method method : operatingSystemMXBean.getClass().getDeclaredMethods()) {
    method.setAccessible(true);
    if (method.getName().startsWith("getProcessCpuLoad") 
        && Modifier.isPublic(method.getModifiers())) {
            Object value;
        try {
            value = method.invoke(operatingSystemMXBean);
        } catch (Exception e) {
            value = e;
        } // try
        System.out.println(method.getName() + " = " + value);
        fill(255);
        textSize(12); 
        text(method.getName()+value, 100, 10); 
    } // if
  } // for
}