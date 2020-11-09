//  SEE:   https://ello.co/ericfickes/post/ni3rxgzrlws-qdn1lvk42a
//  GOTO:  https://github.com/ericfickes/FIXLIB 	
import fixlib.*;

Fixlib fix = Fixlib.init(this);
Boolean isFinal = true;
int alf = 69;
float w = 33;
int sw1 = 2;
int sw2 = 1;

int cX, cY;
float x, y, t;
float angle = 0;
float xx, yy, startX, startY;

PImage img;
ArrayList p3;

String BG_IMG = "b/b1.png";  // 1 - 24

void settings() {
  size(displayWidth, displayHeight, P3D);
  smooth(8);
  pixelDensity(displayDensity());
}

////////////////////////////////////////////////////
//
void setup() {
  frameRate(420);
  background(-1);

  fix.alpha(alf);

  //  setup variables
  cX = width/2;
  cY = height/2;

  startX = cX;
  startY = cY;


  img = loadImage(BG_IMG);

  p3 = getImgColors( img );

  img.filter(GRAY);
  img.filter(INVERT);
  img.filter(THRESHOLD);
  tint(255,alf);
  image(img, 0, 0 );
  noTint();

  xx = yy = -(w/2);
}


////////////////////////////////////////////////////
//
void draw()
{

  drawLissajous( xx, yy, (noise(t)*w), p3 );

  if ( (yy+xx) > (width+height) ) {

    doExit();
  }

  t++;

  if ( xx > width ) {
    xx = -(w/2);
    yy += w;
  } else {
    xx += w;
  }
}


//////////////////////////////////////////////////////
//  
void drawLissajous( float a, float b, float amp, ArrayList clr )
{

  float x, y;

  for ( float t = 0; t <= 720; t += .2)
  {
    x = a - amp * sin( a * t * TWO_PI/90);
    y = b - amp * sin( b * t * TWO_PI/90);

    strokeWeight( sw2 );
    fix.ranPalStroke( clr );
    point(x, y);
    
    strokeWeight( sw2 );
    fix.ranPalStroke100( clr );
    point(y, x);
    
    strokeWeight( HALF_PI );
    stroke(alf,w,(sw1+sw2));
    point(y, x);
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
    } else 
    {

      if ( ! alColors.contains( (color)img.pixels[ c ] ) ) 
      {
        color1 = (Integer) alColors.get( alColors.size()-1 );
        color2 = img.pixels[c];
        // filter out colors    
        if ( color2 > color1 )
        {

          alColors.add( (color)img.pixels[ c ] );
        }
      }
    }
  }

  return alColors;
}




///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{

  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "_" + BG_IMG + "_"+ fix.getTimestamp()+".png" );
  }

  noLoop();
  exit();
}




///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 12 ) );
  smooth();

  fill(#EFEFEF);
  text( " "+dailyMsg, this.width-155, this.height-10);
  /*
float yy = 0;
   while( yy <= height ) {
   
   fill(#EFEFEF, yy*.15);
   text( " "+dailyMsg, 5, yy);
   yy += 18; 
   }
   */
}
