//  Prozac color theme
//
Boolean isFinal = true;
int alf = 42;
int cX;
int cY;

//color[] p1 = {  #524a52, #645c64, #6e656e, #988d98, #938b93, #918a91, #938793, #887f88, #978e96, #5e555d, #7a7279, #7c6f7a, #6e686d, #685d66, #867c84, #92848f, #8b8289, #756872, #3e363c, #6a6268, #8b8088, #4e434b, #867b83, #756771, #645a61, #786e75, #978a93, #8b7f87, #564d53, #665d63, #7b7077, #756a71, #6d6369, #6e676b, #4f444a, #42383d, #655b60, #61545a, #a39199, #5e5559, #94888d, #706266, #73676a, #78676b, #685559, #9f858a, #908587, #a3868b, #6e5c5f, #684f53, #765c5e, #988586, #887475, #c6aeaf, #977c7d, #937475, #fefdfd, #fbf8f8, #6e5a5a, #9e8787, #766e6e, #8a8181, #867777, #847c7c, #705857, #6a5251, #7c6867, #907c7b, #bda2a0, #ae9593, #8d7775, #79605d, #dfcfcd, #f4edec, #6f6867, #b29692, #987772, #8e7470, #8e6c65, #af958f, #8a6c65, #ceb6b0, #887c79, #5a5655, #9c7970, #9f7e74, #816b64, #544641, #755c52, #8e6e5f, #605a57, #89827d, #7f766f, #a49a91, #55504b, #685f56, #78726a, #625d55, #7b7568, #78766e, #716e5f, #416e24, #365a28, #c9d950, #4c6c30, #659443, #729741, #698338, #587e3a, #385529, #5b7f3b, #89b552, #87a347, #4c7036, #5b7436, #446735, #689048, #87a24c, #56763b, #688c46, #849948, #84ab55, #70964c, #638c49, #8a9b49, #5b733a, #5f7f42, #82a756, #759750, #7e924a, #476639, #8e9e50, #425e35, #405a33, #92b362, #b3cd6f, #4b653a, #c0d472, #819b57, #4f6d40, #65854f, #c8d878, #8ca15c, #899c59, #a5be6d, #8aa965, #768c54, #84a464, #7d9a5e, #5a7549, #718753, #5a7449, #a6ca7e, #57754b, #435637, #405336, #8ca66b, #707a4d, #526542, #95a76b, #3f4a30, #a8bb78, #89ae74, #6c8c5e, #31422d, #96b176, #6f895d, #2b3b29, #87a06c, #7d9466, #8aa673, #8baf7b, #75855d, #849d70, #555f43, #8b9e71, #46543d, #5c694d, #5a6e52, #95ae81, #879f77, #748463, #7b9271, #718468, #606450, #91a082, #5c604e, #40483b, #505647, #545c4d, #2d2831, #514f5e, #797d6b, #5e5869, #656a5b, #4e4f44, #6d6e5f, #736b7e, #879582, #545360, #53515d, #707a6c, #706d7d, #504853, #888093, #a8b19d, #443d46, #585460, #786e7e, #484852, #51525c, #716775, #7c707f, #7a7281, #979787, #504f59, #625d69, #6b6471, #939c8c, #5b6359, #645c68, #625e6a, #7b7280, #474149, #46424a, #59525c, #837f8e, #655c67, #938797, #706773, #615963, #85808e, #6b6671, #706772, #787480, #636960, #616a65, #746f7a, #a396a5, #625b64, #817e8a, #6d7067, #8c818d, #7a7781, #beb6c5, #827c86, #5d575e, #96909b, #8d848e, #676168, #86838c, #99959f, #6a656b, #d7d4de, #7c7b80, #4e4d4f  };

