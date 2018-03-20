//
//  Rotate the circles so the crown looking opening points up



Boolean isFinal = true;
int alf = 11;
float ii = 0;

float cX, cY;

float shapeSize = 10;
float ct, maxCt;
Boolean flip = true;

color[] p2 = { 
  #8B5F1A, #CBA53A, #3F230E, #FBDC8B, #A4A590, #E96303, #86724A, #B1CEA0, #D4D6CE, #FEF3C1, #CCBF8E, #F62200, #882E02, #B1D6D3, #858B64, #D4F0D5, #80B1C2, #B1BABB, #FBDCC4, #D6F1F1, #5D6260, #D48421, #D7DDEE, #CDBABF, #8D827F, #F0DDEE, #A14232, #EFEEEA, #FFFFE8, #ECFFEC, #EEFFFF, #FFFFFF, 
  #6e5c5f, #684f53, #765c5e, #988586, #887475, #c6aeaf, #977c7d, #937475, #fefdfd, #fbf8f8, #6e5a5a, #9e8787, #766e6e, #8a8181, #867777, #847c7c, #705857, #6a5251, #7c6867, #907c7b, #bda2a0, #ae9593, #8d7775, #79605d, #dfcfcd, #f4edec, #6f6867, #b29692, #987772, #8e7470, #8e6c65, #af958f, #8a6c65, #ceb6b0, #887c79, #5a5655, #9c7970, #9f7e74, #816b64, #544641, #755c52, #8e6e5f, #605a57, #89827d, #7f766f, #a49a91, #55504b, #685f56, 
  #78726a, #625d55, #7b7568, #78766e, #716e5f, #416e24, #365a28, #c9d950, #4c6c30, #659443, #729741, #698338, #587e3a, #385529, #5b7f3b, #89b552, #87a347, #4c7036, #5b7436, #446735, #689048, #87a24c, #56763b, #688c46, #849948, #84ab55, #70964c, #638c49, #8a9b49, #5b733a, #5f7f42, #82a756, #759750, #7e924a, #476639, #8e9e50, #425e35, #405a33, #92b362, #b3cd6f, #4b653a, #c0d472, #819b57, #4f6d40, #65854f, #c8d878, #8ca15c, #899c59, #a5be6d, #8aa965, #768c54, #84a464, #7d9a5e, #5a7549, #718753, #5a7449, #a6ca7e, #57754b, #435637, #405336
};

color[] p1 = { 
#000000, #000011, #120000, #200000
};


//  image action
PImage img;
int randColor;
int imgPixCt;

// see: http://docs.oracle.com/javase/1.4.2/docs/api/java/util/ArrayList.html
ArrayList p3;// = new ArrayList();

//PGraphics topLayer;


////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(989, 1280);
  background(255);  //  #ff0000  #EF1975
  
    img = loadImage( "lion-crest.jpg");
    p3 = getImgColors( img );
paletteGrid( p3 );
  
image(img,0,0);
  
  
filter(POSTERIZE, alf );
filter(GRAY);
//filter(BLUR, alf);

  cX = width/2;
  cY = height/2;

  noFill();
  smooth();

  ct = 0;
  maxCt = height;

}



void draw()
{
  strokeWeight( random( 10*alf ) );  //  .25
  ranPalStroke(p2);
  //  vertical
  line( ii, 0, ii, height );

  strokeWeight( 5.25 );
  ranPalStroke(p2);
  //  vertical
//  line( ii, 0, ii, height );
//line( 0, ii, width, ii );


      ranPalStroke(p3);
    strokeWeight( 2 );
  // top
  circle( ii, 0, shapeSize, shapeSize, alf*3 );  
  // bottom
        ranPalStroke(p3);
  circle( ii, height, shapeSize, shapeSize, alf*3 );
  
      ranPalStroke(p3);
  // left
circle( 0, ii, shapeSize, shapeSize, alf );
      ranPalStroke(p3);
  // right
circle( width, ii, shapeSize, shapeSize, alf );



  if( ii >= height ) {
    shapeSize += shapeSize/PI;
    flip = !flip;
  } else if( ii < 0 ) {
    ii = 0;
    flip = !flip; 
  }

//  control the counter ( fwd or bwd )
if(flip) {
 ii += shapeSize; 
} else {
  ii -= shapeSize;
}


  // max count or size is too big
  if( ct > maxCt ) {
    
    paletteGrid( p3 );
    
      exit();
  } else if (shapeSize > width) {
     shapeSize = floor( sqrt( shapeSize ) );
  } else {
     
  }

  // keep track of the loop
  ct++;
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
          if( color2 > ( color1 + 100 ) )
          {
        
            alColors.add( (color)img.pixels[ c ] );
        
          }
        }
      }

  }
  
  return alColors;

}



