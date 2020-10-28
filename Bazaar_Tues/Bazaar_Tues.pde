//  SEE:   https://ello.co/ericfickes/post/8kgrqh3fl0ne7ulxy6b1aw
//  GOTO:  https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);
Boolean isFinal = true;
int alf = 180;
PImage img;
ArrayList p3;

float a, x, y, co, bri, i, sz, h;
int cX, cY;

float angle = 0, angle2 = 0;
float x2, y2;

void settings(){
  size(displayWidth, displayHeight, P3D);
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}


////////////////////////////////////////////////////////////////////////
void setup() {


  background(alf*TWO_PI);
  noFill();

  fix.alpha(alf);

  cX = displayWidth/2;
  cY = displayHeight/2;

  img = loadImage("Bazaar_Tues-10272020173521870.png");
  p3 = fix.getImgColors(img);  
  image( img, 0,0, cX, cY);
  filter(GRAY);  
  
  //  vertical scan lines
  strokeWeight(.75);
  for( int w = 0; w < displayWidth; w+=2 ) {
    fix.randStroke();
    line( w, 0, w, displayHeight ); 
  }
  
}

/////////////////////////////////////////////////////////////////////////
void draw() {
  
  strokeWeight(1);
  stroke(random(255));
  fill(random(75), random(TWO_PI) );


  bezier( cX-i* cos( radians(i) * i ), cY-i* sin( radians(i) * i ), 
          i*noise(i), i*cos(frameCount), 
          i*cos(frameCount), i*noise(i), 
          cX*noise(frameCount), cY*noise(frameCount)
        );



  // color
  if ( frameCount > displayHeight*.75 ) {
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
              displayWidth-frameCount
            );
            
      curveVertex( cX-i* cos( radians(i) * i ), cY-i* sin( radians(i) * i ), displayWidth-frameCount );

        vertex( i*noise(i), i*cos(frameCount) );
        
      curveVertex( i*noise(i), i*cos(frameCount), displayWidth-frameCount );

      vertex( i*cos(frameCount), i*noise(i) );
      
      curveVertex( i*cos(frameCount), i*noise(i), displayWidth-frameCount );

      curveVertex( cX*noise(frameCount), cY*noise(frameCount), displayWidth-frameCount );

      vertex( cX*noise(frameCount), cY*noise(frameCount) );
      
    endShape();
  }

  //stroke( random(255), random(37), random(37) );
  fix.ranPalStroke(p3);
  strokeWeight( random(i)/ TWO_PI*noise(frameCount) );
  point( cX-i* cos( radians(i) * i ), cY-i* sin( radians(i) * i ) );
  point( i*noise(i), i*cos(frameCount) );
  point( i*cos(frameCount), i*noise(i) );
  point( cX*noise(i), cY*noise(i) );


  // move over a pixel
  if (i < displayWidth) {
    i++;
  } 
  else {
    i = 0;
  }

  if ( frameCount > displayHeight ) {

    doExit();
  }
}




///////////////////////////////////////////////////////////
//  End handler, saves png
void doExit() 
{

  artDaily("ERICFICKES.COM");

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

  fill(#EFEFEF);
  text( " "+dailyMsg, 10, displayHeight-10);

  fill(0);
  text( " "+dailyMsg, 11, displayHeight-11);
}
