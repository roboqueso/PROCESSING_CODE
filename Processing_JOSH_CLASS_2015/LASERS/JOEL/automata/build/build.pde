import processing.pdf.*;

boolean record = true;
CA ca;

void setup(){
  size(800,800);
  H.init(this).background(#9C9C9C);  
  ca = new CA();

}



void draw() {
  // H.drawStage();
   
  ca.generate();
}

// pause, restart, advance 1 / with key presses

// spacebar = pause and restart animation
// +        = redraw() advances 1 iteration in the animation
// r        = render to PDF
// c        = recolor and redraw() advances 1 iteration in the animation

void keyPressed() {
  if (key == ' ') {
    if (paused) {
      loop();
      paused = false;
    } else {
      noLoop();
      paused = true;
    }
  }

  if (key == '+') {
    redraw();
  }

  if (key == 'p') {
    savePNG();
  }

  if (key == 'r') {
    record = true;
    saveVector();
  }

}

void saveVector() {
  PGraphics tmp = null;
  tmp = beginRecord(PDF, "render_#####.pdf");

  if (tmp == null) {
    H.drawStage();
  } else {
    H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha
  }

  endRecord();
}


void savePNG() {
  saveFrame("render_#####.png");
}
 
