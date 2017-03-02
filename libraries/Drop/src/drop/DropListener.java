package drop;

/**
 * Drop Listener is an abstract class and can be extended from
 * a custom class.
 * DropListener needs to implement dropEvent(DropEvent theDropEvent) and
 * can overwrite dropEnter() and dropLeave()
 *
 * @example dropDropOnTarget
 */
public abstract class DropListener {

  float x1;

  float x2;

  float y1;

  float y2;

  boolean isSpecificTargetLocation;

  boolean isInsideTarget;

  /**
   * set the target rect where things can be dropped into.
   *
   * @param theX float
   * @param theY float
   * @param theWidth float
   * @param theHeight float
   */
  public final void setTargetRect(
      float theX,
      float theY,
      float theWidth,
      float theHeight) {
    isSpecificTargetLocation = true;
    x1 = theX;
    y1 = theY;
    x2 = theX + theWidth;
    y2 = theY + theHeight;
  }

  protected final boolean isInside(float theX, float theY) {
    return (theX > x1 &&
        theX < x2 &&
        theY > y1 &&
        theY < y2);
  }

  protected final void dropFinished() {
    isInsideTarget = false;
    dropLeave();
  }

  protected final void updateLocation(float theX, float theY) {

    if(isInside(theX, theY)) {
      if(isInsideTarget== false) {
        isInsideTarget = true;
        dropEnter();
      }
    } else {
      if(isInsideTarget==true) {
        isInsideTarget = false;
        dropLeave();
      }
    }
  }

  public void dropEnter() {}

  public void dropLeave() {}

  public abstract void dropEvent(DropEvent theDropEvent);

}