///////////////////////////////////////////////////////
//  Make grid of shapes filled with each color in supplied
//  color[]
void paletteGrid( color[] pall ) {
    
  float xx = 0;
  float yy = 0;  
  float sz = 30;

// debug
text( pall.length + " colors ", sz, sz );
  
  for( int cc = 0; cc < pall.length; cc++ ) {
    
    noStroke();
    fill( color( pall[cc] ), alf );
    rect( xx, yy, sz, sz );
    
    if( xx < width ) {
      xx += (sz *1.25);
    } else {
      xx = 0;
      yy += (sz *1.25);
    }
  }
}
void paletteGrid( ArrayList pall ) {
    
  float xx = 0;
  float yy = 0;  
  float sz = 30;

// debug
text( pall.size() + " colors ", sz, sz );
  color tmp;
  for( int cc = 0; cc < pall.size(); cc++ ) {
    
    noStroke();
    tmp = (Integer)pall.get(cc);
    fill( tmp, alf*4 );
    rect( xx, yy, sz, sz );
    
    if( xx < width ) {
      xx += (sz *1.25);
    } else {
      xx = 0;
      yy += (sz *1.25);
    }
  }
}


///////////////////////////////////////////////////////
//  Pass a loaded PImage, this will return a color array
color[]  getColorsFromImage( PImage img ) {
// see: http://docs.oracle.com/javase/1.4.2/docs/api/java/util/ArrayList.html
//  HACK: using _colors to make pImg hold only unique colors
//  Unsure how to achieve the same with only a color array
ArrayList _colors = new ArrayList();
color[] color_array = { #EFEFEF };

  img.loadPixels();
  for( int cc = 0; cc < img.pixels.length; cc++)
  {
    if( ! _colors.contains( (color)img.pixels[ cc ] ) )
    {
      //  These values are of the color datatype
      _colors.add( (color)img.pixels[ cc ] );

      if( color_array.length > 0 ) {
        color_array[ color_array.length-1 ] = img.pixels[ cc ];
      }
    }
  }
  return color_array;
}



//////////////////////////
int f0 = 0;
int f1 = 1;
//int f2 = 1;

int nextFib( int f2)
{
  int result = f2;
  f0 = f1;
  f1 = f2;
  f2 = f0 + f1;
  return result;
}

//////////////////////////
//  Calculate max loop count
float getMax( float shapeSize ) {
  return ( ( width * height ) / shapeSize );
}




//////////////////////////////////////////////////////////////////////////
//  Draw manual circle
//  ellipse(x, y, width, height)



void circle( float startX, float startY, float w, float h ) {

  float angle = 0;
  float xx, yy;

  while ( angle < 360 ) {

    // make circle draw faster by skipping angles
    if( angle % 10 == 0 ) {

      xx = startX - int( cos(radians(angle)) * w );
      yy = startY - int( sin(radians(angle)) * w );
  
      smooth();
      ellipse( xx, yy, w, h );
    }
    angle++;
  }
}

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

  artDaily("ERICFICKES.COM" );

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  }

  noLoop();
  exit();
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




String getTimestamp() {
  return ""+month()+day()+year()+hour()+second()+millis();
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

  textFont( createFont( "Silom", 18 ) );
  smooth();

  fill(#EFEFEF);
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

