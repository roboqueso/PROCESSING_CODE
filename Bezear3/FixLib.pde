/*
FixLib is your new utility library.  House all your helper code here,
and keep the main sketch.pde as light as possible ( setup, draw, exit, artDaily )
*/
class FixLib {


  FixLib(){}


  ////////////////////////////////////////////////////////////
  //  
  //  Draw an organic ellipse growing outwards like the trunk of a tree
  void trunk(float x, float y ) {
    ellipse( x, y, frameCount, frameCount ); 
  }


  //////////////////////////////////////////////////////
  //  Draw grid of circles that grow as the page builds
  public void circleGrid( int gWidth, int gHeight ) 
  {
    float x = 0,y=0;
    float inc = PI*TWO_PI;  //  INCREMENTOR
    float sz = inc;

    // circle grid
    for( int a = 0; a < (gWidth*gHeight)/2; a+= inc ){
        smooth();

        ellipse( x, y, sz, sz );

        if( x < gWidth ) {
            x += sz;
        } else {
            x = 0;
            y += sz;
            sz += inc;
        }

    }
}

  //////////////////////////////////////////////////////
  //  
  public void drawLissajous( float a, float b, float amp )
  {
    //  float amp = 33;
    float x, y;
    float sz = amp / PI;  //TWO_PI;
  
    for ( float t = 0; t <= 360; t += 1)
    {
      x = a - amp * sin(a * t * PI/180);
      y = b - amp * sin(b * t * PI/180);
      noFill();
      ellipse(x, y, sz, sz);
    }
  }



  //////////////////////////////////////////////////////
  //  Pass in a color, and this will fill even frames with 255,
  //  odd frames with clr
  public void evenOddFill( color clr ) {
    if ( frameCount % 2 == 0 ) {
      fill(255);
    } 
    else {
      fill( clr );
    }
  }
  //////////////////////////////////////////////////////
  //  Pass in a color, and this will fill even frames with 255,
  //  odd frames with clr
  //  * INVERTED for evenOddFill() pleasure
  public void evenOddStroke( color clr, float alf ) {

    if ( frameCount % 2 == 0 ) {
      stroke(clr, alf);
    } 
    else {
      stroke(0, alf);
    }
  }
  
  
  
