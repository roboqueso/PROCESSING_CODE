//
//  This is a PRocessing sketch
//
// circles
Boolean isFinal = true;
int ctMAIN = 0;
float alf = 11;

int cX;
int cY;

int stroke1 = 50;
float stroke2 = 36;
//

color[] p2 = { 
  #8B5F1A, #CBA53A, #3F230E, #FBDC8B, #A4A590, #E96303, #86724A, #B1CEA0, #D4D6CE, #FEF3C1, #CCBF8E, #F62200, #882E02, #B1D6D3, #858B64, #D4F0D5, #80B1C2, #B1BABB, #FBDCC4, #D6F1F1, #5D6260, #D48421, #D7DDEE, #CDBABF, #8D827F, #F0DDEE, #A14232, #EFEEEA, #FFFFE8, #ECFFEC, #EEFFFF, #FFFFFF, 
  #6e5c5f, #684f53, #765c5e, #988586, #887475, #c6aeaf, #977c7d, #937475, #fefdfd, #fbf8f8, #6e5a5a, #9e8787, #766e6e, #8a8181, #867777, #847c7c, #705857, #6a5251, #7c6867, #907c7b, #bda2a0, #ae9593, #8d7775, #79605d, #dfcfcd, #f4edec, #6f6867, #b29692, #987772, #8e7470, #8e6c65, #af958f, #8a6c65, #ceb6b0, #887c79, #5a5655, #9c7970, #9f7e74, #816b64, #544641, #755c52, #8e6e5f, #605a57, #89827d, #7f766f, #a49a91, #55504b, #685f56, 
  #78726a, #625d55, #7b7568, #78766e, #716e5f, #416e24, #365a28, #c9d950, #4c6c30, #659443, #729741, #698338, #587e3a, #385529, #5b7f3b, #89b552, #87a347, #4c7036, #5b7436, #446735, #689048, #87a24c, #56763b, #688c46, #849948, #84ab55, #70964c, #638c49, #8a9b49, #5b733a, #5f7f42, #82a756, #759750, #7e924a, #476639, #8e9e50, #425e35, #405a33, #92b362, #b3cd6f, #4b653a, #c0d472, #819b57, #4f6d40, #65854f, #c8d878, #8ca15c, #899c59, #a5be6d, #8aa965, #768c54, #84a464, #7d9a5e, #5a7549, #718753, #5a7449, #a6ca7e, #57754b, #435637, #405336
};

color[] p1 = { 
  #0e75f0, #031224, 
  #E19F36, #E0BF36, 
  #69a136, #b00be5
};

//  circle vars
float angle1, xx1, yy1, startX1, startY1, radius1;
float angle2, xx2, yy2, startX2, startY2, radius2;
float angle3, xx3, yy3, startX3, startY3, radius3;
float angle4, xx4, yy4, startX4, startY4, radius4;

