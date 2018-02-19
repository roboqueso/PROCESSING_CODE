// https://github.com/ericfickes/FIXLIB	
import fixlib.*;

Fixlib fix = Fixlib.init(this);
// circles
Boolean isFinal = true;
int ctMAIN = 0;
int alf = 11;

int cX;
int cY;


color[] p2 = { #EF0000, #111111 };

color[] p1 = { #484547, #4c4434, #575550, #3c3a2f, #44432b, #3f3f2c, #383828, #32382a, #373c2d, #3b3b2d, #424636, #23261e, #262921, #444b3d, #394337, #485346, #434d45, #454e45, #52554b, #d8f8f8, #848c94, #e4fcfc, #323531, #838d8a, #73736c, #7b8283, #817e86, #d3d4dd, #f0f7f8, #dad7dc, #fafefe, #fbfefe,
#574f50, #55443e, #5c4e48, #725644, #785c49, #4d453f, #9c8e83, #86684f, #997046, #be8649, #787571, #b19866, #6d6a64, #dabe82, #7c7a72, #313728, #333c2c, #5a5b49, #4c4c3e, #4c4f42, #4a5346, #4a4b40, #465147, #5e5a65, #5d5b65, #575159, #74787f, #707970, #6f7570, #797b7d,
#959394, #bbb9ba, #787878, #273121, #2b3323, #31382a, #22251c, #373b2f, #414638, #41453a, #4c4e45, #3e453f, #575e55, #59605c, #a7b0b4, #7c7e81, #757874, #3c3c3a, #494b4a, #979599, #767977, #a19fa3, #b3b6b7, #606262, #959898, #9b9d9e, #828381, #9c9e9d, #9f9ea0, #b1b2b3, #d8d7d9,
#5a5555, #a29b9b, #9a9191, #827e7e, #8e8785, #928986, #7d736f, #7b6f6a, #d2cbc8, #aca5a2, #a59f9c, #887f7a, #aca5a1, #87807b, #c4b9b1, #a39b95, #bcb4ae, #b0a8a2, #9f9791, #a8a39f, #b8b1ab, #b9b6b3, #a39e98, #a29d97, #98938c, #757068, #7d7a75, #75736f, #8b8882, #a6a196, #767469
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
  size(1024, 768);
  frameRate(303);
  background(222);
  fix.alpha(alf);
  //  -------------------------------------------
  smooth();
  noFill();

  cX = int( this.width / 2 );
  cY = int( this.height / 2 );

  maxAngle = 2222;
  
  startX1 = startX2 = startX3 = startX4 = cX;
  startY1 = startY2 = startY3 = startY4 = cY;

  stroke(0, alf);
  
  //  setup circles
  radius1 = 37;
  radius2 = 42;
  radius3 = 187;
  radius4 = 420;
}


////////////////////////////////////////////////////
//
void draw()
{
  smooth();
  noFill();
  strokeWeight(random(42));

  xx1 = startX1 - int( cos(radians(angle1)) * radius1 );
  yy1 = startY1 - int( sin(radians(angle1)) * radius1 );
  
  xx2 = startX2 - int( cos(radians(angle2)) * radius2 );
  yy2 = startY2 - int( sin(radians(angle2)) * radius2 );
  
  xx3 = startX3 - int( cos(radians(angle3)) * radius3 );
  yy3 = startY3 - int( sin(radians(angle3)) * radius3 );
  
  xx4 = startX4 - int( cos(radians(angle4)) * radius4 );
  yy4 = startY4 - int( sin(radians(angle4)) * radius4 );
  
  //  -------------
  stroke(random(111), alf);
  point( xx1, yy1 );
  point( xx2, yy2 );
  point( xx3, yy3 );
  point( xx4, yy4 );

  stroke(random(255), alf*42);
  bezier( yy1, yy2, yy3, yy4, xx4, xx3, xx2, xx1+frameCount );
  bezier( xx4+frameCount, xx3, xx2, xx1, yy1, yy2, yy3, yy4 );
  
  stroke(random(222), random(222), random(222), alf*42);
  curve( xx1, yy1, yy2, xx2, yy3, xx3, xx4, yy4 );

  angle1 += 2;
  angle2 += 2;
  angle3 += 2;
  angle4 += 2;


  if ( angle1 >= maxAngle )
  {    
    doExit();
  }
 
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
    save( fix.pdeName()+".png" );
  }

  noLoop();
  exit();
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
  fill(#EFEFEF, pow(alf,3) );
  text( " "+dailyMsg, this.width-225, this.height-15);
  
//  fill( #003600 , 666 );
  fill(0, pow(alf,3) );
  text( " "+dailyMsg, this.width-226, this.height-16);
}


///////////////////////////////////////////////////////////
//  draws circle from supplied x, y
void drawCore( int XX, int YY, int maxSize ) {

  float r = 1;  // 75;
  float theta = 2;

  int alf = 10;
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

    fix.bitHeart( int(YY+y), int(XX+x), (int(y)>42));//, int(y) );

    theta+= 0.25;

    if ( frameCount%2==0) {
      r++;
      theta+=.5;
    }
  }
}