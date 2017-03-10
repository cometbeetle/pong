import processing.sound.*; //Use sound library
SoundFile beepSound;
SoundFile frewSound;
SoundFile easySound;
SoundFile mediumSound;
SoundFile hardSound;
SoundFile youWin;

float difficulty = 1.7;
int pscore = 0, cscore = 0;
int size = 60;
float x = 90;
float xspeed = 15;
float yspeed = 3;
float y = 0;
float compy = 0;
boolean started = false;

void setup() {
  size(900, 700);
  smooth();
  frameRate(60);
  rectMode(CENTER);
  beepSound = new SoundFile(this, "beep.mp3"); //sound Files
  frewSound = new SoundFile(this, "frew.mp3");
  easySound = new SoundFile(this, "easy.mp3");
  mediumSound = new SoundFile(this, "medium.mp3");
  hardSound = new SoundFile(this, "hard.mp3");
  youWin = new SoundFile(this, "youWin.wav");
}

void draw() {
  background(80);
  if (started == false) {
    drawMenu();
  } else {
    if (compy < y) {
      compy = compy + difficulty;
    } else if (compy > y) {
      compy = compy -difficulty;
    }
    fill(255, 255, 0);
    rect(30, compy, 20, 100); // comp paddle
    rect(870, mouseY, 20, 100); //user paddle
    x += xspeed; //increase the value of x
    y += yspeed; //increase the value of y
    ellipse(x, y, size, size);
    if (x+size/2 > 860 && mouseY > y - size/2 -40 && mouseY < y + size/2+40) { // BALL HITS USER PADDLE
      xspeed *= -1;
      pscore++;
      beepSound.play();
    } else  if (x - size/2 < 40 && compy > y -size/2 -40 && compy < y + size/2+40) { // BALL HITS COMPUTER PADDLE
      xspeed *= -1;
      cscore++;
      beepSound.play();
    }
    if (x > width+size/2) {
      xspeed *= -1;
      cscore++;
      x=width/2;
      compy=y;
    } else if (x < -size/2) {
      xspeed *= -1;
      pscore++;
      x=width/2;
      compy=y;
    } 
    if (pscore > 50) {
      started = false;
      pscore = 0;
      cscore = 0;
      youWin.play();
    }
    if (y > height || y < 0 ) yspeed *= -1;
    fill(255, 0, 0);
    text(cscore, 200, 100);
    text(pscore, 600, 100);
  }
}

void mousePressed() {
  if (mouseX > 326 && mouseX < 575 && mouseY > 153 && mouseY < 251 ) {
    started=true;
    xspeed = 10;
    yspeed = 2;
    easySound.play();
  } else if (mouseX > 276 && mouseX < 625 && mouseY > 304 && mouseY < 402 ) {
    started=true;
    xspeed = 14;
    yspeed = 4;
    mediumSound.play();
    difficulty = 3.5;
  } else if (mouseX > 316 && mouseX < 584 && mouseY > 454 && mouseY < 552 ) {
    started=true;
    xspeed = 17;
    yspeed = 7;
    hardSound.play();
  }
}



void drawMenu() {
  PFont font=loadFont("pong.vlw");
  textFont(font, 100);
  fill(255, 0, 0);
  rect(450, 350, 500, 500);
  fill(255);
  rect(450, 200, 250, 100);
  fill(255, 0, 0);
  text("Easy", 340, 230);
  fill(255);
  rect(450, 350, 350, 100);
  fill(255, 0, 0);
  text("Medium", 280, 375);
  fill(255);
  rect(450, 500, 270, 100);
  fill(255, 0, 0);
  text("Hard", 320, 530);
}