  /////////////////////////////////////////////////////////////////
  //  spit out an 8bit heart
  public void bitHeart( float x, float y, boolean grid ) {
  
    int blockSize = 25;
    float htSize = 250;
    strokeWeight(.5);
  
    //  GRID
    if (grid) {
      stroke(#EFEFEF);//, 50);
  
      for ( int xx = 0 ; xx <= 13; xx++ ) {
  
        line( x+(blockSize*xx), 0, x+(blockSize*xx), height );
        line( 0, y+(blockSize*xx), width, y+(blockSize*xx) );
      }
    }
    //  GRID
  
  
  
    //  HEART
    stroke(#333333);
  
    //  white blocks
    fill(255);
    rect( x+(blockSize*2), y+blockSize, blockSize, blockSize );
    rect( x+(blockSize), y+(blockSize*2), blockSize, blockSize );
  
    fill(0);
    // TODO: make this smarter
    rect( x+(blockSize*2), y, blockSize, blockSize );
    rect( x+(blockSize*3), y, blockSize, blockSize );
    rect( x+(blockSize*4), y, blockSize, blockSize );
  
    rect( x+(blockSize*8), y, blockSize, blockSize );
    rect( x+(blockSize*9), y, blockSize, blockSize );
    rect( x+(blockSize*10), y, blockSize, blockSize );
  
    rect( x+(blockSize), y+blockSize, blockSize, blockSize );
  
    fill(#EF0000);
    rect( x+(blockSize*3), y+blockSize, blockSize, blockSize );
    rect( x+(blockSize*4), y+blockSize, blockSize, blockSize );
    rect( x+(blockSize*2), y+(blockSize*2), blockSize, blockSize );
    rect( x+(blockSize*3), y+(blockSize*2), blockSize, blockSize );
    rect( x+(blockSize*4), y+(blockSize*2), blockSize, blockSize );
    rect( x+(blockSize*5), y+(blockSize*2), blockSize, blockSize );
    rect( x+(blockSize*7), y+(blockSize*2), blockSize, blockSize );
    rect( x+(blockSize*8), y+(blockSize*2), blockSize, blockSize );
    rect( x+(blockSize*9), y+(blockSize*2), blockSize, blockSize );
    rect( x+(blockSize*10), y+(blockSize*2), blockSize, blockSize );
    rect( x+(blockSize*11), y+(blockSize*2), blockSize, blockSize );
  
    rect( x+(blockSize), y+(blockSize*3), blockSize, blockSize );
    rect( x+(blockSize*2), y+(blockSize*3), blockSize, blockSize );
    rect( x+(blockSize*3), y+(blockSize*3), blockSize, blockSize );
    rect( x+(blockSize*4), y+(blockSize*3), blockSize, blockSize );
    rect( x+(blockSize*5), y+(blockSize*3), blockSize, blockSize );
    rect( x+(blockSize*6), y+(blockSize*3), blockSize, blockSize );
    rect( x+(blockSize*7), y+(blockSize*3), blockSize, blockSize );
    rect( x+(blockSize*8), y+(blockSize*3), blockSize, blockSize );
    rect( x+(blockSize*9), y+(blockSize*3), blockSize, blockSize );
    rect( x+(blockSize*10), y+(blockSize*3), blockSize, blockSize );
    rect( x+(blockSize*11), y+(blockSize*3), blockSize, blockSize );
  
    rect( x+(blockSize), y+(blockSize*4), blockSize, blockSize );
    rect( x+(blockSize*2), y+(blockSize*4), blockSize, blockSize );
    rect( x+(blockSize*3), y+(blockSize*4), blockSize, blockSize );
    rect( x+(blockSize*4), y+(blockSize*4), blockSize, blockSize );
    rect( x+(blockSize*5), y+(blockSize*4), blockSize, blockSize );
    rect( x+(blockSize*6), y+(blockSize*4), blockSize, blockSize );
    rect( x+(blockSize*7), y+(blockSize*4), blockSize, blockSize );
    rect( x+(blockSize*8), y+(blockSize*4), blockSize, blockSize );
    rect( x+(blockSize*9), y+(blockSize*4), blockSize, blockSize );
    rect( x+(blockSize*10), y+(blockSize*4), blockSize, blockSize );
    rect( x+(blockSize*11), y+(blockSize*4), blockSize, blockSize );
  
    rect( x+(blockSize*2), y+(blockSize*5), blockSize, blockSize );
    rect( x+(blockSize*3), y+(blockSize*5), blockSize, blockSize );
    rect( x+(blockSize*4), y+(blockSize*5), blockSize, blockSize );
    rect( x+(blockSize*5), y+(blockSize*5), blockSize, blockSize );
    rect( x+(blockSize*6), y+(blockSize*5), blockSize, blockSize );
    rect( x+(blockSize*7), y+(blockSize*5), blockSize, blockSize );
    rect( x+(blockSize*8), y+(blockSize*5), blockSize, blockSize );
    rect( x+(blockSize*9), y+(blockSize*5), blockSize, blockSize );
    rect( x+(blockSize*10), y+(blockSize*5), blockSize, blockSize );
  
    rect( x+(blockSize*2), y+(blockSize*6), blockSize, blockSize );
    rect( x+(blockSize*3), y+(blockSize*6), blockSize, blockSize );
    rect( x+(blockSize*4), y+(blockSize*6), blockSize, blockSize );
    rect( x+(blockSize*5), y+(blockSize*6), blockSize, blockSize );
    rect( x+(blockSize*6), y+(blockSize*6), blockSize, blockSize );
    rect( x+(blockSize*7), y+(blockSize*6), blockSize, blockSize );
    rect( x+(blockSize*8), y+(blockSize*6), blockSize, blockSize );
    rect( x+(blockSize*9), y+(blockSize*6), blockSize, blockSize );
    rect( x+(blockSize*10), y+(blockSize*6), blockSize, blockSize );
  
    rect( x+(blockSize*3), y+(blockSize*7), blockSize, blockSize );
    rect( x+(blockSize*4), y+(blockSize*7), blockSize, blockSize );
    rect( x+(blockSize*5), y+(blockSize*7), blockSize, blockSize );
    rect( x+(blockSize*6), y+(blockSize*7), blockSize, blockSize );
    rect( x+(blockSize*7), y+(blockSize*7), blockSize, blockSize );
    rect( x+(blockSize*8), y+(blockSize*7), blockSize, blockSize );
    rect( x+(blockSize*9), y+(blockSize*7), blockSize, blockSize );
  
    rect( x+(blockSize*4), y+(blockSize*8), blockSize, blockSize );
    rect( x+(blockSize*5), y+(blockSize*8), blockSize, blockSize );
    rect( x+(blockSize*6), y+(blockSize*8), blockSize, blockSize );
    rect( x+(blockSize*7), y+(blockSize*8), blockSize, blockSize );
    rect( x+(blockSize*8), y+(blockSize*8), blockSize, blockSize );
  
    rect( x+(blockSize*5), y+(blockSize*9), blockSize, blockSize );
    rect( x+(blockSize*6), y+(blockSize*9), blockSize, blockSize );
    rect( x+(blockSize*7), y+(blockSize*9), blockSize, blockSize );
  
    rect( x+(blockSize*6), y+(blockSize*10), blockSize, blockSize );
  
    fill(0);
  
  
  
  
    rect( x+(blockSize*5), y+blockSize, blockSize, blockSize );
    rect( x+(blockSize*6), y+(blockSize*2), blockSize, blockSize );
    rect( x+(blockSize*7), y+(blockSize), blockSize, blockSize );
  
  
    fill(#EF0000);  
    rect( x+(blockSize*4), y+blockSize, blockSize, blockSize );
    rect( x+(blockSize*8), y+blockSize, blockSize, blockSize );
    rect( x+(blockSize*9), y+blockSize, blockSize, blockSize );
    rect( x+(blockSize*10), y+blockSize, blockSize, blockSize );
    rect( x+blockSize, y+(blockSize*5), blockSize, blockSize );
    rect( x+(blockSize*2), y+(blockSize*7), blockSize, blockSize );
    rect( x+(blockSize*3), y+(blockSize*8), blockSize, blockSize );
    rect( x+(blockSize*4), y+(blockSize*9), blockSize, blockSize );
    rect( x+(blockSize*5), y+(blockSize*10), blockSize, blockSize );  
    rect( x+(blockSize*6), y+(blockSize*11), blockSize, blockSize );
    rect( x+(blockSize*7), y+(blockSize*10), blockSize, blockSize );
    rect( x+(blockSize*8), y+(blockSize*9), blockSize, blockSize );
    rect( x+(blockSize*9), y+(blockSize*8), blockSize, blockSize );
    rect( x+(blockSize*10), y+(blockSize*7), blockSize, blockSize );
    rect( x+(blockSize*11), y+(blockSize*5), blockSize, blockSize );
  
    fill(0);
    rect( x+(blockSize*11), y+blockSize, blockSize, blockSize );
    rect( x, y+(blockSize*2), blockSize, blockSize );
    rect( x, y+(blockSize*3), blockSize, blockSize );
    rect( x, y+(blockSize*4), blockSize, blockSize );
    rect( x, y+(blockSize*5), blockSize, blockSize );
    rect( x+blockSize, y+(blockSize*6), blockSize, blockSize );
    rect( x+blockSize, y+(blockSize*7), blockSize, blockSize );
    rect( x+(blockSize*2), y+(blockSize*8), blockSize, blockSize );
    rect( x+(blockSize*3), y+(blockSize*9), blockSize, blockSize );
    rect( x+(blockSize*4), y+(blockSize*10), blockSize, blockSize );
    rect( x+(blockSize*5), y+(blockSize*11), blockSize, blockSize );
    rect( x+(blockSize*6), y+(blockSize*12), blockSize, blockSize );
    rect( x+(blockSize*7), y+(blockSize*11), blockSize, blockSize );
    rect( x+(blockSize*8), y+(blockSize*10), blockSize, blockSize );
    rect( x+(blockSize*9), y+(blockSize*9), blockSize, blockSize );
    rect( x+(blockSize*10), y+(blockSize*8), blockSize, blockSize );
    rect( x+(blockSize*11), y+(blockSize*7), blockSize, blockSize );
    rect( x+(blockSize*11), y+(blockSize*6), blockSize, blockSize );
  
    rect( x+(blockSize*12), y+(blockSize*5), blockSize, blockSize );
    rect( x+(blockSize*12), y+(blockSize*4), blockSize, blockSize );
    rect( x+(blockSize*12), y+(blockSize*3), blockSize, blockSize );
    rect( x+(blockSize*12), y+(blockSize*2), blockSize, blockSize );
  }
  
  


  
  ///////////////////////////////////////////////////////////
  //  draw a star
  public void star(int n, float cx, float cy, float w, float h, float startAngle, float proportion)
  {
    if (n > 2)
    {
      float angle = TWO_PI/ (2 *n);  // twice as many sides
      float dw; // draw width
      float dh; // draw height
  
      w = w / 2.0;
      h = h / 2.0;
  
      beginShape();
      for (int i = 0; i < 2 * n; i++)
      {
        dw = w;
        dh = h;
        if (i % 2 == 1) // for odd vertices, use short radius
        {
          dw = w * proportion;
          dh = h * proportion;
        }
        vertex(cx + dw * cos(startAngle + angle * i), 
        cy + dh * sin(startAngle + angle * i));
      }
      endShape(CLOSE);
    }
  }
  
  
  
  
  
  //////////////////////////
  int f0 = 0;
  int f1 = 1;
  //int f2 = 1;
  
  public int nextFib( int f2)
  {
    int result = f2;
    f0 = f1;
    f1 = f2;
    f2 = f0 + f1;
    return result;
  }
  
  //////////////////////////
  //  Calculate max loop count
  public float getMax( float shapeSize ) {
    return ( ( width * height ) / shapeSize );
  }
  
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //  pull colors out of image and return color[]
  //  http://forum.processing.org/topic/extract-colors-from-images
  public ArrayList getImgColors( PImage img ) 
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
          // play with < and > depending on image
//          if ( color1 < color2 )
          if ( color1 > color2 )
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
  public void paletteGrid( ArrayList pall ) {
  
    float xx = 0;
    float yy = 0;  
    float sz = 30;
  
    // debug
    //text( pall.size() + " colors ", sz, sz );
    color tmp;
    for ( int cc = 0; cc < pall.size(); cc++ ) {
  
      noStroke();
      tmp = (Integer)pall.get(cc);
      fill( tmp, alf*4 );
      rect( xx, yy, sz, sz );
  
      if ( xx < width ) {
        xx += (sz *1.25);
      } 
      else {
        xx = 0;
        yy += (sz *1.25);
      }
    }
  
  
  
  
    textFont( createFont( "HiraMaruProN-W4", 222 ) );
    fill(random(alf));
    text( pall.size(), random( alf, width/3 ), random(height) );
  }
  
  
  
  
///////////////////////////////////////////////////////
//  Make grid of shapes filled with each color in supplied
//  color[], fills entire screen
public void paletteGridFull( ArrayList pall ) {
    
  float xx = 0;
  float yy = 0;  
  float sz = 30;
  float startX;  //  the X where the previous loop left off
  float startY;  //  the Y where the previous loop left off
  color tmp;
  int clridx = 0;  // use this index to walk through the supllied ArrayList of colors

  for( int gg = 0; gg < (height+width)/2; gg++ ) {


    noStroke();
    tmp = (Integer)pall.get(clridx);
    fill( tmp, alf*3 );

    rect( xx, yy, sz, sz );
    
    if( xx < width ) {
      xx += (sz *1.25);
    } else {
      xx = 0;
      yy += (sz *1.25);
    }
    
    //  make sure the color index doesn't get larger than the array
    if( clridx == pall.size()-1 )
      clridx = 0;
    else
      clridx++;

  }

}

  
  
  
  //////////////////////////////////////////////////////////////////////////
  //  Draw manual circle
  //  ellipse(x, y, width, height)
  public void circle( float startX, float startY, float w, float h ) {
  
    float angle = 0;
    float x, y;
  
    while ( angle < 360 ) {
  
      // make circle draw faster by skipping angles
      if ( angle % 10 == 0 ) {
  
        x = startX - int( cos(radians(angle)) * w );
        y = startY - int( sin(radians(angle)) * w );
  
        smooth();
        ellipse( x, y, w, h );
      }
      angle++;
    }
  }
  
  ///////////////////////////////////////////////////////////////////////////
  //  draw a circle of circles
  public void circle( float startX, float startY, float w, float h, float modAngle ) {
  
    float angle = 0;
    float x, y;
  
    while ( angle < 360 ) {
  
      // make circle draw faster by skipping angles
      if ( angle % modAngle == 0 ) {
  
        x = startX - int( cos(radians(angle)) * w );
        y = startY - int( sin(radians(angle)) * w );
  
        smooth();
        ellipse( x, y, w, h );
      }
      angle++;
    }
  }
  
  //////////////////////////////////////////////////////////////////////////
  //  HEXAGON inspired by http://www.rdwarf.com/lerickson/hex/index.html
  public void hexagon( float startX, float startY, float shapeSize ) {
  
    line( startX, startY+(shapeSize*.5), startX+(shapeSize*.25), startY );
    line( startX+(shapeSize*.25), startY, startX+(shapeSize*.75), startY );
    line( startX+(shapeSize*.75), startY, startX+(shapeSize), startY+(shapeSize*.5) );
  
    line( startX+(shapeSize), startY+(shapeSize*.5), startX+(shapeSize*.75), startY+shapeSize );
    line( startX+(shapeSize*.75), startY+shapeSize, startX+(shapeSize*.25), startY+shapeSize );
    line( startX+(shapeSize*.25), startY+shapeSize, startX, startY+(shapeSize*.5) );
  }
  
  ////////////////////////////////////////////////////
  //  Return a random color from supplied palette
  public color getRanColor(ArrayList palette)
  {
    return (Integer)palette.get( (int)random( palette.size()-1 ) );
  }
  
  
  ////////////////////////////////////////////////////
  //  Randomly stroke using image from color list
  public void ranPalStroke(color[] palette)
  {
    // pallete
    stroke( palette[ int(random( palette.length-1 )) ], alf );
  }
  public void ranPalStroke(ArrayList palette)
  {
    // pallete
    stroke( (Integer)palette.get( (int)random( palette.size()-1 ) ), alf );
  }
  public void ranPalStroke100(color[] palette)
  {
    // pallete
    stroke( palette[ int(random( palette.length-1 )) ], 100 );
  }
  public void ranPalStroke100(ArrayList palette)
  {
    // pallete
    stroke( (Integer)palette.get( (int)random( palette.size()-1 ) ), 100 );
  }
  public void ranPalFill(color[] palette)
  {
    fill( palette[ int(random( palette.length-1 )) ], alf );
  }
  public void ranPalFill(ArrayList palette)
  {
    // pallete
    fill( (Integer)palette.get( (int)random( palette.size()-1 ) ), alf );
  }
  public void ranPalFill100(color[] palette)
  {
    // pallete
    fill( palette[ int(random( palette.length-1 )) ], 100 );
  }
  public void ranPalFill100(ArrayList palette)
  {
    // pallete
    fill( (Integer)palette.get( (int)random( palette.size()-1 ) ), 100 );
  }
  
  ///////////////////////////////////////////////////////////
  //  Helper to random(255) stroke
  public void randFill() {  
    fill( random(255), random(255), random(255), alf );
  }
  public void randStroke() {  
    stroke( random(255), random(255), random(255), alf );
  }
  public void randStroke100() {  
    stroke( random(255), random(255), random(255), 100 );
  }
  
  ///////////////////////////////////////////////////////////
  public String getTimestamp() {
    return ""+month()+day()+year()+hour()+minute()+millis();
  }
  
  
  //////////////////////////////////////////////////////
  //  Returns the file name that is calling this function ( minus the .pde )
  public String pdeName() {
    return split( this.toString(), "$")[0];
  }



}
