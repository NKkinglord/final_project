
public class Racket {
  private PVector racketPos;
  private int size = 100;
  private boolean leftSide = true;
  private int racketState = 0; // Initial state of the racket
  private int lastStateChangeTime = 0; // Time of the last state change
  private int stateChangeInterval = 50; // Interval between state changes in milliseconds
  private int leftRotation = 220;
  private int rightRotation = 320;
  public Racket(PVector playerPos, boolean left) {
    racketPos = new PVector(0, 0);
    racketPos.x = playerPos.x;
    racketPos.y = playerPos.y;
    leftSide = left;
  }

  public void makeRacket(PVector pos) {
   
    
    if (leftSide) {
      pushMatrix();
      racketPos.x = pos.x*4-55;
      racketPos.y = pos.y*4+55;
      translate(pos.x*4-55, pos.y*4+55);
      rotate(radians(leftRotation));
      rect(0,0, size*1.5, size/10);
      ellipse(size*1.5,  size/10, size, size/3);
      popMatrix();
    } else {
      pushMatrix();
            racketPos.x = pos.x*4+55;
      racketPos.y = pos.y*4+55;
      translate(pos.x*4+55, pos.y*4+55);
      rotate(radians(rightRotation));
      rect(0, 10, size*1.5, size/10);
      ellipse(size*1.5,  size/10, size, size/3);
      popMatrix();
    }
  }
  void keyPressed() {
    if (leftSide) {
      if (key == 's') {
        if (racketState == 3) {
          return;
        }
        
        if (millis() - lastStateChangeTime >= stateChangeInterval ) {
          racketState++;
          
          lastStateChangeTime = millis();
        }
      } else {
        racketState = 0;
      }
    } else {
      if (keyCode == DOWN) {
        if (racketState == 3) {
          return;
        }
        if (millis() - lastStateChangeTime >= stateChangeInterval ) {
          racketState++;
          lastStateChangeTime = millis();
        }
      } else {
        // Reset the racket state to 0 when the key is released
        racketState = 0;
      }
    }
  }
}