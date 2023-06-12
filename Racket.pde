import java.util.Random;
public class Racket {
  private PVector racketPos;
  private int size = 100;
  private boolean leftSide = true;
  private int racketState = -1; // Initial state of the racket
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
      fill(#FF0000);
      pushMatrix();
      racketPos.x = pos.x*4-55;
      racketPos.y = pos.y*4+55;
      translate(pos.x*4-55, pos.y*4+55);
      rotate(radians(leftRotation));
      rect(0,0, size*1.5, size/10);
      fill(#FFFFFF);
      ellipse(size*1.5,  size/10, size, size/3);
      popMatrix();
    } else {
      fill(#00FFFF);
      pushMatrix();
            racketPos.x = pos.x*4+55;
      racketPos.y = pos.y*4+55;
      translate(pos.x*4+55, pos.y*4+55);
      rotate(radians(rightRotation));
      rect(0, 10, size*1.5, size/10);
      fill(#FFFFFF);
      ellipse(size*1.5,  size/10, size, size/3);
      popMatrix();
    }
  }

}
