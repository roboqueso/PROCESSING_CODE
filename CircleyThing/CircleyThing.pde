import fixlib.*;

//  https://github.com/ericfickes/FIXLIB
Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;


int alf = 75, tX, tY, szW, szH, cX, cY, inc, m; 
float r,g,b, maxCt;

int tmr_Interval = 10;  // seconds

float x, y, angle, sz;
float x2, y2, angle2, sz2; 
float x3, y3, angle3, sz3; 
float x4, y4, angle4, sz4; 

//////////////////////////////////////////////
void setup() { 
  background(#110000);
  size(1024,768);  //  big:  1024x768

  noFill();
  cX = width/2;
  cY = height/2;
  sz = 11;
  sz2 = 37;
  sz3 = 75;
  sz4 = 185;
  maxCt = (width*2);
} 
//////////////////////////////////////////////
void draw() {
  
  
  
  
  smooth();

  x = cX - int( cos(radians(angle)) * sz );  // * noise(frameCount);
  y = cY - int( sin(radians(angle)) * sz );  // * noise(frameCount);
  x2 = cX - int( cos(radians(angle2)) * sz2 );  // * noise(frameCount);
  y2 = cY - int( sin(radians(angle2)) * sz2 );  // * noise(frameCount);
  x3 = cX - int( cos(radians(angle3)) * sz3 );  // * noise(frameCount);
  y3 = cY - int( sin(radians(angle3)) * sz3 );  // * noise(frameCount);
  x4 = cX - int( cos(radians(angle4)) * sz4 );  // * noise(frameCount);
  y4 = cY - int( sin(radians(angle4)) * sz4 );  // * noise(frameCount);


m = random(height);
strokeWeight(.37);
stroke(frameCount%75);
ellipse( cX, cY, m, m );


  strokeWeight(random(TWO_PI));
  stroke(0);
//  stroke(random(255), random(alf),random(alf),alf);
  point( x, y );
  point( x2, y2 );
  point( x3, y3 );
  point( x4, y4 );



  strokeWeight(.75);
  r = random(255);
  g = random(37);
  b = random(37);
  stroke(r,g,b,alf);
  bezier(x, y, x2, y2, x3, y3, x4, y4 );
  bezier(x2, y2, x3, y3, x4, y4, x, y );
  stroke(r,g,b,alf);
  bezier(x3, y3, x4, y4, x, y, x2, y2 );
  bezier(x4, y4, x, y, x2, y2, x3, y3 );


//  strokeWeight(.75);
//  stroke(frameCount%2==0?255:#EFEFEF, alf);
//  line( x, y, x2, y2 );
//  line( x3, y3, x4, y4 );

//  strokeWeight(2);
//  stroke(frameCount%2==0?0:#220000, alf);
//  bezier(x, y, x2, y2, x3, y3, x4, y4 );
//  bezier(x2, y2, x3, y3, x4, y4, x, y );
//  bezier(x3, y3, x4, y4, x, y, x2, y2 );
//  bezier(x4, y4, x, y, x2, y2, x3, y3 );
//
//
//  strokeWeight(.37);
//  stroke(frameCount%2==0?0:#EF1234, alf);
//  bezier(x, y, x2, y2, x3, y3, x4, y4 );
//  bezier(x2, y2, x3, y3, x4, y4, x, y );
//  bezier(x3, y3, x4, y4, x, y, x2, y2 );
//  bezier(x4, y4, x, y, x2, y2, x3, y3 );



    strokeWeight(TWO_PI*noise(y));
//    stroke(37,37,random(255));
    stroke(frameCount%255);
    point(x,y);
    r = random(255);
    g = random(75);
    b = random(75);
    stroke(r,g,b );
    point(x2, y2);
    point(x3, y3);
    point(x4, y4);

// HACK: save on checking every single frame
//if( frameCount % tmr_Interval == 0 ) {
//  LOFI timer.
// TODO: Is millis() function causing the sketch pausing?
    if( millis()/1000 % tmr_Interval == 0 ) {
      strokeWeight(noise(frameCount));
      r = random(255);
      g = random(255);
      b = random(11);
      stroke(r,g,b);
//      m = random(angle2,angle3);
      fix.circle(r, g, b, m);
}
//println( millis() + " : " + millis()/1000 + " : " + tmr_Interval);
//}
//  END LOFI TIMER //


  angle += 10;
  angle2 += 15;
  angle3 += 20;
  angle4 -= 5;

  if ( angle2 % 360 == 0 ) {
    inc += TWO_PI;//cos(frameCount)*cos(frameCount)+PI;
    sz += inc;
    sz2 += inc;
    sz3 += inc;
    sz4 += inc;
      
    //  safe it
    if( sz > height || sz4 > height ) {
      sz = alf;
      sz2 = sz+5; 
      sz3 = sz+10;
      sz4 = sz+15;
    }
    

  }

  if ( frameCount > maxCt ) {
    doExit();
  }


/*
/////////////////////////////
//  FRAME COUNTDOWN
if(frameCount<maxCt){
stroke(255);
strokeWeight(2);
fill(0);
stroke(255);
fill(0);
rect( width-200, 0, 200, 20 );
fill(255,360);
text( maxCt - frameCount, width-200, 15 );
} else {
  fill(#EF2012);
  rect( width-200, 0, 200, 20 );
}
noFill();
/////////////////////////////

*/

}


///////////////////////////////////////////////////////////
//  End handler, saves png
void doExit() 
{

  artDaily( "ERICFICKES.COM" );

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

  textFont( createFont( "AppleGaramond", 37 ) );  //  "TrajanPro-Bold"
  smooth();

  fill(#EF2012);
  text( " "+dailyMsg, -1, height-2);

  fill(#efefef);
  text( " "+dailyMsg, 0, height-3);
}

