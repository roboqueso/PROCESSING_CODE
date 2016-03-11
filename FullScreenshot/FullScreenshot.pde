// note: For Processing 2.0 replace displayWidth and displayHeight by screenWidth and screenHeight respectively
import java.awt.Robot;
import java.awt.Rectangle;
import java.awt.AWTException;
 
PImage screenshot;
boolean smoothOn;
int x,y;
 
void setup() {
  size(int(displayWidth*0.85),int(displayHeight*0.85));
  frame.removeNotify();
  frame.setUndecorated(true);
}
 
void draw() {
  if (smoothOn) { smooth(); } else { noSmooth(); }
  screenshot();
  image(screenshot, 0, 0, width, height);
}
 
void screenshot() {
  try {
    Robot robot = new Robot();
    screenshot = new PImage(robot.createScreenCapture(new Rectangle(0,0,displayWidth,displayHeight)));
  } catch (AWTException e) { }
}
 
void mouseMoved(){
  x = int((float) mouseX/width * (displayWidth - width));
  y = int((float) mouseY/height * (displayHeight - height));
  x = int(x * 0.02 + frame.getLocation().x * 0.98);
  y = int(y * 0.02 + frame.getLocation().y * 0.98);
  frame.setLocation(x,y);
}
 
void mousePressed() {
  smoothOn = !smoothOn;
}
