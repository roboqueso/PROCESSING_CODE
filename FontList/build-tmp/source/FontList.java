import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import fixlib.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class FontList extends PApplet {


Fixlib fix = Fixlib.init(this);

//  TODO: redo the grid logic to tile LEFT to RIGHT, TOP to BOTTOM
//  use calculate textWidth(msg) for each font to calculate NEXT X,Y

//  
//  Show a grid of ALL installed fonts
//
public String[] fontList = PFont.list();
public float xx, yy, txtSz = 21, rowHeight, colWidth;
public String msg = "Processing", fnt;
public Boolean isFinal = true;

public void setup(){
  // size( 1024, 768 );
  
  background(0);
  stroke(255);
  fill(255);

  // debug
  printArray(fontList);

}

public void draw(){

  
 if(frameCount>=fontList.length){
    if(isFinal){
      save( fix.pdeName() + fix.getTimestamp()+".png" );
    }
    
    noLoop();   
 }else{  
  try {
    fnt = fontList[frameCount];
    textFont( createFont( fnt, txtSz ));
  } 
  catch( Exception exc ){
println("EXC: " + exc.getMessage() );

    fnt = fontList[ PApplet.parseInt(random(fontList.length-1)) ];
    textFont( createFont( fnt, txtSz ));
    fill(random(255));
  }
//  text( msg, xx, yy );

text( fnt, xx, yy );
  
  if( yy <= 1024 ){
  
    yy += textAscent()+textDescent();
    
  } else {
    yy = txtSz;
    // NOTE: figure out a way to fit the full font list into the screen dynamically
    xx += txtSz*13;//6.7;  // 11;//

  }
  
  
  
  if( xx >= 1024 && yy >= 768 ){
      
    strokeWeight(12);
    stroke(0xffEF2012);
    point(1024/2, 768/2);
    
    strokeWeight(8);
    stroke(0);
    point(1024/2, 768/2);
    
    strokeWeight(4);
    stroke(0xff20EF12);
    point(1024/2, 768/2);
  
  }
 } 
}
  public void settings() {  size( displayWidth, displayHeight, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "FontList" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
