//  
//  http://ericfickes.com
//
Boolean isFinal = true;
float alf = 75;

int cX;
int cY;

color[] palette = { #EF0000, #00EF00, #0000EF, #CECE00, #FA7680, #EF1975, #007007, #EFEF00, #FA9187, #007007, #109109 };

FixLib fix = new FixLib();

////////////////////////////////////////////////////
//
float i = 0; 
/////////////////////////////////////////////////////////////////////////
void setup() {
    background(37);
    size(1024,768);  // P3D
    
    ellipseMode(CENTER);
    rectMode(CENTER);
    
    cX = width/2;
    cY = height/2;
    
} 
 
/////////////////////////////////////////////////////////////////////////
void draw() {
     smooth();
    stroke( 255);
    fill(0);
    
    if( i % ( width/2 ) == 0 ) {
        i = random( TWO_PI );
    } else {
        i++;
    }
   
     
    i = random(frameCount*noise(frameCount));
    strokeWeight(random(PI));
 
     noiseDetail(frameCount/100);

//////////////////////////////////
//  CORNERS
//////////////////////////////////

 ellipse( frameCount, frameCount, i/PI, i/PI ); 

 ellipse( width-frameCount, frameCount, i/PI, i/PI ); 

 ellipse( frameCount, height-frameCount, i/PI, i/PI ); 

 ellipse( width-frameCount, height-frameCount, i/PI, i/PI ); 


//////////////////////////////////
//  half way
//////////////////////////////////
ellipse(frameCount, (height/2), frameCount/PI, i/PI  );
ellipse(width-frameCount, (height/2) , frameCount/PI, i/PI  );


//////////////////////////////////
//  middle
//////////////////////////////////
ellipse( cX, frameCount, frameCount/i, frameCount/PI  );
ellipse( cX, height-frameCount, frameCount/i, frameCount/PI  );

 
 
    //    stop
    if( frameCount > width ) {
        exit();
    }
}




///////////////////////////////////////////////////////////
//  End handler, saves png
void exit() 
{

  artDaily("ERICFICKES.COM" );

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

  textFont( createFont( "Silom", 37 ) );
  smooth();

  fill(#EF3737);
  text( " "+dailyMsg, this.width-450, this.height-10);
}

