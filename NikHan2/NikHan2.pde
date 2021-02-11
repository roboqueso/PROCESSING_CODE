//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);

////  code from @nikhan
//  int a,b,i,c=600;void setup(){size(b=c,c);}void draw(){for(i=0;i++<c;){fill(a++%255);rect(sin(a)*c,c/2+cos(a*b/c)%c,a/c,sin(a)*c);}}

int a,b,i,c=600;

Boolean isFinal = true;
int alf = 11;
float shapeSize = 50;

int cX;
int cY;
float xx,yy;

//  
color[] palette = { 
  #EF0000, #00EF00, #0000EF, #EFEFEF, #A59DA1, #D96D55, #F42613, #A9ABEA, #D23301, #F6FAFD, #AB6E9C, #D6F9FF, #F8751E, #768A00, #F05510, #FFEE51, #FFB02A, #D7D5FA
};

int outerXX = 0;
int outerYY = 0;

float angle = 0;
float maxAngle;
float radius = 10;
float outerRadius = 100;

int offsetX = 0;
int offsetY = 0;
float _lerp = 0.01;

int ct = 0;
int maxCt = 0;
boolean flip = false;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(3);
  fix.alpha(alf);
  //  setup variables
  cX = width/2;
  cY = height/2;

  offsetX = cX;
  offsetY = cY;

  maxCt = 420 * 30;

  // white scan lines
  stroke(255, 8 );
  for ( int ll = 0; ll <= width; ll += 2 ) 
  {  
    strokeWeight( random(1.1) );

    line( 0, ll, random(width), ll );
    line( ll, 0, ll, random(height) );
  }
}


////////////////////////////////////////////////////
//

void draw()
{
  smooth();
  strokeWeight( random(5.5) );
  stroke( random(18), alf);
  noFill();

  xx = ( offsetX - int( cos(radians(angle)) * random(radius) ) );
  yy = ( offsetY - int( sin(radians(angle)) * random(radius) ) );

  outerXX = ( offsetX - int( cos(radians(angle)) * outerRadius ) );
  outerYY = ( offsetY - int( sin(radians(angle)) * outerRadius ) );

/*
  for(i=0;i++< width;) {
    stroke(a++%255, alf);
    line(sin(a)*c,c/2+cos(a*b/c)%c,a/c,sin(a)*c);
  }


if(flip)
  stroke( #EFEFEF, alf );
else
  stroke( #EF1234, alf );
*/  

  strokeWeight(.5);

  line(outerXX-1, outerYY-1, offsetX, offsetY);
  line(offsetX-1, offsetY-1, xx, yy);
  
  line(outerXX, outerYY, offsetX, offsetY);
  line(offsetX, offsetY, xx, yy);
  
  line(outerXX+1, sin(outerYY), offsetX, offsetY);
  line(offsetX+1, cos(offsetY), xx, yy);

//  rect(sin(a)*c,c/2+cos(a*b/c)%c,a/c,sin(a)*c);
  
  strokeWeight( random(alf) );
  point(xx, yy);

  stroke(#69B00B, alf*4 );
  
  point( outerXX, outerYY );
  point( random(xx, outerXX), random( yy, outerYY ) );  
  
  stroke( #EFEFEF, alf*4 );
  point( lerp(xx, outerXX, _lerp ), lerp( yy, outerYY, _lerp ) );


  if( flip ) {
    fix.ranPalStroke(palette);
    
    line( lerp(xx, outerXX, _lerp ), lerp( yy, outerYY, _lerp ), outerXX, outerYY );
    line( lerp(xx, outerXX, _lerp ), lerp( yy, outerYY, _lerp ), width-angle, shapeSize-angle );
    
  } else {
    fix.ranPalStroke(palette);
    ellipse( lerp(xx, outerXX, _lerp ), lerp( yy, outerYY, _lerp ), random(angle), random(angle) );
//    ellipse( lerp(xx, outerXX, _lerp ), lerp( yy, outerYY, _lerp ), random(shapeSize), random(shapeSize) );
  }

  
  if ( angle >= maxCt ) {
    doExit();
  }

  if( _lerp < 1 ) {
    _lerp += 0.05;
  } else {
    _lerp = 0.01;
  }


if ( angle % 1800 == 0 ) {
    flip = !flip;
    angle  += 6;
    radius += 6;

    offsetY = (int)random(height);
    offsetX = (int)random(width);

    strokeWeight( random(1.9) );
  } 
  else {
    angle+=2;  //6;
  }
}




///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{

  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + fix.getTimestamp() + ".png" );
  }

  noLoop();
  exit();
}



///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 18 ) );
  smooth();

  //  stroke(#EFEFEF);
  fill(#69EF19);
  text( " "+dailyMsg, this.width*.45, this.height-18);
}

