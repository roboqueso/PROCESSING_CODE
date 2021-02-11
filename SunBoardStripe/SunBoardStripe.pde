//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;
Boolean drawBoard = false;
int alf = 100;
float cX, cY;

color[] p1 = { 
  #EFEFEF, #FFFFFF, #EFEFEF, 
  #3A3A3A, 
  #4D4D4D, 
  #606060, 
  #737373, 
  #868686, 
  #9A9A9A, 
  #ADADAD, 
  #C0C0C0, 
  #C6C6C6, 
  #CDCDCD, 
  #D3D3D3, 
  #D9D9D9, 
  #E0E0E0, 
  #E6E6E6, 
  #ECECEC, 
  #F2F2F2, 
  #F9F9F9, 
  #FFFFFF
};

//  #A59DA1,#D96D55,#F36613,#A9ABEA,#D23301,#F6FAFD,#AB6E9C,#D6F9FF,#F8751E,#768A00,#F05510,#FFEE51,#FFB02A,#D7D5FA,
//  


color[] p2 = { 
  #A59DA1, #D96D55, #F36613, #A9ABEA, #D23301, #F6FAFD, #AB6E9C, #D6F9FF, #F8751E, #768A00, #F05510, #FFEE51, #FFB02A, #D7D5FA,
};
//  #EF0000, #EFEF11, #36EF75, #EF7535, #FF1234, #EF3619

float x;// = width/2;
float y;// = height/2;
float outerRad = 10;//min(width, height) * 0.4;
float innerRad = outerRad * 0.6;
float px = 0, py = 0, angle = 0;
float pts = 60;//36;
float rot = 360.0/pts;



//  circle vars
float angle1, x1, y1, startX1, startY1, radius1;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(#EFEFEF);
  fix.alpha(alf);
  cX = width * .5;
  cY = height * .5;

  // sun starting point
  x  = 523;
  y  = cY+30;
  noFill();

  //      iHeartCO();
  //      exit();
}



////////////////////////////////////////////////////
//
void draw()
{

  strokeWeight( random(1, 2) );

  beginShape(TRIANGLE_STRIP); //  TRIANGLE_STRIP
  for (int i = 0; i < pts; i++) {
    smooth();

    px = x + cos(radians(angle))*outerRad;
    py = y + sin(radians(angle))*outerRad;
    angle += frameCount;//    angle += rot;

    fix.ranPalStroke(p1);
    //fix.ranPalFill(p1);

    vertex(px, py);

    px = x + cos(radians(angle))*innerRad;
    py = y + sin(radians(angle))*innerRad;

    fix.ranPalStroke(p2);
    fix.ranPalFill(p2);
    vertex(px, py); 

    angle += frameCount;//    angle += rot+i;
  }
  endShape();

  //  make bigger
  innerRad += 15;
  outerRad += 25;


  if ( outerRad > width ) {

    //  line behind text
    strokeWeight(1);
    stroke(#EFEFEF, alf );

    for ( float yy = cY-100; yy < cY+175; yy+=1.5 ) {

      //  ranPalStroke(p2);

      line( 0, yy, width, yy );
    }  

    iHeartCO();
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
  float startX = 20; 
  float startY = 485;

  textFont( createFont( "Silom", 350 ) );
  smooth();
  fill(0);
  stroke(0);
  strokeWeight( 5 );

  ////////////////////////////////////////////////////////////////
  //  draw board frame
  ////////////////////////////////////////////////////////////////

  if ( drawBoard ) {

    while ( angle < 360 ) {

      x = startX - int( cos(radians(angle)) * w );
      y = startY - int( sin(radians(angle)) * w );

      smooth();

      //  fill lines
      if ( angle <= 90 ) {
        line( x, y, x, 0 );
      } 

      if ( angle == 90 ) {
        line( x, y, x+1000, y );
        fill(0);
        rect( x, 0, 1000, 275 );
      }

      if ( angle >= 90 && angle < 270 ) {

        x+=1000;

        if ( angle > 90 && angle < 180 ) {
          line( x, y, x, 0 );
        }
      } 
      else if ( angle == 270 ) {
        line( x+1000, y, x, y );
      }


      if ( angle > 180 && angle < 270 ) {
        line( x, y, x, height );
      } 
      else if ( angle > 270 && angle < 360 ) {
        line( x, y, x, height );
      } 
      else if ( angle == 270 ) {
        rect( x, height-202, 1000, 275 );
      }

      point( x, y );//, w, h );


      angle++;
    }
  }

  ////////////////////////////////////////////////////////////////
  //  / BOARD FRAME
  ////////////////////////////////////////////////////////////////

  fill(0);
  text("I", startX, cY+150);
  fix.bitHeart( startX+150, cY-90, false );
  text("CO", startX+420, cY+150);
}



///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{

  artDaily("ERICFICKES.COM" );

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName()+".png" );
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
  text( " "+dailyMsg, this.width-430, this.height-14);
}

