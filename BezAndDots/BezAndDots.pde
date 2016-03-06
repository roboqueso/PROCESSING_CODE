//  source
//  http://studio.sketchpad.cc/sp/pad/view/ro.9ZdbPHUvjZkMn/latest
//  clone
//  http://studio.sketchpad.cc/sp/pad/newsketch?clonePadId=ro.9ZdbPHUvjZkMn&cloneRevNum=5

FixLib fix = new FixLib();
Boolean isFinal = true;
int buf;
float alf = 37, tX, tY, inLeft, inRight, wvStart,i;


////  CIRCLEY THING
float cX, cY, inc, m; 
float r, g, b;
int tmr_Interval = 10;  // seconds

float x, y, angle, sz=75;
float x2, y2, angle2, sz2; 
float x3, y3, angle3, sz3; 
float x4, y4, angle4, sz4; 


/////////////////////////////////////////////////////////////////////////////////
void setup()
{
  size(1024,768);  //  big:  1024x768
//size(128,96);  //  thumb:  128x96
  
  background(#efefef); 
  noFill();
  ellipseMode(CENTER);
  rectMode(CENTER); 
  strokeCap(ROUND); 
  strokeJoin(ROUND);
  textFont( createFont( "AnonymousPro", 22 ) );
  
  cX = width/2;
  cY = height/2;
  sz = 100;
  sz2 = 109;
  sz3 = 150;
  sz4 = 185;


  y = cY;

//  minim = new Minim(this);
//
//  // use the getLineIn method of the Minim object to get an AudioInput
//  in = minim.getLineIn();
}

/////////////////////////////////////////////////////////////////
void draw()
{
    smooth();

       
    //  CIRCLE CIRCLE DOT DOT
    x = cX - int( cos(radians(angle)) * sz +noise(frameCount) );
    y = cY - int( sin(radians(angle)) * sz +noise(frameCount) );
 
    strokeWeight(1);
    stroke(frameCount%2==0?0:255,alf);
    ellipse( cX, cY, angle, angle );
 
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
 
    if( frameCount % 45 == 0 ){
      sz+=15;
    }

    if( angle < width)
        angle+=TWO_PI;
    else
        angle = 0;
    
     x = cX - int( cos(radians(angle)) * sz +noise(frameCount) );
     y = cY - int( sin(radians(angle)) * sz +noise(frameCount) );

 
getFlowery( random(cX), random(cY), 
            y-i, x-i,
            x, y,
            random(width-x), random(height-y) );
 

 
 
    if (i < (height/2) ) {
        i+=2;
    } else {
        i = 0; 
    }


    
  ////  STOPPER
  if ( frameCount > width ) {
    exit();
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
void exit() 
{

  artDaily( "ERICFICKES.COM" );

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  }

  noLoop();
  System.gc();
  super.stop();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont( createFont( "AppleGaramond", 37 ) );  //  "TrajanPro-Bold"
  smooth();

  fill(#EFEFEF);
  text( " "+dailyMsg, width-300, height-2);

  fill(0);
  text( " "+dailyMsg, width-301, height-3);
}