float maxAngle;
////////////////////////////////////////////////////
//
void setup() {
  // size to match image
  size(1024, 768 );
  background(0);

  //  -------------------------------------------
  smooth();
  noFill();

  cX = int( this.width / 2 );
  cY = int( this.height / 2 );

  maxAngle = width+height*11;

  startX1 = startX2 = startX3 = startX4 = cX;
  startY1 = startY2 = startY3 = startY4 = cY;

  angle1 = angle2 = angle3 = angle4 = -90;

  //  setup circles
  radius1 = 50;
  radius2 = 175;
  radius3 = 300;
  radius4 = 500;

  strokeWeight(stroke1);  
  stroke(#EFEFEF, alf);
 }


////////////////////////////////////////////////////
//
void draw()
{



  xx1 = startX1 - int( cos(radians(angle1)) * radius1 );
  yy1 = startY1 - int( sin(radians(angle1)) * radius1 );

  xx2 = startX2 - int( cos(radians(angle2)) * radius2 );
  yy2 = startY2 - int( sin(radians(angle2)) * radius2 );

  xx3 = startX3 - int( cos(radians(angle3)) * radius3 );
  yy3 = startY3 - int( sin(radians(angle3)) * radius3 );

  xx4 = startX4 - int( cos(radians(angle4)) * radius4 );
  yy4 = startY4 - int( sin(radians(angle4)) * radius4 );

  //  -------------


   // quad(x1, y1, x2, y2, x3, y3, x4, y4);
   // arc(x, y, width, height, start, stop);
   // bezierVertex(cx1, cy1, cx2, cy2, x, y);
   // bezier(xx1, yy1, xx2, yy2, xx3, yy3, xx4, yy4);
   // triangle(x1, y1, x2, y2, x3, y3);
  
   if( frameCount > (width+height)*9 ){
      ranPalStroke(p2);
   } else {
      ranPalStroke(p1);
   }

  point( xx1, yy1 );
  point( xx2, yy2 );
  point( xx3, yy3 );
  point( xx4, yy4 );

  angle1 += 12;
  angle2 += 10;
  angle3 += 8;
  angle4 += 6;


  if ( angle1 % 9 == 0 ) {
    radius1 += alf;
    radius2 += alf;
    radius3 += alf;
    radius4 += alf;
  }

  if( frameCount % cX == 0 || frameCount % cY == 0){
    angle1 = random(angle1, 69);
    angle2 = random(angle2, 75);
    angle3 = random(angle3, 109);
    angle4 = random(angle4, 185);

    radius1 = random(alf, radius1);
    radius2 = random(alf*2, radius2);
    radius3 = random(alf*3, radius3);
    radius4 = random(alf*4, radius4);
  }


  if ( frameCount >= maxAngle )
  {    
    exit();
  }
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

void ranPalFill(color[] palette)
{
  fill( palette[ int(random( palette.length-1 )) ], alf );
}

float x1, x2, x3, x4;
float y1, y2, y3, y4;

void cube( float x, float y, float cSize ) {
  
  
  x1 = x + cSize;
  y1 = y - cSize;
//  stroke(255, 0, 0);
//  ellipse( x+ cSize, y- cSize, cSize, cSize );

  //  #2
//  stroke(0, 255, 0);
  x2 = x+ (cSize*1.5);
  y2 = y- (cSize*1.5);
//  ellipse( x+ (cSize*1.5), y- (cSize*1.5), cSize, cSize );

  //  #3
//  stroke(0,0,255);
  x3 = x+ cSize*2;
  y3 = y- cSize;
//  ellipse( x+ cSize*2, y- cSize, cSize, cSize );
  
  //  #3
//  stroke(255, alf);
  x4 = x+ (cSize*1.5);
  y4 = y- (cSize*.5);
//  ellipse( x+ (cSize*1.5), y- (cSize*.5), cSize, cSize ); 

//  randStroke();
/*
  if( xx % 3 == 0 )
    stroke( #0E750F, alf );
  else
    stroke( #0DEEF0, alf );
*/
  if( y % 2 == 0 )
    stroke( #19EF75, alf );
  else if( y % 3 == 0 )
    stroke( #0DEEF0, alf );
  else if( y % 4 == 0 )
    stroke( #0E750F, alf );
  else
    stroke( #75EF19, alf );


  quad( x1, y1, x2, y2, x3, y3, x4, y4 );
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
//  Draw manual circle
//  OVERRIDE : @modAngle - restrict drawing to angle % @modAngle
void dotCircle( float startX, float startY, float w, float h, float modAngle ) {

  float angle = 0;
  float xx, yy;

  while ( angle < 360 ) {

    // make circle draw faster by skipping angles
    if ( angle % modAngle == 0 ) {

      xx = startX - int( cos(radians(angle)) * w );
      yy = startY - int( sin(radians(angle)) * w );

      smooth();
      point( xx, yy );
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
void exit() 
{

  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
    save( this + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
  }

  super.stop();
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






///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  PFont font = createFont( "Silom", 18 );

  smooth();
  textFont( font );
  strokeWeight(1);

  //  fill( #000000 , 666 );
  fill(#EFEFEF, pow(alf, 3) );
  text( " "+dailyMsg, this.width-225, this.height-15);

  //  fill( #003600 , 666 );
  fill(0, pow(alf, 3) );
  text( " "+dailyMsg, this.width-226, this.height-16);
}


///////////////////////////////////////////////////////////
//  draws circle from supplied x, y
void drawCore( int XX, int YY, int maxSize ) {

  float r = 1;  // 75;
  float theta = 2;

  float alf = 10;
  float x;
  float y;

  smooth();
  strokeWeight(.13);

  while ( theta <= maxSize )
  {    
    x = (PI*r) * cos(theta);
    y = (PI*r) * sin(theta);

    if (x%2==0)stroke(255, alf);
    else if (x%3==0) stroke(255, 0, 0, alf);
    else stroke( 109, 109, 109, alf);

    ellipse( int(XX+x), int(YY+y), x, x );

    heart( int(YY+y), int(XX+x), int(y), int(y) );

    theta+= 0.25;

    if ( frameCount%2==0) {
      r++;
      theta+=.5;
    }
  }
}




///////////////////////////////////////////////////////////
//  
//  draw heart
void heart( int x, int y, int w, int h ) 
{
  ellipseMode(RADIUS);
  smooth();

  //  stroke(#EF7519, alf);  // 37
  stroke(#EF1111, alf);  // 37

  strokeWeight(2);
  //  noFill();

  //  bubbles
  ellipse( x-w, y, w, w);
  ellipse( x+w, y, w, w);
  //  ellipseMode(MODE)
  //  MODE	Either CENTER, RADIUS, CORNER, or CORNERS


  //  lines	
  line( x-(w*2), y, x, y + w*PI);
  line( x+(w*2), y, x, y + w*PI);
}

