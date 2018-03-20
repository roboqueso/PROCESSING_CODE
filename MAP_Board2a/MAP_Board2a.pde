
// https://github.com/ericfickes/FIXLIB	
import fixlib.*;

Fixlib fix = Fixlib.init(this);
//  PDF
//import processing.pdf.*;

//  
//  Map Board -> I <3 CO skateboard graphic
//  

Boolean isFinal = true;
Boolean drawBoard = false;
int alf = 37;
float cX, cY;

color[] p1 = { #EFEFEF, #FFFFFF, #EFEFEF,#3A3A3A,#4D4D4D,#606060,#737373,#868686,#9A9A9A,#ADADAD,#C0C0C0,#C6C6C6,#CDCDCD,#D3D3D3,#D9D9D9,#E0E0E0,#E6E6E6,#ECECEC,#F2F2F2,#F9F9F9, #FFFFFF};

color[] p2 = { 
#A59DA1,#D96D55,#F36613,#A9ABEA,#D23301,#F6FAFD,#AB6E9C,#D6F9FF,#F8751E,#768A00,#F05510,#FFEE51,#FFB02A,#D7D5FA,

};


PImage img;
ArrayList p3;

float x;
float y;
float outerRad = 2;
float innerRad = 2;
float px = 0, py = 0, angle = 0;
float pts = 36;
float rot = 360.0/pts;

int loc;

//  circle vars
float angle1, x1, y1, startX1, startY1, radius1;

////////////////////////////////////////////////////
//
void setup() {
  size(1024, 768);
  frameRate(303);

//  PDF
//if(isFinal){
//  beginRecord(PDF, "Map_Board.pdf");
//}

  background(#EFEFEF);
  fix.alpha(alf);

  cX = width * .5;
  cY = height * .5;

  // sun starting point
  x  = 533;
  y  = cY-123;

    // get colors from CO MAP
    img = loadImage( "colorado.jpg");
    p3 = fix.getImgColors( img );

  // NOTE: using GRAYed CO since you can't use filter(GRAY) with PDF lib
  img = loadImage("colorado.jpg");
    

    image(img, 0, 0 );

    noFill();
    smooth();
}



////////////////////////////////////////////////////
//
void draw()
{

  strokeWeight( random(1,2) );

  beginShape(TRIANGLE_STRIP); //  TRIANGLE_STRIP
  for (int i = 0; i < pts; i++) {

  
    px = x + cos(radians(angle))*outerRad;
    py = y + sin(radians(angle))*outerRad;
    angle += frameCount;//    angle += rot;
    
    fix.ranPalStroke(p2);

    vertex(px, py);

    px = x + cos(radians(angle))*innerRad;
    py = y + sin(radians(angle))*innerRad;

    fix.ranPalStroke(p3);
    vertex(px, py); 
    
    angle += frameCount;//    angle += rot+i;

  }
  endShape();
 
  //  make bigger
  innerRad += 15;
  outerRad += 25;


  if( innerRad > width ) {

//  line behind text
  strokeWeight(1);
//  stroke(#EFEFEF, 150 );

for( float yy = cY-280; yy < cY+80; yy+=1.5 ) {
  
  fix.ranPalStroke100(p3);
  
  line( 0, yy, width, yy );
}  

//  tint(#EFEFEF, 50 );
//  image(img,0,0);


      iHeartCO();
      
//  stamp version number
textFont( createFont( "Silom", 36 ) );
fill(#EFEFEF);
text( fix.pdeName(), cX, cY+180 );

      doExit();
  }
}

///////////////////////////////////
//  draw i HEART CO
//  and board frame
void iHeartCO() {

  float angle = 0;
  float x, y;
  float w = 210;
  float startX = 210; 
  float startY = 345;


  smooth();
  fill(0);
  stroke(0);
  strokeWeight( 1 );  // 5

////////////////////////////////////////////////////////////////
//  draw board frame
////////////////////////////////////////////////////////////////

if( drawBoard ) {

  while ( angle < 360 ) {

    x = startX - int( cos(radians(angle)) * w );
    y = startY - int( sin(radians(angle)) * w );

    smooth();

    //  fill lines
/*    if( angle <= 90 ) {
      line( x, y, x, 0 ); 
    } */
    
    if( angle == 90 ) {
      
      line( 0,y-3, width, y-3 );
      
//      line( x, y, x+1020, y );
//      fill(0);
//      rect( x, 0, 1020, y );
    }  
    
    if( angle >= 90 && angle < 270 ) {
      
      x+=1020;

/*      if ( angle > 90 && angle < 180 ) {
        line( x, y, x, 0 ); 
      }  */

    } else if( angle == 270 ) {
//      line( x+1020, y, x, y ); 
      line( 0,y-3, width, y-3 );
    }

/*
    if ( angle > 180 && angle < 270 ) {
      line( x, y, x, height ); 
    } else if ( angle > 270 && angle < 360 ) {
      line( x, y, x, height ); 
    } else if ( angle == 270 ) {
      rect( x, y, 1020, height );
    }
*/
//    point( x, y );//, w, h );
    

    angle+= .5;
    
  }

}

////////////////////////////////////////////////////////////////
//  / BOARD FRAME
////////////////////////////////////////////////////////////////

  //  Team Fickes
  textFont( createFont( "AnonymousPro-Bold", 17 ) );//
  fill( #271200, 101 );
  text( "TEAM FICKES", cX+75, cY-124 );

  //  I <3 CO
  textFont( createFont( "Silom", 500 ) );  
  fill(0);

  fix.bitHeart( 360, cY-265, false );
  text("I", 150, cY+63 );
  text("CO", 710, cY+65 );
}

///////////////////////////////////////////////////////////
//  
//  End handler, saves png
void doExit() 
{

  artDaily("ERICFICKES.COM" );

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
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

  fill(#676800);
  text( " "+dailyMsg, this.width-230, this.height-14);
}