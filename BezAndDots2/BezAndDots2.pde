//  source
//  http://studio.sketchpad.cc/sp/pad/view/ro.9ZdbPHUvjZkMn/latest
//  clone
//  http://studio.sketchpad.cc/sp/pad/newsketch?clonePadId=ro.9ZdbPHUvjZkMn&cloneRevNum=5


import fixlib.*;

//  https://github.com/ericfickes/FIXLIB
Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;
int buf;
int alf = 42, tX, tY, inLeft, inRight, wvStart,i;


////  CIRCLEY THING
float cX, cY, inc, m; 
float r, g, b;

float x, y, angle, sz=42;
float x2, y2, angle2, sz2; 
float x3, y3, angle3, sz3; 
float x4, y4, angle4, sz4; 


/////////////////////////////////////////////////////////////////////////////////
void setup()
{
	// size(2048,1024);	//	 .hdr dimensions
  size(1024,768, FX2D);  //  big:  1024x768

  
  background(#efefef); 
  noFill();
  ellipseMode(CENTER);
  rectMode(CENTER); 
  strokeCap(ROUND); 
  strokeJoin(ROUND);
  
  fix.alpha(alf);

  cX = width/2;
  cY = height/2;
  sz = 100;
  sz2 = 109;
  sz3 = 150;
  sz4 = 185;


  y = cY;

    smooth(8);
}

/////////////////////////////////////////////////////////////////
void draw()
{


    //  CIRCLE CIRCLE DOT DOT
    x = cX - int( cos(radians(angle)) * sz +noise(frameCount) );
    y = cY - int( sin(radians(angle)) * sz +noise(frameCount) );
 
    strokeWeight(14);
    stroke(frameCount%2==0?0:255);
    point( x, y );
    point( width-x, height-y );
 
    strokeWeight(9);
    stroke(frameCount%2==0?255:0);
    point( x, y );
    point( width-x, height-y );
    
    strokeWeight(4);
    stroke(frameCount%2==0?0:255);
    point( x, y );
    point( width-x, height-y );
 
    strokeWeight(1);
    stroke(frameCount%2==0?0:255,alf/2);
    ellipse( cX, cY, angle+i, angle+i);

    if( frameCount % 42 == 0 ){
      sz+=15;
    }

    if( angle < width)
        angle+=TWO_PI;
    else
        angle = 0;
    
     x = cX - int( cos(radians(angle)) * sz +noise(frameCount) );
     y = cY - int( sin(radians(angle)) * sz +noise(frameCount) );

 
if( i % 15 == 0 ){

getFlowery( cX, cY, 
            y-i, x-i,
            random(x), random(y),
            random(width-x), random(height-y) );
 
}
 
 
    if (i < (height/2) ) {
        i+=2;
    } else {
        i = 0; 
    }


    
  ////  STOPPER
  if ( frameCount > height ) {
    doExit();
  }
}


///////////////////////////////////////////////
//  bezier helper
void getFlowery(
  float x, float y,
  float x2, float y2,
  float x3, float y3, 
  float x4, float y4
)
{

    strokeWeight(12);
    stroke(#EF0000);
    bezier( x, y, x2, y2, x3, y3, x4, y4);
 
    strokeWeight(6);
    stroke(#EFEF00);
    bezier( x, y, x2, y2, x3, y3, x4, y4);
 
    strokeWeight(2);
    stroke(#000037);
    bezier( x, y, x2, y2, x3, y3, x4, y4);
}






///////////////////////////////////////////////////////////
//  End handler, saves png
void doExit() 
{

  //  if final, save output to png
  if ( isFinal )
  {
    fill(#EF2018);
    text("ericfickes.com", width-100, height-11);

    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  }

  noLoop();
  exit();
}
