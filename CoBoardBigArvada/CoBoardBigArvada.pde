
// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;
Boolean drawBoard = false;
int alf = 50;
float cX, cY;

color[] p1 = { #EFEFEF, #FFFFFF, #EFEFEF,#3A3A3A,#4D4D4D,#606060,#737373,#868686,#9A9A9A,#ADADAD,#C0C0C0,#C6C6C6,#CDCDCD,#D3D3D3,#D9D9D9,#E0E0E0,#E6E6E6,#ECECEC,#F2F2F2,#F9F9F9, #FFFFFF};

color[] p2 = { 
#3a393a, #414041, #424142, #4a484a, #5c585c, #7b7579, #a3959d, #afa3a9, #aea1a7, #95858b, #a08d92, #c1b2b4, #b7a6a8, #7b696b, #b6a3a5, #8d7b7c, #9e898a, #252424, #dad1d1, #2b2b2b, #323232, #ad9e9e, #716462, #97817d, #c7bdbb, #c6bcba, #cfc1be, #7f6964, #a58982, #736764, #8d7670, #dcd5d3, #99857f, #8c7770, #86756f, #cbbbb5, #b9a9a3, #ded6d3
};
//  #A59DA1,#D96D55,#F36613,#A9ABEA,#D23301,#F6FAFD,#AB6E9C,#D6F9FF,#F8751E,#768A00,#F05510,#FFEE51,#FFB02A,#D7D5FA,

PImage img;
ArrayList p3;
  
float x;// = width/2;
float y;// = height/2;
float outerRad = 40;
float innerRad = 12;
float px1 = 0, py1 = 0, px = 0, py = 0, angle = 0;
float pts = 18;
float rot = 360.0/pts;



//  circle vars
float angle1, x1, y1, startX1, startY1, radius1;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(-1);
  fix.alpha(alf);
  cX = width * .5;
  cY = height * .5;

  // sun starting point
  x  = 606;
  y  = cY+30;  
  
img = loadImage( "arvada-birdseye.jpg");

p3 = fix.getImgColors( img , false);


image(img, 0, 0, width, height);
  
filter(GRAY);

fix.paletteGridFull(p3);
  
  noFill();

//  iHeartCO();
//  doExit();

}



////////////////////////////////////////////////////
//
void draw()
{

  strokeWeight(random(alf));
  
  //  sun around Colorado C
  beginShape(TRIANGLES); //  TRIANGLE_STRIP
  for (int i = 0; i < pts; i++) {
    smooth();
  
    px1 = x + cos(radians(angle))*outerRad;
    py1 = y + sin(radians(angle))*outerRad;

    px = x + cos(radians(angle))*innerRad;
    py = y + sin(radians(angle))*innerRad;


    angle += frameCount;//    angle += rot;
    
    fix.ranPalStroke(p3);
//    ranPalFill(p3);
    
    vertex(px1, py1);


    fix.ranPalStroke(p3);
//    ranPalFill(p3);
    vertex(px, py); 
    
    
    line( px, py, px1, py1 );
  
    
    angle += frameCount;//    angle += rot+i;

  }
  endShape();
 
  //  make bigger
  innerRad++;// += 15;
  outerRad+=alf;//+= 25;
  
  
  if( outerRad > width*7 ) {

  //  line behind text
    strokeWeight(3);

tint(#EFEFEF, alf);
image(img, 0, 0, width, height);

//filter(GRAY);

alf *= 1.5;

    for( float yy = cY-130; yy < cY+190; yy+=4 ) {
    //  for( float yy = cY-100; yy < cY+175; yy+=3 ) {
//ranPalStroke(p2);
      stroke(#EFEFEF, alf );      
      line( 0, yy, width, yy );
      
      fix.ranPalStroke(p3);
      line( yy+130, 0, yy+130, width );

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
  float startX = 220; 
  float startY = 475;

  textFont( createFont( "Silom", 350 ) );
  smooth();
  fill(0);
  stroke(0);
  strokeWeight( 5 );

////////////////////////////////////////////////////////////////
//  draw board frame
////////////////////////////////////////////////////////////////

if( drawBoard ) {
  strokeWeight(10);
  while ( angle < 360 ) {

    x = startX - int( cos(radians(angle)) * w );
    y = startY - int( sin(radians(angle)) * w );

    smooth();

    //  fill lines
    if( angle <= 90 ) {
      line( x, y, x, 0 ); 
    } 
    
    if( angle == 90 ) {
      line( x, y, x+1000, y );
      fill(0);
      rect( x, 0, 1000, 265 );
    }
    
    if( angle >= 90 && angle < 270 ) {
      
      x+=1000;

      if ( angle > 90 && angle < 180 ) {
        line( x, y, x, 0 ); 
      }

    } else if( angle == 270 ) {
      line( x+1000, y, x, y ); 
    }


    if ( angle > 180 && angle < 270 ) {
      line( x, y, x, height ); 
    } else if ( angle > 270 && angle < 360 ) {
      line( x, y, x, height ); 
    } else if ( angle == 270 ) {
      rect( x, height-212, 1000, 275 );
    }

    point( x, y );//, w, h );
    

    angle ++;
    
  }

}

////////////////////////////////////////////////////////////////
//  / BOARD FRAME
////////////////////////////////////////////////////////////////

  fill(0);
  text("I", 310, cY+150);
  fix.bitHeart( 475, cY-90, false );
  text("CO", 760, cY+150);
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
  text( " "+dailyMsg, this.width-430, this.height-14);
  /*
float y = 0;
   while( y <= height ) {
   
   fill(#EFEFEF, y*.15);
   text( " "+dailyMsg, 5, y);
   y += 18; 
   }
   */
}

