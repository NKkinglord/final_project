
public class Birdie {
  private PVector birdiePos;
  private int size = 35;
  private float birdieRotation;
  private PVector birdieVelocity;
  private boolean hit;
  private int leftScore;
  private int rightScore;
  private boolean startRound;
  public Birdie(PVector playerPos) {
    birdiePos = new PVector(playerPos.x*4, playerPos.y*4-70);
    birdieRotation = PI;
    birdieVelocity = new PVector(0, 0);
    hit = true;
    leftScore = 0;
    rightScore = 0;
    startRound = true;
  }
  
  
  public int getLeftScore(){
    return leftScore;
  }
  
  public int getRightScore(){
    return rightScore;
  }
  
  public boolean hitbox(Racket racket) {
    if (racket.leftSide) {
      float x = racket.racketPos.x  + racket.size * cos(radians(racket.leftRotation))*2;
      float y = racket.racketPos.y-30 + racket.size * sin(radians(racket.leftRotation))*2;
      if (rectRect(birdiePos.x-20, birdiePos.y-10, size, size, x, y, racket.size, racket.size)) {
        return true;
      } else return false;
    } else {
      float x = racket.racketPos.x  + racket.size * cos(radians(racket.rightRotation))*2;
      float y = racket.racketPos.y-30 + racket.size * sin(radians(racket.rightRotation))*2;
      if (rectRect(birdiePos.x-20, birdiePos.y-10, size, size, x, y, racket.size, racket.size)) {


        return true;
      } else return false;
    }
  }
  boolean rectRect(float r1x, float r1y, float r1w, float r1h, float r2x, float r2y, float r2w, float r2h) {

    if (r1x + r1w >= r2x &&    // r1 right edge past r2 left
      r1x <= r2x + r2w &&    // r1 left edge past r2 right
      r1y + r1h >= r2y &&    // r1 top edge past r2 bottom
      r1y <= r2y + r2h) {    // r1 bottom edge past r2 top
      return true;
    }
    return false;
  }

  public void makeBirdie() {
    fill(#FFFFFF);
    pushMatrix();
    translate(birdiePos.x, birdiePos.y);
    rotate(birdieRotation);
    ellipse(0, 0, size-15, size/3);
    float featherSize = size * 0.5;
    float featherOffset = featherSize * 0.2;
    fill(#DAEE01);
    triangle(featherOffset, 0, featherSize + featherOffset, -featherSize, featherSize + featherOffset, featherSize);
    popMatrix();
  }

  public void updateBirdie() {

    if (!startRound) {
      PVector gravity = new PVector(0, 0.1);
      birdieVelocity.add(gravity);
      if (birdieVelocity.x > 0 ) {
        birdieRotation += 0.01;
      } else {
        birdieRotation -= 0.01;
      }


      // Update position
      birdiePos.add(birdieVelocity);

      // Check boundaries
      if (birdiePos.y > height-100) {
        score();
      }
    } else {
      return;
    }
  }
  void score() {

    if (birdiePos.x > width/2) {
      leftScore++;
      startRound = true;
      birdiePos.x = width/4;
      birdiePos.y = 450;
      birdieVelocity = new PVector(0, 0);
    } else {
      rightScore++;
      startRound = true;
      birdiePos.x = width/2 + width/4;
      birdiePos.y = 450;
      birdieVelocity = new PVector(0, 0);
    }
    if (rightScore == 7) {
      textSize(60);
      fill(#FFFFFF);
      text("Player2 wins!", width/2 - 100, height/2);
      noLoop();
    } else if (leftScore == 7) {
      
      textSize(32);
      fill(#FFFFFF);
      text("Player1 wins!", width/2 - 100, height/2);
      noLoop();
    }
  }
  //good to go
  void leftSwings() {
    PVector leftHit1 = new PVector(10, -7);
    PVector leftHit2 = new PVector(12, -5);
    PVector leftHit3 = new PVector(14, -4);
    PVector leftHit4 = new PVector(20, 10);
if(onceLeft){
        birdie.birdieVelocity.x = 0;
    birdie.birdieVelocity.y = 0;
    if (racketLeft.racketState == 0) {
      birdieRotation = PI-0.5;
      birdieVelocity.add(leftHit1);
    }

    if (racketLeft.racketState == 1) {
      birdieRotation = PI-0.5;
      birdieVelocity.add(leftHit2);
    }
    if (racketLeft.racketState == 2) {
      birdieRotation = PI-0.5;
      birdieVelocity.add(leftHit3);
    }
    if (racketLeft.racketState == 3) {
      birdieRotation = PI-0.5;
      birdieVelocity.add(leftHit4);
    }
  }
  onceLeft = false;
  }

  void rightSwings() {
    PVector rightHit1 = new PVector(-10, -7);
    PVector rightHit2 = new PVector(-12, -5);
    PVector rightHit3 = new PVector(-14, -4);
    PVector rightHit4 = new PVector(-20, 10);
    
if(onceRight){
        birdie.birdieVelocity.x = 0;
    birdie.birdieVelocity.y = 0;
    if (racketRight.racketState == 0) {
      birdieRotation = 0.4;
      birdieVelocity.add(rightHit1);
    }
    if (racketRight.racketState == 1) {
      birdieRotation = 0.4;
      birdieVelocity.add(rightHit2);
    }
    if (racketRight.racketState == 2) {
      birdieRotation = 0.4;
      birdieVelocity.add(rightHit3);
    }
    if (racketRight.racketState == 3) {
      birdieRotation = 0.4;
      birdieVelocity.add(rightHit4);
    }
  }
  onceRight = false;
  }
  
}
