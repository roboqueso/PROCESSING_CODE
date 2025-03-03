//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;
int alf = 13;

int cX;
int cY;

float x,y, t;

color[] p1 = { #FEFEFC,#89776E,#ECE9E8,#AA9991,#322D2B,#DBD7D8,#D2C7BA,#B2A699,#CAC7C7,#D8CDC9,#BAB6B7,#C9BDB9,#918678,#E9DED9,#EEE7DD,#AAA6A7,#B8ACA8,#999596,#DFDC6A,#888584,#787574,#6A6456,#665854,#4D4337,#686564,#575453,#978B87,#F7EFEA,#474443,#DCD6CC,#423833,#766A65,#C8B5AE,#F8F7F3,#554946,#BBB6AA,#C6B192,#E8D6CF,#787368,#9A9489,#A98A79,#CEA070,#565348,#F8F785,#DDDEE1,#D2CB92,#BBBDC1,#B4AE73,#CDCED2,#100B0B,#E7D0B5,#ABADB1,#9B9CA0,#EEEFF1,#C7BDC6,#EFEEB6,#8F8754,#BDC6CB,#DEE7EA,#B3AE52,#8B8C8F,#C7ACA6,#9BA5AA,#A79C9E,#CED6DB,#D7CED6,#7A7B7E,#29211F,#7A8589,#D4BBAB,#B6ADB6,#D7BDB7,#595A5D,#ADB5BA,#958C95,#6A6B6E,#867B7D,#211715,#C49789,#EFF7F8,#494A4D,#8B9499,#645A63,#E7DEE7,#7F8474,#746B74,#E9B48E,#5A6467,#596357,#E8CDC7,#443942,#6A7476,#E4D897,#534A52,#6A7369,#8F5544,#37363A,#F8DBC9,#BF785E,#EABDA7,#C4C6B0,#4A5248,#394245,#A2A03F,#A2985A,#4A5355,#E0E7D3,#A4A59A,#8B948A,#F7EFF7,#ACB5A8,#414239,#FBE2DA,#211821,#CED6CA,#7E3827,#D9AB9D,#EFF7EE,#212223,#C26642,#C7C468,#CAABBA,#18181B,#D0CA4A,#E39E80,#182117,#E6E588,#A2A075 };

color[] p2 = { 
#A59DA1,#D96D55,#F36613,#A9ABEA,#D23301,#F6FAFD,#AB6E9C,#D6F9FF,#F8751E,#768A00,#F05510,#FFEE51,#FFB02A,#D7D5FA,
};

float angle = 0;
float xx, yy, startX, startY;
float w = 40;  


////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(0);

  //  setup variables
  cX = width/2;
  cY = height/2;

  startX = cX;
  startY = cY;

    noFill();
  t = width;
  angle = t;
}


////////////////////////////////////////////////////
//
void draw()
{
  xx = startX - int( cos(radians(angle)) * w );
  yy = startY - int( sin(radians(angle)) * w );

  if( frameCount % 2 == 0 )
    ranPalStroke( p2 );
  else
    ranPalStroke( p1 );

  drawLissajous( xx, yy, random(frameCount) );

  if ( t < 0 ) {

    doExit();

  }

  angle --;
  t --;
}


//////////////////////////////////////////////////////
//  
void drawLissajous( float a, float b, float amp )
{
//  float amp = 33;
  float x, y, sw;
  
  for( float t = 0; t <= 360; t += .2 )
  {
    x = a - amp * sin(a * t * PI/180);
    y = b - amp * sin(b * t * PI/180);
    
    //sw = ( amp + a + b ) / 180;
//    sw = a - amp/TWO_PI - b;
//    strokeWeight( floor(a/b)+1 );
    strokeWeight( 1 );
smooth();
//      println(sw);

    point(x,y);
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
//  End handler, saves png to ../OUTPUT
void doExit() 
{

  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  }

  noLoop();
  exit();
}




String getTimestamp() {
  return ""+month()+day()+year()+hour()+second()+millis();
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
  text( " "+dailyMsg, this.width-275, this.height-14);
/*
float yy = 0;
while( yy <= height ) {

  fill(#EFEFEF, yy*.15);
 text( " "+dailyMsg, 5, yy);
 yy += 18; 
}
*/

}

