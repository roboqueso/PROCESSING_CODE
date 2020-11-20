//  SEE:   https://ello.co/ericfickes/post/xo5zby6vamy1lprrzduwhw
//  GOTO:  https://github.com/ericfickes/FIXLIB
//  source
//  http://studio.sketchpad.cc/sp/pad/view/ro.9ZdbPHUvjZkMn/latest
//  clone
//  http://studio.sketchpad.cc/sp/pad/newsketch?clonePadId=ro.9ZdbPHUvjZkMn&cloneRevNum=5


import fixlib.*;
Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;
int buf;
int alf = 45, tX, tY, inLeft, inRight, wvStart,i;


////  CIRCLEY THING
float cX, cY, inc, m; 
float r, g, b;

float x, y, angle, sz=42;
float x2, y2, angle2, sz2; 
float x3, y3, angle3, sz3; 
float x4, y4, angle4, sz4; 


void settings(){
  size(displayWidth, displayHeight);// FX2D, P3D
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}


////////////////////////////////////////////////////////////////////////
void setup() {

  background(255); 
  noFill();
  ellipseMode(CENTER);
  rectMode(CENTER); 
  strokeCap(ROUND); 
  strokeJoin(ROUND);
  noFill();  // this ties the room together  
  fix.alpha(alf);

  cX = width/2;
  cY = height/2;
  sz = random(555);
  sz2 = random(444);
  sz3 = random(333);
  sz4 = random(222);


  y = cY;

}

/////////////////////////////////////////////////////////////////
void draw()
{


    //  CIRCLE CIRCLE DOT DOT
    x = cX - int( cos(radians(angle)) * sz +noise(frameCount) )+noise(frameCount);
    y = cY - int( sin(radians(angle)) * sz +noise(frameCount) )+noise(frameCount);
 
    strokeWeight(14);
    //stroke(frameCount%2==0?0:255);
    stroke(frameCount%2==0? #454545 : #EFEFEF);

    point( x, y );
    point( width-x, height-y );
 
    strokeWeight(9);
    stroke(frameCount%2==0? #EFEFEF : #454545);
    point( x, y );
    point( width-x, height-y );
    
    strokeWeight(4);
    stroke(frameCount%2==0? #454545 : #EFEFEF);
    point( x, y );
    point( width-x, height-y );
 
    strokeWeight(1);
    stroke(frameCount%2==0? #DAAAAD : #B0000B, alf+noise(frameCount));
    ellipse( cX, cY, angle+i, angle+i);

    if( frameCount % 42 == 0 ){
      sz+=15;
    }

    if( angle < width )
        angle+=TWO_PI;
    else
        angle = random(cX,width);
    
     x = cX - int( cos(radians(angle)) * sz +noise(frameCount) );
     y = cY - int( sin(radians(angle)) * sz +noise(frameCount) );

 
if( i % 15 == 0 ){

getFlowery( cX, cY, 
            y-i, x-i,
            random(x), random(y),
            random(width-x), random(height-y) );
 
}
 
 
    if (i < cY ) {
        i+=2;
    } else {
        i = 0; 
    }


    
  ////  STOPPER
  if ( frameCount > displayWidth ) {
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
    stroke(#EF2020);   
    bezier( x, y, x2, y2, x3, y3, x4, y4);
 
    strokeWeight(6);
    stroke(#20EF20);
    bezier( x, y, x2, y2, x3, y3, x4, y4);
 
    strokeWeight(2);
    stroke(#2020EF);
    bezier( x, y, x2, y2, x3, y3, x4, y4);
}






///////////////////////////////////////////////////////////
//  End handler, saves png
void doExit() 
{

  //  if final, save output to png
  if ( isFinal )
  {
    fill(#DAD666);
    text("ericfickes.com", width-100, height-11);

    save( fix.pdeName() + "-" + fix.getTimestamp()+".tif" );
  }

  noLoop();
  exit();
}
