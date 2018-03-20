//  
//  EMERGENT COLLECTIVE TWO
//  
Boolean isFinal = true;
int alf = 13;
float x,y, t;
float angle = 0;
float xx, yy, startX, startY;
float w = 13;


// image
PImage img;
ArrayList p3;

int i = 0, cX, cY, rad = 37; 
Boolean on = false;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size( 1024, 768);
  background(0);
  noFill();
  smooth();
  ellipseMode(CENTER);
  //  setup variables
  cX = floor(width*.42);
  cY = height/2;

  img = loadImage("EmergentCollectiveTwo.png");
  //  MAKE TILED BACKGROUND
  for( int yy = 0; yy <= 768; yy += img.height ){

    for( int xx = 0; xx <= 1024; xx += img.width ){
      image( img, xx, yy );
    }
  }
    

  p3 = getImgColors( img );
    
  // right justify stump
  image(img, (width-672), 0 );
  
   xx = yy = -(w/2); 

}


////////////////////////////////////////////////////
//
void draw()
{
    strokeWeight(1);  
    if( yy < height ) {
      ranPalStroke( p3 );
      drawLissajous( xx, yy, alf/HALF_PI );
    }
    
    if( xx < height ) {
      ranPalStroke( p3 );
      drawLissajous( yy, xx, alf/HALF_PI );
    }

    ranPalStroke( p3 );
    bezier( xx, yy, yy, xx, xx, yy, xx, yy );
    ranPalStroke( p3 );
    bezier( yy, xx, xx, yy, yy, xx, yy, xx );

    strokeWeight(1);  
    ranPalStroke( p3 );
    curve( xx, yy, rad, frameCount, alf, frameCount, yy, xx );
    curve( yy, xx, rad, frameCount, alf, frameCount, xx, yy );

    strokeWeight(HALF_PI);  
    ranPalStroke( p3 );
    systems( yy, xx );

    systems( rad, frameCount );
    systems( frameCount, rad );
    
    strokeWeight( random(TWO_PI) );
    ranPalStroke( p3 );
    systems( xx, yy );
    
    strokeWeight(QUARTER_PI);
    ranPalStroke( p3 );
    systems( xx, yy ); 
    systems( yy, xx );
    systems( rad, frameCount );
    systems( frameCount, rad );
    
  //  circles
  
 if( frameCount % alf == 0){
        on = !on;
    }
 
    //  bring the noise
    
    if(on){
        x = floor( cX+cos(radians(frameCount))*rad );
        y = floor( cY+sin(radians(frameCount))*rad )+noise(frameCount)+noise(rad);
 
    } else {
        x = floor( cX+cos(radians(frameCount))*rad );
        y = floor( cY+sin(radians(frameCount))*rad );
    }

    ranPalStroke(p3);
    strokeWeight(random(11));
    point( x, y );
    point( y, x );

    strokeWeight(random(TWO_PI));
    
    ranPalStroke(p3);
    systems( x+rad, y+rad );//, rad, rad );
    ranPalStroke(p3);
    systems( y-rad, x-rad);//, rad, rad );


 
    if( frameCount % 360 == 0){
        rad += 42;
        on = !on;
    }
  
  //  circles


  
  t++;

  if( xx > width ) {
    xx = -(w/2);
    yy += w;
  } else {
    xx += w; 
  }



  if( yy > width ) {
    exit();
  }

}

///////////////////////////////////////////////////////////////////
//    Create a SWITCH based drawing system that accepts X, Y, and
//    randomly choose which movement system to fire
void systems( float x, float y )
{
    int pick = floor(random(0,3));
 
 fill(random(21,37),75);
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
          if( color2 > color1 )
//          if( color2 < color1 )
          {
        
            alColors.add( (color)img.pixels[ c ] );
        
          }
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

////////////////////////////////////////////////////
//  Randomly stroke using image from color list
void ranPalStroke(color[] palette)
{
  // pallete
  stroke( palette[ int(random( palette.length-1 )) ], alf );
}
void ranPalStroke(ArrayList palette)
{
  // pallete
  stroke( (Integer)palette.get( (int)random( palette.size()-1 ) ), alf );
}
void ranPalStroke100(color[] palette)
{
  // pallete
  stroke( palette[ int(random( palette.length-1 )) ], 100 );
}

void ranPalFill(color[] palette)
{
  fill( palette[ int(random( palette.length-1 )) ], alf );
}
void ranPalFill(ArrayList palette)
{
  // pallete
  fill( (Integer)palette.get( (int)random( palette.size()-1 ) ), alf );
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
//  End handler, saves png to ../OUTPUT
void doExit() 
{

//  artDaily("The difference between who you are and who you want to be is WHAT YOU DO");
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
//  get timestamp
int getTimestamp() {
  return month()+day()+year()+hour()+minute()+second()+millis();
}

/////////////
//  TODO: Is there a better way to get the current sketch name?
String pdeName() {
  return split( this.toString(), "[")[0];
}

//////////////////////////
int f0 = 0;
int f1 = 1;
//int f2 = 1;

int nextFib( int f2)
{
  //   int result = f2;
  f0 = f1;
  f1 = f2;
  f2 = f0 + f1;

  return f0 + f1;
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont( createFont( "StencilStd", 21 ) );
  smooth();
  
  fill(#370000);
  text( " "+dailyMsg, width-222, this.height-10);
  
  fill(0);
  text( " "+dailyMsg, width-222, this.height-9);
  
  fill(#110000);
  text( " "+dailyMsg, width-222, this.height-8);
  
  
  textFont( createFont( "StencilStd", 200 ) );
  smooth();
  
  fill(#EFEFEF);
  text( "#EMCO2", cX, cY);
  
  fill(#660000);
  text( "#EMCO2", cX+PI, cY+PI);

}