color[] p1 = {
  #272327, #494849, #7c747b, #544d53, #2e292d, #8b868a, #665962, #2e2b2d, #1c191b, #1e1b1d, #383236, #a9a6a8, #a49ca1, #6d686b, #453e42, #747072, #211d1f, #4e4c4d, #92878c, #8c8387, #685c61, #7f7378, #252022, #312e2f, #32292c, #90878a, #241d1f, #76686c, #322a2c, #605a5b, #282021, #2d2425, #362b2c, #1e1818, #4a4646, #afafaf, #949191, #8a8787, #736968, #261c1b, #413837, #221918, #4b3e3c, #d0b6b2, #231d1c, #4c403e, #4a413f, #271e1c, #241c1a, #b69f99, #e4e1e0, #ccc1bd, #968983, #c5afa3, #e3cdc1, #d3ccc8, #534b46, #ad9586, #b8b0ab, #dbd8d6, #aeaaa7, #a39b94, #cfbcaa, #d4d2d0, #2c2a28, #d1cfcd, #b3b2b1, #cac4be, #b0adaa, #beb1a1, #98948f, #c2b5a3, #756b5c, #b4afa7, #cbc3b6, #d1c6b2, #bbaf98, #5a5854, #a4a098, #ccc1ab, #b6ad99, #d1cec7, #5a5853, #747066, #e7e4dc, #908c81, #cfc8b3, #b9b4a3, #bcb393, #807c6d, #ece4c5, #4e4b3f, #8f8c80, #6c6857, #a4a299, #514f46, #aea990, #e3dfcb, #a5a18b, #605c45, #918d73, #b5b18f, #b7b49a, #635f3c, #6b6957, #e7e2b4, #bebb9d, #a5a06e, #403f35, #cac7a8, #4b4931, #504e33, #b6b5a5, #e2e1d0, #686756, #a5a491, #c2c1ac, #a6a58f, #949377, #777643, #b8b782, #8ba339, #768831, #54602c, #444d25, #929e4e, #8a9248, #747f40, #778141, #737840, #6c6c3b, #8b8f52, #a1a365, #676740, #465034, #6e7047, #c1c280, #969a68, #4a4e37, #545a40, #8f966e, #727859, #6e7356, #76795d, #6f785d, #d8daa9, #4f5668, #74755d, #14151a, #2d2d24, #3a3e32, #747760, #16161c, #474e5a, #494e5b, #30343b, #4f4f42, #2c2c35, #2d2c35, #2e2e27, #434350, #322e37, #e6ebc9, #212026, #373741, #6c7280, #54564a, #222228, #36343d, #50555e, #19181c, #7a7b6b, #26242a, #1a181c, #5d636c, #25282b, #37343c, #302e35, #4b4a55, #6d707d, #cbccb4, #7d828f, #1e1c20, #35343b, #17171a, #5f616b, #606359, #858494, #3d3940, #a499ab, #1c1a1d, #2f2b30, #54545d, #4c5054, #897f8c, #47494e, #bebfaf, #373439, #908b98, #4d4c53, #6e6d77, #98a4a6, #736f79, #464349, #252326, #53534d, #a8a89c, #323336, #9b96a2, #b6afbd, #84808a, #85828c, #7b7b84, #474348, #8d8f86, #7c8179, #77727a, #79727a, #7d7981, #827e86, #a5a5af, #98929b, #212223, #c8cbd4, #dae0d4, #6b6b71, #373639, #5d5b60, #746f75, #2a2a28, #9c9da4, #75777b, #acafa7, #69666b, #7f7b81, #555256, #2d2e2c, #b5b7af, #323230, #d4dbdd, #313133, #bbb7be, #555855, #979499, #5d5c5f, #626465, #e5e5df, #a2a29e, #bebbbf, #888789, #f2f2ef, #525353, #636464, #f2f3f1, #e6e6e5
};
PImage img, img2;
ArrayList p3;
float a, b, amp = 3, x, y, r, g;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);//);
  background(9);
  frameRate(303);
  //  setup variables
  smooth();
  noFill();

  cX = width/2;
  cY = height/2;

//  load the crime photo
//  img = loadImage("weegee_murder7.png");
//  image( img, cX-36, cY-333 );
//  filter(POSTERIZE,alf/2);
//  filter(BLUR);

  // get colors from image
  img = loadImage( "fluoxetine.jpg");
  p3 = getImgColors( img );

  alf /= 4;
  paletteGrid(p3);
  alf *= 4;


  // scan lines
  stroke(#DEFDEF, alf); // #e1fe1f
  strokeWeight( .9 );
  for ( int ll = 0; ll <= width; ll += 2 ) 
  {
    ranPalStroke(p3);

    line( 0, ll, random(width), ll );
    line( ll, 0, ll, random(height) );
  }
  
  
    textFont(createFont("Helvetica", 88));
    
    
  //  ATRRIBUTE THE PHOTOS
  //  Weegee: Murder Is My Business | January 20–September 2, 2012
  //  Weegee, At an East Side Murder, 1943. © Weegee/International Center of Photography.
  //  weegee_murder5.jpg  - 800 x 650
  //  weegee_murder7.jpg  - 900 x 650
  //  http://www.icp.org/museum/exhibitions/weegee-murder-my-business

  //  Load the crime
//  textFont(createFont("American Typewriter", 75));
//  fill(#EFEFEF);//, pow(alf,3) );
//  text("Weegee: Murder Is My Business", alf, height-69 );
//
//  textFont(createFont("American Typewriter", 21));
//  fill(#FF0000);
//  text("http://www.icp.org/museum/exhibitions/weegee-murder-my-business", alf, height-(alf*1.5) );
//  textFont(createFont("American Typewriter", 21));
//  fill(#FFFF00);
//  text("http://www.icp.org/museum/exhibitions/weegee-murder-my-business", alf, height-(alf*1.5) );

  //  Load the kids
//  img2 = loadImage("weegee_murder5.jpg");  
//  tint(#1975EF, 185);
//  image( img2, alf,alf );
}


