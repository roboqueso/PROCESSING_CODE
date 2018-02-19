Boolean isFinal = true;

int[] nz = new int[901];
boolean gotNoise = false;
boolean vert = true;
float xx=0,yy=0;
public int alf = 123;
int cX, cY;
// image
PImage img;
ArrayList p3;
 
void setup() {
    size(1024, 768);
    background(255);
    frameRate(303);
    smooth();
    noFill();
    rectMode(CENTER);

    
    cX = int( 1024 / 2 );
    cY = int( 768 / 2 );
    
  img = loadImage("emco2.png");  //"EmergentCollectiveTwo.png");

  //  MAKE TILED BACKGROUND
  for( int yy = 0; yy <= 768; yy += img.height ){

    for( int xx = 0; xx <= 1024; xx += img.width ){
      image( img, xx, yy );
    }
  }

  filter(GRAY);    
//  filter(INVERT);

  p3 = getImgColors( img );
}
 
void draw() {
 
    if(frameCount< 768 )
    {
        nz[frameCount-1] =int(random(frameCount)*random(noise(frameCount)) );
    }
 
 
        if(yy<height){
            xx += random(-nz[int(yy)],nz[int(yy)]);
            yy+=11;
        } else {
            yy=0;
            xx += random(nz[int(yy)])+37;
            stroke( (Integer)p3.get( (int)random( p3.size()-1 ) ), random(alf) );
        }
  
  strokeWeight(random(13));
        
  //  safety check
  if( xx < -PI || xx >= 1024+PI ){
    xx = random(1024 );
    
    ranPalStrokeCust( p3, 255 );
    bezier( 1024, yy, 
          random(cX), random(cY),
          random( 1024 - xx ), random( 768 - yy ) ,
          xx, yy );
    
    ranPalStrokeCust( p3, 255 );
    ellipse( xx, yy,  42,42 );
    
    ranPalStrokeCust( p3, 255 );
    curve( 1024, yy, 
          random(cX), random(cY),
          random( 1024 - xx ), random( 768 - yy ) ,
          xx, yy );
    
    ranPalStrokeCust( p3, 255 );
    ellipse( xx, yy, 21, 21 );

    ranPalStrokeCust( p3, 255 );
    point( xx, yy );
    
    stroke( (Integer)p3.get( (int)random( p3.size()-1 ) ), random(alf) );
    

  }
 
    stroke( (Integer)p3.get( (int)random( p3.size()-1 ) ), alf );
    point( xx, yy );

    strokeWeight(1);
    
    stroke(random(111), random(alf) );
    rect( xx, yy, noise(frameCount)*sqrt(yy+xx), noise(frameCount)*sqrt(yy+xx), random(xx, yy) );
 
    if( frameCount>width*13){
    
        ranPalStroke( p3 );
        rect( 111,111, 42, 41, frameCount);
        if(isFinal)
        {
          save(this+".png");
        }
    exit();
  }

}

///////////////////////////////////////////////////////////////////
//    Create a SWITCH based drawing system that accepts X, Y, and
//    randomly choose which movement system to fire
void systems( float x, float y )
{
    int pick = floor(random(0,3));
 
 fill(random(21,37),alf);
 text( x + " " + y + " " + pick, width-x, height-y );
 noFill();
 
    switch( pick ){
        
        case 0:
        {
            x = floor( (width/2)+cos(radians(frameCount))*(x-y) );
            y = floor( (height/2)+sin(radians(frameCount))*(y-x) );
            point( x-PI, y+PI );
            point( y+PI, X-PI );
        }
        break;
        
        case 1:
        {
            ellipse( x*cos(frameCount)*radians(TWO_PI), y*sin(frameCount)*radians(TWO_PI), alf, alf );
            ellipse( y*cos(frameCount)*radians(TWO_PI), x*sin(frameCount)*radians(TWO_PI), alf, alf );
        }
        break;
        
        case 2:
        {
            strokeWeight(.75);
            rect( x, y, TWO_PI+x*noise(frameCount), TWO_PI+x*noise(frameCount) );
            rect( y, x, TWO_PI+y*noise(frameCount), TWO_PI+y*noise(frameCount) );
        }
        break;
        
        case 3:
        {
            point( x * cos(x)*frameCount, y*sin(y)*frameCount );
            point( y * cos(x)*frameCount, x*sin(y)*frameCount );
            
            ellipse( x * cos(x)*frameCount, y*sin(y)*frameCount, frameCount, frameCount );
            ellipse( y * cos(x)*frameCount, x*sin(y)*frameCount, frameCount, frameCount );
        }
        break;
        
    }
}

