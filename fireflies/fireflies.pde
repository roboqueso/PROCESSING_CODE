// https://github.com/ericfickes/FIXLIB	
import fixlib.*;

Fixlib fix = Fixlib.init(this);
Boolean isFinal = true;
int alf = 42;

int cX;
int cY;

color[] palette = { #EF0000, #00EF00, #0000EF, #CECE00, #FA7680, #EF1975, #007007, #EFEF00, #FA9187, #007007, #109109 };

float a, b, amp, x, y, r, g;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768, P3D);
  background(9);

  //  setup variables
  cX = width/2;
  cY = height/2;

//    background(#EFEFEF);
 
    smooth();
    noFill();
 
    cX = width/2;
    cY = height/2;
 
    smooth();
    
//    strokeWeight(.5);

/*
  // scan lines
  stroke(#c1c1c1, alf ); // 255
  for ( int ll = 0; ll <= width; ll += 2 ) 
  {  
    strokeWeight( random(1.1) );

    line( 0, ll, random(width), ll );
    line( ll, 0, ll, random(height) );
  }
*/

}


////////////////////////////////////////////////////
//
void draw() {
 

    //  for(int i = 0; i < width*height; i++) {
    
    //  }
    
     
    a = cX + random(amp) * (180/PI);
    b = cY + random(amp) * (180/PI);

loadPixels();     
    for( int t = 0; t <= 360; t += 6 ) 
    {
    
    stroke( #EF0000, alf );
    strokeWeight( random( .5, 1.5 ) );

    r = red(  pixels[ t] ) * ( amp / frameCount );
    g = green(  pixels[t] ) * ( amp / frameCount );
    b = blue(  pixels[t] ) * ( amp / frameCount );
    
    pixels[t] = color(r, g, b);

    x = cX - amp * sin(a * t * PI/180);
    y = cY - amp * sin(b * t * PI/180);
     
    point( x, y );
    point( y, x );
    
    x = ( cX - int( cos(radians(frameCount/alf)) * amp ) );
    y = ( cY - int( sin(radians(frameCount/alf)) * amp ) );
     
    point( x, y );
    point( y, x );
    
    stroke( #800813, alf );
    //  ------------    
    try {
      line( x, y, y, x );
    } finally {
      fill( random(222), random(222), random(222), alf);
      text("whatev:"+frameCount, random(width), random(height) ); 
    }
    //  ------------
    
    translate(width/2, height/2);
    rotateY(map(frameCount, 0, width, -PI, PI));
    rotateX(map(frameCount, 0, height, -PI, PI));
    
    stroke(0, 255, 0);
    rotateX(x);
    rotateZ(0);
    rotateY(y-float(t)*1.305);
    
    point(t, t, 0);
    
    
    x = cX - amp * sin(a * t * TWO_PI/180) - ( cX - int( cos(radians(t/amp)) * amp ) );
    y = cY - amp * sin(b * t * TWO_PI/180) - ( cY - int( sin(radians(t/amp)) * amp ) );
     
    stroke( #0D00DE, alf );
    point( x, y );
    point( y, x );
  
  }
  updatePixels();

  
  x -= 0.01;
  y += 0.02;
  
  
   
  if( frameCount % 30 == 0 )
  {
    amp *= 2;
  }
   
   
  if( frameCount > height ) {
 save(fix.pdeName()+fix.getTimestamp()+".png");
    exit();
  }
 
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
void ranPalStroke100(color[] palette)
{
  // pallete
  stroke( palette[ int(random( palette.length-1 )) ], 100 );
}



void ranPalStroke(ArrayList palette)
{
  // pallete
  stroke( (Integer)palette.get( (int)random( palette.size()-1 ) ), alf );
}
void ranPalStroke100(ArrayList palette)
{
  // pallete
  stroke( (Integer)palette.get( (int)random( palette.size()-1 ) ), 100 );
}




void ranPalFill(color[] palette)
{
  fill( palette[ int(random( palette.length-1 )) ], alf );
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
//  End handler, saves png
void doExit() 
{

  artDaily("ERICFICKES.COM");
save(fix.pdeName()+fix.getTimestamp()+".png");
  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  }

  noLoop();
  exit();
}

///////////////////////////////////////////////////////////
String getTimestamp() {
  return ""+month()+day()+year()+hour()+minute()+millis();
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

  // textFont( createFont( "Silom", 18 ) );
  smooth();

  fill(#2012EF);
  text( " "+dailyMsg, this.width-430, this.height-14);
/*
float yy = 0;
while( yy <= height ) {

  fill(#EFEFEF, yy*.15);
 text( " "+dailyMsg, 5, yy);
 yy += 18; 
}
*/

}

