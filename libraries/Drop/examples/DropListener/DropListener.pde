/**
 * DropListener demonstrates how to use a DropListener with
 * a custom class.
*/

import drop.*;

SDrop drop;

MyDropListener m;

void setup() {
  size(400,400);
  drop = new SDrop(this);
  m = new MyDropListener();
  drop.addDropListener(m);
}

void draw() {
  background(0);
}


void dropEvent(DropEvent theDropEvent) {}


// a custom DropListener class.
class MyDropListener extends drop.DropListener { 
  MyDropListener() {}
    
  void dropEvent(DropEvent theEvent) {
    println("a drop event received from MyDropListener");
  }
  
}