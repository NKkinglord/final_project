private PVector player1Pos = new PVector(80, 135);
private boolean animation1 = true;
private boolean animation2 = false;

private boolean animation3 = true;
private boolean animation4 = false;
private PVector player2Pos = new PVector(250, 135);

private boolean left1 = false;
private boolean right1 = false;
private boolean left2 = false;
private boolean right2 = false;

private boolean swing1 = false;
private boolean swing2 = false;
private boolean doneSwing = false;
private boolean doneSwing2 = false;
private PVector player1Velocity = new PVector(0, 0);
private PVector player2Velocity= new PVector(0, 0);
private PVector jumpV= new PVector(0, -7);

private int lastStateChangeTime = 0; // Time of the last state change
private int stateChangeInterval = 90; // Interval between state changes in milliseconds
private int time = 0;

private boolean onceRight=true;
private boolean onceLeft=true;
public float a =1.5;
public float b =1;
public float c =1.5;
public float d =1;
Racket racketLeft;
Racket racketRight;
Birdie birdie;

PVector armPos1 = new PVector(player1Pos.x, player1Pos.y + 25);
PVector armPos2 = new PVector(player2Pos.x, player2Pos.y + 25);

public void setup() {
  size(1400, 900);
  racketLeft = new Racket(armPos1, true);
  racketRight = new Racket(armPos2, false);
  birdie = new Birdie(player1Pos);
}

public void scorebox() {
  textSize(100);
  text(birdie.getLeftScore(), 700 - 100, 100);
  text(birdie.getRightScore(), 700 + 50, 100);
}

void reset() {
  background(220);
  racketLeft = new Racket(armPos1, true);
  racketRight = new Racket(armPos2, false);
  birdie = new Birdie(player1Pos);
  loop();
}

