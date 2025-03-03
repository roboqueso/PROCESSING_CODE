//  SEE:   https://ello.co/ericfickes/post/7hg58qdrto4hppkeshj0bw
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);


Boolean isFinal = true;
int alf = 69;

int cX;
int cY;

color[] palette = { #EF0000, #0DEF10, #EF4521, #CECE00, #FA7680, #EF1975, #007007, #EFEF00, #FA9187, #007007, #109109 };

float i = 0; 

void settings(){
  size(displayWidth, displayHeight, FX2D);
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}

/////////////////////////////////////////////////////////////////////////
void setup() {
    background( palette[(int)random(palette.length)] );
    frameRate(666);
    noFill();
    rectMode(CENTER);
    
    cX = width/2;
    cY = height/2;
    
    //    scan rects
    strokeWeight(.75);
    stroke(0);
    for( int x = 0, y=0; y < height+TWO_PI; x+=PI) {
        rect( x, random(y), random(TWO_PI*PI), random(TWO_PI*TWO_PI) );
 
        if( x < width ) {
            x += PI;
        } else {
            x = 0;
            y += PI;
        }
    }
 
} 
 
/////////////////////////////////////////////////////////////////////////
void draw() {

    i = random(frameCount*noise(frameCount));
    strokeWeight(random(PI));
 
 noiseDetail(frameCount/100);
 
    if( frameCount % 2 == 0 ) {
 
        stroke(18, random(222), 18);
        rect( 
              constrain( random(width-i)*noise(frameCount-i), 0, cX ),
              
              i+frameCount*noise(frameCount), 
              random(height)/random(TWO_PI*PI), 
              random(width)/TWO_PI*TWO_PI
        );
        
    } 
    else 
    {
 
        strokeWeight( random(alf) );
        stroke(random(9),random(37),random(9), 37 );
        rect( 
              constrain( random(width-i)*noise(frameCount-i), 0, cX ),
              
              i+frameCount*noise(frameCount), 
              random(height)/random(TWO_PI*PI), 
              random(width)/TWO_PI*TWO_PI
        );
        
     
    }
 
 
    //    stop
    if( frameCount > height ) {
        doExit();
    }
}




///////////////////////////////////////////////////////////
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

  textFont( createFont( "Silom", 37 ) );
  smooth();

  fill(#EFEFEF);
  text( " "+dailyMsg, this.width-450, this.height-10);
}

