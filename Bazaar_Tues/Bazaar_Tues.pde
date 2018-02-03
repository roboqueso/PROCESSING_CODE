
import fixlib.*;

Fixlib fix = Fixlib.init(this);
Boolean isFinal = true;
float alf = 100;
PImage img;
ArrayList p3;

float a, x, y, co, bri, i, sz, h;
int cX, cY;

float angle = 0, angle2 = 0;
float x2, y2;

////////////////////////////////////////////////////////////////////////
void setup() {
  size(1024,768);

  background(alf*TWO_PI);
  noFill();

  cX = 1024/2;
  cY = 768/2;

  img = loadImage("apple-models.jpg");
  p3 = fix.getImgColors(img);  


  image( img, 1024-400, 768-400);
  filter(GRAY);  
  
  //  vertical scan lines
  strokeWeight(.75);
  for( int w = 0; w < 1024; w+=2 ) {
    fix.randStroke();
    line( w, 0, w, 768 ); 
  }
  
}

/////////////////////////////////////////////////////////////////////////
void draw() {
  smooth();

  strokeWeight(1);
  stroke(random(255));
  fill(random(75), random(TWO_PI) );


  bezier( cX-i* cos( radians(i) * i ), cY-i* sin( radians(i) * i ), 
          i*noise(i), i*cos(frameCount), 
          i*cos(frameCount), i*noise(i), 
          cX*noise(frameCount), cY*noise(frameCount)
        );



  // color
  if ( frameCount > 768*.75 ) {
//    stroke( random(37), random(75), random(37) );
    fix.ranPalStroke(p3);
    strokeWeight(.5);
    
    beginShape();

//fix.randStroke();
fix.ranPalStroke(p3);
    
      vertex( cX-i* cos( radians(i) * i ), cY-i* sin( radians(i) * i ) );
    
      bezierVertex( cX-i* cos( radians(i) * i ), cY-i* sin( radians(i) * i ), 
              i*noise(i), i*cos(frameCount), 
              i*cos(frameCount), i*noise(i), 
              cX*noise(frameCount), cY*noise(frameCount),
              1024-frameCount
            );
            
      curveVertex( cX-i* cos( radians(i) * i ), cY-i* sin( radians(i) * i ), 1024-frameCount );

        vertex( i*noise(i), i*cos(frameCount) );
        
      curveVertex( i*noise(i), i*cos(frameCount), 1024-frameCount );

      vertex( i*cos(frameCount), i*noise(i) );
      
      curveVertex( i*cos(frameCount), i*noise(i), 1024-frameCount );

      curveVertex( cX*noise(frameCount), cY*noise(frameCount), 1024-frameCount );

      vertex( cX*noise(frameCount), cY*noise(frameCount) );
      
    endShape();
  }

  //stroke( random(255), random(37), random(37) );
  strokeWeight( random(i)/ TWO_PI*noise(frameCount) );
  point( cX-i* cos( radians(i) * i ), cY-i* sin( radians(i) * i ) );
  point( i*noise(i), i*cos(frameCount) );
  point( i*cos(frameCount), i*noise(i) );
  point( cX*noise(i), cY*noise(i) );


  // move over a pixel
  if (i < 1024) {
    i++;
  } 
  else {
    i = 0;
  }

  if ( frameCount > 768 ) {

    exit();
  }
}




///////////////////////////////////////////////////////////
//  End handler, saves png
void exit() 
{

  artDaily("ERICFICKES.COM");

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

  textFont( createFont( "Silom", 18 ) );
  smooth();

  fill(#EFEFEF);
  text( " "+dailyMsg, 10, 768-10);

  fill(0);
  text( " "+dailyMsg, 11, 768-11);
}

