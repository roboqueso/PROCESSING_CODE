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

public class spiralCircles extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);

//  draw circles and stuff, save on exit

Boolean isFinal = true;

float r = 1;  // 75;
float theta = 0;

int cX = 0;
int cY = 0;

int alf = 42;

//color[] colors = { #EFEFEF, #1975EF, #19EF75, #EF1975 };

float ranX = 0;
float ranY = 0;

///////////////////////////////////////////////////////////
//  
public void setup() {
  
  background(19);
  

  cX = width/2;
  cY = height/2;
  
  fill(0xff1975EF, 100);

  //NOTE : the translate call above makes the x,y jacked up
  text( "ERICFICKES.COM", 0,0 );

}

///////////////////////////////////////////////////////////
//  
public void draw() {

  
    // Polar to Cartesian conversion
    float x = (PI*r) * cos(theta);
    float y = (PI*r) * sin(theta);


      
//    noFill();
noTint();
/*
    fill( #FEFEFE, 45 );    
    ellipse( cX-x, cY-y, 10, 10);
    
    fill( #EFEFEF, 45);    
    ellipse( cX+x, cY+y, 10, 10 );
  */  
//    randStroke();
if( second() % 2 == 0 )
  stroke( 255,0,0, alf );
else if( second() % 3 == 0 )
  stroke( 0,255,0, alf  );
else if( second() % 4 == 0 )
  stroke( 0,0,255, alf  );
else if( second() % 5 == 0 )
  stroke( 200,200,200, alf  );
else if( second() % 6 == 0 )
  stroke( 100,100,100, alf  );
else if( second() % 7 == 0 )
  stroke( 50,50,50, alf  );
else if( second() % 8 == 0 )
  stroke( 25,25,25, alf  );
else if( second() % 9 == 0 )
  stroke( 5,5,5, alf  );



    noFill();
    ellipse( cX+x, cY+y, 22, 22 );

  theta  += 3.314f;  
  r      += 0.1234f;

  //
  if( theta >= 10000 )
  {
    doExit();
  }



}

///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
public void doExit() 
{

  //  if final, save output to png
  if( isFinal )
  {
    save( fix.pdeName() + fix.getTimestamp()+".png" );
  }

  noLoop();
  exit();
}
  public void settings() {  size( 1024, 768);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "spiralCircles" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