void radialLine(float r1, float a1, float r2, float a2){
    
    float x1 = width/2  + cos(a1)*r1;
    float y1 = height/2 + sin(a1)*r1;
    float x2 = width/2  + cos(a2)*r2;
    float y2 = height/2 + sin(a2)*r2;
    
    line(x1, y1, x2, y2);
//    fill(255);
noFill();
    ellipse(x1,y1, TWO_PI, TWO_PI);
    ellipse(x2,y2, TWO_PI, TWO_PI);
    
    //println([r1,a1,r2,a2]);
}


//////////////////////////////////////////////////////
//  
void drawLissajous( float a, float b, float amp )
{
//  float amp = 33;
  float x, y;
  
  for( float t = 0; t <= 360; t += .1)
  {
    x = a - amp * sin(a * t * PI/180);
    y = b - amp * sin(b * t * PI/180);

    point(x,y);
  }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  pull colors out of image and return color[]
//  http://forum.processing.org/topic/extract-colors-from-images
ArrayList getImgColors( PImage img ) 
{
  ArrayList alColors = new ArrayList();
  
  img.loadPixels();
  
  int color1, color2;
  // TODO: what's a good way to pull DISTINCT colors with a color[]?
  for( int c = 0; c < img.pixels.length; c++ ) 
  {
      if( alColors.size() == 0 ) { 
        alColors.add( (color)img.pixels[ c ] );
      } else 
      {
         
        if( ! alColors.contains( (color)img.pixels[ c ] ) ) 
        {
          color1 = (Integer) alColors.get( alColors.size()-1 );
          color2 = img.pixels[c];
          // filter out colors    
//          if( color2 > color1 )
//          if( color2 < color1 )
//          {
        
            alColors.add( (color)img.pixels[ c ] );
        
//          }
        }
      }

  }
  
  return alColors;

}


///////////////////////////////////////////////////////////
//  Helper to random(255) stroke
void randFill() {  
  fill( random(255), random(255), random(255), alf );
}
void randStroke() {  
  stroke( random(255), random(255), random(255), alf );
}
void randStroke100() {  
  stroke( random(255), random(255), random(255), 100 );
}


void ranPalStroke(ArrayList palette) { stroke( (Integer)palette.get( (int)random( palette.size()-1 ) ), alf ); }
void ranPalStroke100(ArrayList palette) { stroke( (Integer)palette.get( (int)random( palette.size()-1 ) ), 100 ); }
void ranPalStrokeCust(ArrayList palette, float a) { stroke( (Integer)palette.get( (int)random( palette.size()-1 ) ), a ); }

void ranPalFill(color[] palette)
{
  fill( palette[ int(random( palette.length-1 )) ], alf );
}
void ranPalFill(ArrayList palette)
{
  // pallete
  fill( (Integer)palette.get( (int)random( palette.size()-1 ) ), alf );
}
void ranPalFill100(ArrayList palette)
{
  // pallete
  fill( (Integer)palette.get( (int)random( palette.size()-1 ) ), 100 );
}



//////////////////////////////////////////////////////////////////////////
//  Draw manual circle
void circle( float startX, float startY, float w, float h ) {

  float angle = 0;
  float xx, yy;
  noFill();
  
  while ( angle < 360 ) {

    // make circle draw faster by skipping angles
    if( angle % 3 == 0 ) {

    xx = startX - int( cos(radians(angle)) * w );
    yy = startY - int( sin(radians(angle)) * w );


    ellipse( xx, yy, w, h );
    }
    angle++;
  }
}


//////////////////////////////////////////////////////////////////////////
//  Draw manual circle
//  OVERRIDE : @modAngle - restrict drawing to angle % @modAngle
void circle( float startX, float startY, float w, float h, float modAngle ) {

  float angle = 0;
  float xx, yy;

  while ( angle < 360 ) {

    // make circle draw faster by skipping angles
    if( angle % modAngle == 0 ) {

      xx = startX - int( cos(radians(angle)) * w );
      yy = startY - int( sin(radians(angle)) * w );
  
      smooth();
      ellipse( xx, yy, w, h );
    }
    angle++;
  }
}

//////////////////////////////////////////////////////////////////////////
//  HEXAGON inspired by http://www.rdwarf.com/lerickson/hex/index.html
void hexagon( float startX, float startY, float shapeSize ) {

  line( startX, startY+(shapeSize*.5), startX+(shapeSize*.25), startY );
  line( startX+(shapeSize*.25), startY, startX+(shapeSize*.75), startY );
  line( startX+(shapeSize*.75), startY, startX+(shapeSize), startY+(shapeSize*.5) );

  line( startX+(shapeSize), startY+(shapeSize*.5), startX+(shapeSize*.75), startY+shapeSize );
  line( startX+(shapeSize*.75), startY+shapeSize, startX+(shapeSize*.25), startY+shapeSize );
  line( startX+(shapeSize*.25), startY+shapeSize, startX, startY+(shapeSize*.5) );
}
///////////////////////////////////////////////////////////
//
//  e][c stamp
void ec2Stamp( int x, int y ){

//  OCRAStd
//  test stamp
//AmericanTypewriter-Bold
//  RosewoodStd-Regular
// AmericanTypewriter  Monaco  AmericanTypewriter-Bold "Silom"
  smooth();
  
  textFont( createFont( "MesquiteStd", 222 ) );
  fill(0);
  text( "e", x-4, y );//  text( "e", cX-4, cY );
  
  textFont( createFont( "MesquiteStd", 217 ) );
  fill(#EFEFEF);
  text( "e", x-4, y-2 );//  text( "e", cX-4, cY-2 );

  fill(0);
  textFont( createFont( "MesquiteStd", 345 ) );
  text( "]", x+32, y+46 );//text( "]", cX+32, cY+46 );
  text( "[", x+80, y+46 );//text( "[", cX+80, cY+46 );
  
  fill(#EFEFEF);
  textFont( createFont( "MesquiteStd", 340 ) );
  text( "]", x+32, y+44 );//text( "]", cX+32, cY+44 );
  text( "[", x+80, y+44 );//text( "[", cX+80, cY+44 );
  
  fill(0);
  textFont( createFont( "MesquiteStd", 222 ) );
  text( "c", x+127, y );//text( "c", cX+127, cY );
  
  textFont( createFont( "MesquiteStd", 217 ) );
  fill(#EFEFEF);
  text( "c", x+127, y-2 );//text( "c", cX+127, cY-2 );
  
  /*
  fill(#EF2012);
  text( "]", cX-42, cY+7);
  text( "[", cX+42, cY+7);
  
  fill(#010113);
  text( "]", cX-42, cY+7);
  text( "[", cX+42, cY+7);
  
  
 textFont( createFont( "Silom", 200 ) );  //  AppleGothic "Silom"
  
  fill(#EF2012);
  text( "e", cX-88, cY-21);
  text( "c", cX+123, cY-21);
  
  
  fill(#010113);
 
  text( "e", cX-90, cY-21);
  text( "c", cX+123, cY-21);
*/
}

///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{

  //  artDaily("The difference between who you are and who you want to be is WHAT YOU DO");
  artDaily("ERICFICKES.COM");

ec2Stamp( cX, cY );


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
//  get timestamp
int getTimestamp() {
  return month()+day()+year()+hour()+minute()+second()+millis();
}

/////////////
//  TODO: Is there a better way to get the current sketch name?
String pdeName() {
  return split( this.toString(), "[")[0];
}


///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont(createFont("Silom",11));
  smooth();
  
  ranPalFill( p3 );
  text( " "+dailyMsg, width-222, this.height-10);
  
  ranPalFill( p3 );
  text( " "+dailyMsg, width-222, this.height-9);
  
  fill(#EFEFEF);
  text( " "+dailyMsg, width-222, this.height-8);
}