////////////////////////////////////////////////////
//
void draw() {

  // debug
  //println(frameCount);


  a = 666+cX + amp * (180/TWO_PI) + radians(cX);
  b = 666+cY + amp * (180/TWO_PI) + radians(cY);

  ranPalStroke(p3);
  ranPalFill(p3);

  strokeWeight(alf);
  point( a, b );
  point( b, a );

  strokeWeight(9);
  stroke(#131300, alf*2);//  stroke(#EFEF00, alf*2);
  radialLine( x+420, x, frameCount+420, frameCount );
  
  strokeWeight(  1.5 );
  
  stroke(#EF0000, alf);
  radialLine( y+420, y, frameCount+420, frameCount );




  translate( frameCount, frameCount );
  rotateY(map(frameCount, 0, width, -TWO_PI, TWO_PI));
  rotateX(map(frameCount, 0, height, -TWO_PI, TWO_PI));

  //stroke(90, 255, 0);
  ranPalStroke(p3);
  rotateX(y);
  rotateZ(x-y);
  rotateY(x-float(frameCount)*PI);

  x = 666+cX - amp * sin(a * frameCount * TWO_PI/180);
  y = 666+cY - amp * cos(b * frameCount * TWO_PI/180);

  radialLine( a, b, x, y );
  radialLine( x, y, a, b );


  line( x, y, random(a), random(b) );

  strokeWeight(alf);
  ranPalStroke(p3);
  point( y, x );
  point( x, y );

  x = 666+cX - amp * cos(a * frameCount * TWO_PI/180);
  y = 666+cY - amp * sin(b * frameCount * TWO_PI/180);

  strokeWeight(1);
  line( y, x, random(a), random(b) );

  ranPalStroke(p3);
  line( frameCount, frameCount, x, y );
  point(frameCount, frameCount);

  //  ------------    
  try {
    line( y, x, x, y );
  } 
  catch(Exception e) {
    ranPalFill(p3);
    ranPalStroke(p3);
    textFont(createFont("Helvetica", frameCount));
    text( "WEEGEE", random(width), random(height) );
    println(frameCount +":"+ e.toString());

    line(x, y, amp, amp);
  } 
  finally {

    noFill();
  }
  //  ------------


  //}


  x-= 0.333;
  y+= 0.666;

  if ( x < 0 || x > width ) {
    x = TWO_PI;
  }
  if ( y < 0 || y > height ) {
    y = TWO_PI;
  }  


  if ( frameCount % 18 == 0 )
  {
    amp *= 3.33;

    ranPalStroke100(p3);
    hexagon( x, y, amp );

    //  make safe
    if ( amp > width ) {
      amp = TWO_PI;
    }
  }


  if ( frameCount >= height+width ) {

    doExit();
  }

}


////////
//void radialLine(double r1, double a1, double r2, double a2){
void radialLine(float r1, float a1, float r2, float a2) {
  float x1 = width/2  + cos(a1)*r1;
  float y1 = height/2 + sin(a1)*r1;
  float x2 = width/2  + cos(a2)*r2;
  float y2 = height/2 + sin(a2)*r2;

  line(x1, y1, x2, y2);
  //    fill(255);
  ranPalFill(p3);
  ellipse(x1, y1, 3, 3);
  ellipse(x2, y2, 3, 3);

  //println([r1,a1,r2,a2]);
  x1 = y1 = x2 = y2 = 0;
}

///////////////////////////////////////////////////////
//  Make grid of shapes filled with each color in supplied
//  color[]
void paletteGrid( color[] pall ) {

  float _xx = 0;
  float _yy = 0;  
  float sz = 69;

  // debug
  //  text( pall.length + " colors ", sz, sz );

  for ( int cc = 0; cc < pall.length; cc++ ) {

    noStroke();
    fill( color( pall[cc] ), alf );
    rect( _xx, _yy, sz, sz );

    if ( _xx < width ) {
      _xx += (sz *1.25);
    } 
    else {
      _xx = 0;
      _yy += (sz *1.25);
    }
  }
}
void paletteGrid( ArrayList pall ) {

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




  //    textFont( createFont( "HiraMaruProN-W4", 222 ) );
  //    fill(random(alf));
  //    text( pall.size(), random( alf, width/3 ), random(height) );
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
        /*          void 
         color1 = (Integer) alColors.get( alColors.size()-1 );
         color2 = img.pixels[c];
         // filter out colors    
         if( color2 < color1 )  //NOTE: going LESS to our array isn't full of only white
         {
         */
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


void ranPalFill(ArrayList palette)
{
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
//  End handler, saves png
void doExit() 
{

  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + fix.getTimestamp()+".png" );
  }

  noLoop();
  exit();
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

  textFont( createFont( "Silom", 18 ) );
  smooth();

  fill(#EFEFEF);
  text( " "+dailyMsg, 0, this.height-11);

}

