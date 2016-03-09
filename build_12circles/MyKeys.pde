void keyPressed() {
  if (key == ' ') {
    if (!paused) {
      // stop
      noLoop();
      paused = true;
    } else {
      // restart
      loop();
      paused = false;
    }
  }

  if (key == '+') {
    redraw();
  }

  if (key == 'r') {
    record = true;
    draw();
  }
}

