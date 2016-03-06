Boolean isFinal = true;
int cX, cY, xx=116, yy=116;
// image
PImage img;
ArrayList p3;
int alf = 75;
int fontSz = 666;

void setup() {
  size(1024, 768);
  frameRate(303);
  background(0);//#EF2012);

  frameRate(666);
  smooth();
  noFill();
  rectMode(CENTER);


  cX = int( 1024 / 2 );
  cY = int( 768 / 2 );

  img = loadImage("bass-pickups.jpg");  //"emco2.png");

  //  MAKE TILED BACKGROUND
  //  for( int yy = 0; yy <= 768; yy += img.height ){
  //
  //    for( int xx = 0; xx <= 1024; xx += img.width ){
  //      image( img, xx, yy );
  //    }
  //  }

  //  filter(GRAY);    
  //  filter(INVERT);

  p3 = getImgColors( img );

  // reference lines
  //stroke(#EF2012);
  //line(0, cY, 1024, cY );
  //line(cX, 0, cX, 768 );
  //fill(#EF2012);

  //  OCRAStd
  //AmericanTypewriter-Bold
  //  RosewoodStd-Regular
  // AmericanTypewriter  Monaco  AmericanTypewriter-Bold "Silom"
  //textFont( createFont( "OCRAStd", 11 ) );
  //fill(#20EF12);
  //for( int ty=0; ty<768; ty +=textDescent()+textAscent()){
  //  text("@THECOMPILERS#AREGOINGTOROCKTHEPARTY@THECOMPILERS#AREGOINGTOROCKTHEPARTY@THECOMPILERS#AREGOINGTOROCKTHEPARTY@THECOMPILERS#AREGOINGTOROCKTHEPARTY@THECOMPILERS#AREGOINGTOROCKTHEPARTY#2013",0, ty);
  //}
}

void draw() {

  //  fill(frameCount%2==0?0:255);
  //  fill( random( 255 ) );
  //ranPalFillCust( p3, alf);

  textFont( createFont( "MesquiteStd", fontSz ) );

  ranPalFillCust( p3, alf);
  text( "e", xx-16+( 500/fontSz), yy-100 );//  text( "e", cX-4, cY );

  textFont( createFont( "MesquiteStd", fontSz+123 ) );

  ranPalFillCust( p3, alf);
  text( "]", xx+32+( 500/fontSz), yy+46-100 );//text( "]", cX+32, cY+46 );
  ranPalFillCust( p3, alf);
  text( "[", xx+92+( 500/fontSz), yy+46-100 );//text( "[", cX+80, cY+46 );

  textFont( createFont( "MesquiteStd", fontSz ) );

  ranPalFillCust( p3, alf);
  text( "c", xx+145+( 500/fontSz), yy-100 );//text( "c", cX+127, cY );



  //  STOPPER
  if ( fontSz < 210 ) {

    ranPalStroke( p3 );
    rect( 111, 111, 42, 41, frameCount);
    if (isFinal)
    {
      save(this+".png");
    }

    exit();
  }

  //  create grid
  if ( xx <= 1024 ) {
    xx += 232;
  } 
  else {
    xx = (frameCount%2==0)?0 : 116;
    yy += textDescent();
  }

  //  safety check
  if ( xx >= 1024 && yy >= 768  ) {
    xx = yy = (frameCount%2==0)?0 : 116;
    fontSz -= 42;
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
  for ( int c = 0; c < img.pixels.length; c++ ) 
  {
    if ( alColors.size() == 0 ) { 
      alColors.add( (color)img.pixels[ c ] );
    } 
    else 
    {

      if ( ! alColors.contains( (color)img.pixels[ c ] ) ) 
      {
        color1 = (Integer) alColors.get( alColors.size()-1 );
        color2 = img.pixels[c];
        // filter out colors    
        //          if( color2 > color1 )
        if ( color2 < color1 )
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


void ranPalStroke(ArrayList palette) { 
  stroke( (Integer)palette.get( (int)random( palette.size()-1 ) ), alf );
}
void ranPalStroke100(ArrayList palette) { 
  stroke( (Integer)palette.get( (int)random( palette.size()-1 ) ), 100 );
}
void ranPalStrokeCust(ArrayList palette, float a) { 
  stroke( (Integer)palette.get( (int)random( palette.size()-1 ) ), a );
}

void ranPalFill(ArrayList palette) { 
  fill( (Integer)palette.get( (int)random( palette.size()-1 ) ), alf );
}
void ranPalFill100(ArrayList palette) { 
  fill( (Integer)palette.get( (int)random( palette.size()-1 ) ), 100 );
}
void ranPalFillCust(ArrayList palette, float a) { 
  fill( (Integer)palette.get( (int)random( palette.size()-1 ) ), a );
}



//////////////////////////////////////////////////////////////////////////
//  Draw manual circle
void circle( float startX, float startY, float w, float h ) {

  float angle = 0;
  float xx, yy;
  noFill();

  while ( angle < 360 ) {

    // make circle draw faster by skipping angles
    if ( angle % 3 == 0 ) {

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
    if ( angle % modAngle == 0 ) {

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
void ec2Stamp( int x, int y ) {

  //  OCRAStd
  //  test stamp
  //AmericanTypewriter-Bold
  //  RosewoodStd-Regular
  // AmericanTypewriter  Monaco  AmericanTypewriter-Bold "Silom"
  smooth();

  textFont( createFont( "MesquiteStd", 123 ) );

  fill(11);
  text( "EMERGENT COLLECTIVE 2", 42, y );//  text( "e", cX-4, cY );

  fill(#EFEFEF);
  text( "EMERGENT COLLECTIVE 2", 42, y-4 );//  text( "e", cX-4, cY );


  //  textFont( createFont( "MesquiteStd", 222 ) );
  //  fill(11);
  //  text( "e", x-4, y );//  text( "e", cX-4, cY );

  //  textFont( createFont( "MesquiteStd", 217 ) );
  //  
  //  fill(#EF2012);
  //  text( "e", x-4, y-4 );//  text( "e", cX-4, cY-2 );
  //
  //  fill(11);
  //  textFont( createFont( "MesquiteStd", 345 ) );
  //  text( "]", x+32, y+48 );//text( "]", cX+32, cY+46 );
  //  text( "[", x+80, y+48 );//text( "[", cX+80, cY+46 );
  //  
  //  fill(#EF2012);
  //  textFont( createFont( "MesquiteStd", 340 ) );
  //  text( "]", x+32, y+48 );//text( "]", cX+32, cY+44 );
  //  text( "[", x+80, y+48 );//text( "[", cX+80, cY+44 );
  //  
  //  fill(11);
  //  textFont( createFont( "MesquiteStd", 222 ) );
  //  text( "c", x+127, y );//text( "c", cX+127, cY );
  //  
  //  textFont( createFont( "MesquiteStd", 217 ) );
  //  fill(#EF2012);
  //  text( "c", x+127, y-4 );//text( "c", cX+127, cY-2 );
}

///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void exit() 
{

  //  artDaily("The difference between who you are and who you want to be is WHAT YOU DO");
  artDaily("ERICFICKES.COM");

  ec2Stamp( cX, cY );


  //  if final, save output to png
  if ( isFinal )
  {
    save( pdeName() + "-" + getTimestamp()+".png" );
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

  textFont(createFont("Silom", 18));
  smooth();

  ranPalFill( p3 );
  text( " "+dailyMsg, width-222, this.height-10);

  ranPalFill( p3 );
  text( " "+dailyMsg, width-222, this.height-9);

  fill(#EFEFEF);
  text( " "+dailyMsg, width-222, this.height-8);
}