public void fieldmake() {
  fill(#E1B200);
  rect(0, 800, 1400, 900);
  fill(#FFFFFF);
  rect(695, 625, 10, 300);
}

public void draw() {
  background(#E1B387);
  fieldmake();
  gravity();
  walkanimations();



  birdie.updateBirdie();
  birdie.makeBirdie();

  player1make(player1Pos);
  player2make(player2Pos);



  armPos1 = new PVector(player1Pos.x + 13, player1Pos.y + 13);
  armPos2 = new PVector(player2Pos.x - 16, player2Pos.y + 11);

  racketLeft.makeRacket(armPos1);
  racketRight.makeRacket(armPos2);

  if (birdie.birdiePos.x > width/2) {
    birdie.hit = birdie.hitbox(racketRight);
  } else {
    birdie.hit = birdie.hitbox(racketLeft);
  }

  scorebox();
}

public void walkanimations() {
  if (time == 20) {
    if (animation3) {
      animation3 = false;
      animation4 = true;
    } else if (animation4) {
      animation4 = false;
      animation3 = true;
    }
    if (animation1) {
      animation1 = false;
      animation2 = true;
    } else if (animation2) {
      animation1 = true;
      animation2 = false;
    }
    time = 0;
  }
  if (player1Pos.x % 2 == 0) time++;
}


public void player1make(PVector pos) {
  fill(#ffffff);
  pushMatrix(); // Save the current transformation matrix
  scale(4); // Apply the scale locally
  circle(pos.x, pos.y + 10, 10); // head
  line(pos.x, pos.y + 15, pos.x, pos.y + 40); // body
  line(pos.x, pos.y + 25, pos.x + 10, pos.y + 47); // arm2
  if (animation1) walk11(pos);
  else if (animation2) walk12(pos);
  popMatrix(); // Restore the previous transformation matrix
}
public void player2make(PVector pos) {
  fill(#ffffff);
  pushMatrix();
  scale(4);
  circle(pos.x, pos.y + 10, 10); // head
  line(pos.x, pos.y + 15, pos.x, pos.y + 40); // body
  line(pos.x, pos.y + 25, pos.x - 10, pos.y + 47); // arm2
  if (animation3) walk21(pos);
  else if (animation4) walk22(pos);
  popMatrix();
}
public void walk21(PVector pos) {
  line(pos.x, 40 + pos.y, pos.x + 10, 65 + pos.y);
  line(pos.x, 40 + pos.y, pos.x - 10, 65 + pos.y);
}

public void walk22(PVector pos) {
  line(pos.x, 40 + pos.y, pos.x - 5, 45 + pos.y);
  line(pos.x - 5, 45 + pos.y, pos.x - 3, 65 + pos.y);
  line(pos.x, 40 + pos.y, pos.x - 1, 50 + pos.y);
  line(pos.x - 1, 50 + pos.y, pos.x + 5, 65 + pos.y);
}


public void walk11(PVector pos) {
  line(pos.x, 40 + pos.y, pos.x + 10, 65 + pos.y);
  line(pos.x, 40 + pos.y, pos.x - 10, 65 + pos.y);
}

public void walk12(PVector pos) {
  line(pos.x, 40 + pos.y, pos.x + 5, 45 + pos.y);
  line(pos.x + 5, 45 + pos.y, pos.x + 3, 65 + pos.y);
  line(pos.x, 40 + pos.y, pos.x + 1, 50 + pos.y);
  line(pos.x + 1, 50 + pos.y, pos.x - 5, 65 + pos.y);
}

public void gravity() {

  PVector gravity = new PVector(0, 0.1);
  if (player1Pos.y < 133 || player1Velocity.y < 0) {
    player1Velocity.add(gravity);
    player1Pos.add(player1Velocity);
  } else {
    player1Velocity.y = 3;
  }
  if (player2Pos.y < 133 || player2Velocity.y < 0) {
    player2Velocity.add(gravity);
    player2Pos.add(player2Velocity);
  } else {
    player2Velocity.y = 3;
  }



  if (left1 && player1Pos.x > 0) player1Pos.x--;
  if (right1 && player1Pos.x  < 164 ) player1Pos.x++;
  if (right2 && player2Pos.x < 350) player2Pos.x++;
  if (left2 && player2Pos.x > 186) player2Pos.x--;

  if (swing2) {
    a -=0.05;
    b +=0.06;

    pushMatrix();
    if (racketLeft.leftRotation <330 && !doneSwing2) {
      rotate(radians(racketLeft.leftRotation));
      racketLeft.leftRotation +=5;
      if (millis() - lastStateChangeTime >= stateChangeInterval ) {
        racketLeft.racketState++;
        lastStateChangeTime = millis();
      }
      if (birdie.hit) {
        System.out.println(racketLeft.racketState);
        birdie.startRound = false;
        birdie.leftSwings();
      }
    } else if (racketLeft.leftRotation <=340 && racketLeft.leftRotation >= 220 ) {
      a= 1.5;
      b= 1;
      doneSwing2 = true;
      racketLeft.racketState = -1;
      rotate(radians(racketLeft.leftRotation));
      racketLeft.leftRotation -=5;
      if (racketLeft.leftRotation <= 220) {
        doneSwing2 = false;
        swing2 = false;
        onceLeft = true;
      }
    }
    popMatrix();
  }


  if (swing1) {
    c -=0.05;
    d +=0.06;

    pushMatrix();
    if (racketRight.rightRotation >=210 && !doneSwing) {
      rotate(radians(racketRight.rightRotation));
      racketRight.rightRotation -=5;
      if (millis() - lastStateChangeTime >= stateChangeInterval ) {
        racketRight.racketState++;
        lastStateChangeTime = millis();
      }
      if (birdie.hit) {

        birdie.startRound = false;
        birdie.rightSwings();
      }
    } else if (racketRight.rightRotation <=330 && racketRight.rightRotation >= 200 ) {
      c= 1.5;
      d= 1;
      doneSwing = true;
      racketRight.racketState = -1;
      rotate(radians(racketRight.rightRotation));
      racketRight.rightRotation +=5;
      if (racketRight.rightRotation >= 330) {
        doneSwing = false;
        swing1 = false;
        onceRight = true;
      }
    }
    popMatrix();
  }
}



public void keyPressed() {

  if (keyCode == 65) left1 = true;
  if (keyCode == 68) right1 = true;
  if (keyCode == 87 && player1Pos.y > 134) player1Velocity.add(jumpV);
  if (keyCode == 83 ) {
    swing2 = true;
    racketLeft.racketState = -1;
  }
  if (keyCode == DOWN ) {
    swing1 = true;
    racketRight.racketState = -1;
  }
  if (keyCode == LEFT) left2 = true;
  if (keyCode == RIGHT) right2 = true;
  if (keyCode == UP && player2Pos.y > 134) player2Velocity.add(jumpV);
  if (key == 'r') reset();
}


public void keyReleased() {
  if (keyCode == 65) left1 = false;
  if (keyCode == 68) right1 = false;
  if (keyCode == LEFT) left2 = false;
  if (keyCode == RIGHT) right2 = false;
}
