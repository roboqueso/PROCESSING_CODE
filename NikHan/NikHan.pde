//
//  Learning Processing CH4
//
//  code from @nikhan
//  int a,b,i,c=600;void setup(){size(b=c,c);}void draw(){for(i=0;i++<c;){fill(a++%255);rect(sin(a)*c,c/2+cos(a*b/c)%c,a/c,sin(a)*c);}}

int a,b,i,c=600;

Boolean isFinal = true;
float alf = 11;
float shapeSize = 100;

int cX;
int cY;

//  
color[] palette = { 
  #EF0000, #00EF00, #0000EF, #EFEFEF, #A59DA1, #D96D55, #F36613, #A9ABEA, #D23301, #F6FAFD, #AB6E9C, #D6F9FF, #F8751E, #768A00, #F05510, #FFEE51, #FFB02A, #D7D5FA
};

int outerXX = 0;
int outerYY = 0;

float angle = 0;
float maxAngle;
float radius = 10;
float outerRadius = 100;

int offsetX = 0;
int offsetY = 0;
float _lerp = 0.01;

int ct = 0;
int maxCt = 0;
boolean flip = false;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(9);

  //  setup variables
  cX = width/2;
  cY = height/2;

  offsetX = cX;
  offsetY = cY;

  maxCt = 360 * 30;

  // white scan lines
  stroke(255, 25 );
  for ( int ll = 0; ll <= width; ll += 2 ) 
  {  
    strokeWeight( random(1.1) );

    line( 0, ll, random(width), ll );
    line( ll, 0, ll, random(height) );
  }
}


////////////////////////////////////////////////////
//

void draw()
{
  smooth();
  strokeWeight( random(5.5) );
  stroke( random(69), alf);
  noFill();

  xx = ( offsetX - int( cos(radians(angle)) * random(radius) ) );
  yy = ( offsetY - int( sin(radians(angle)) * random(radius) ) );

  outerXX = ( offsetX - int( cos(radians(angle)) * outerRadius ) );
  outerYY = ( offsetY - int( sin(radians(angle)) * outerRadius ) );

/*
  for(i=0;i++< width;) {
    stroke(a++%255, alf);
    line(sin(a)*c,c/2+cos(a*b/c)%c,a/c,sin(a)*c);
  }


if(flip)
  stroke( #EFEFEF, alf );
else
  stroke( #EF1234, alf );
*/  

  strokeWeight(.5);

  line(outerXX-1, outerYY-1, offsetX, offsetY);
  line(offsetX-1, offsetY-1, xx, yy);
  line(outerXX, outerYY, offsetX, offsetY);
  line(offsetX, offsetY, xx, yy);
  line(outerXX+1, outerYY+1, offsetX, offsetY);
  line(offsetX+1, offsetY+1, xx, yy);

  
  
//  strokeWeight( random(alf) );
  point(xx, yy);

//  stroke( #90DEFA );//, alf);
  stroke(#19EFFA );
  
  point( outerXX, outerYY );
stroke( #90DEFA );
  point( random(xx, outerXX), random( yy, outerYY ) );
  point( lerp(xx, outerXX, _lerp ), lerp( yy, outerYY, _lerp ) );

randStroke();  //User();

  if( flip ) {
    ellipse( lerp(xx, outerXX, _lerp ), lerp( yy, outerYY, _lerp ), angle, angle );
    ellipse( lerp( yy, outerYY, _lerp ), lerp(xx, outerXX, _lerp ), angle, angle );
  } else {
    ellipse( lerp(xx, outerXX, _lerp ), lerp( yy, outerYY, _lerp ), random(angle), random(angle) );
    ellipse( lerp(xx, outerXX, _lerp ), lerp( yy, outerYY, _lerp ), random(shapeSize), random(shapeSize) );
  }

  
  if ( angle >= maxCt ) {
    exit();
  }

  if( _lerp < 1 ) {
    _lerp += 0.05;
  } else {
    _lerp = 0.01;
  }


if ( angle % 1080 == 0 ) {
    flip = !flip;
    angle  += 6;
    radius += 6;

    offsetY = (int)random(height);
    offsetX = (int)random(width);

    strokeWeight(4);
    stroke(#FF0000, alf*4);

    line( outerXX, outerYY, offsetX, offsetY );
    line( offsetX, offsetY, xx, yy );


    strokeWeight( random(6.9) );
  } 
  else {
    angle+=2;  //6;
  }
}


void textLines() {


  textFont( createFont( "Helvetica", 300 ) );

  fill(10, pow(alf, 1.5) );//, (alf*4) );
  // MAKE TEXT BIG
  fill(#210000, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.3 );
  fill(#000021, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.3 );
  //  & curve
  fill(#210000, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.49 );
  fill(#000021, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.49 );
  //  & quad
  fill(#210000, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.65 );
  fill(#000021, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.65 );

  //  & triangle
  fill(#210000, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.85 );
  fill(#000021, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.85 );
}




void mousePressed() {
  println("mousePressed()");
}


void keyPressed() {
  println("keyPressed()");
}



///////
//  draw frame
void drawFrame() {

  rectMode(CORNER);

  strokeWeight( 100 );
  rect( 0, 0, width, height);

  strokeWeight( 5 );
  rect( 64, 65, width-128, height-129 );

  strokeWeight( 15 );
  rect( 84, 85, width-168, height-168 );

  //  dashed line
  strokeWeight(6);
  int x = 110;
  int y = 110;

  strokeCap(PROJECT);

  for ( int pp = 0; pp <= (width*height); pp++ ) { 

    if ( x <= (width-110) ) {
      // top row    
      point( x, y );
      //  bottom row
      point( x, 790 );

      x += 10;
    } 
    else if ( y <= 780 ) {

      // left row    
      point( (width-110), y );
      //  right row
      point( 110, y );
      y += 10;
    }
  }

  strokeWeight( 5 );
  rect( 122, 122, width-245, height-245 );
}

//////////////////////////////////////////////////////////////////////////
//  Draw manual circle
//  ellipse(x, y, width, height)

float radius2 = 18, xx, yy;

void circle( float startX, float startY, float w, float h ) {

  float angle = 0;

  while ( angle < 360 ) {
    xx = startX - int( cos(radians(angle)) * radius2 );
    yy = startY - int( sin(radians(angle)) * radius2 );


    ellipse( xx, yy, w, h );

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

////////////////////////////////////////////////////
//  Randomly stroke using image from color list
void randStrokeUser()
{
  // pallete
  stroke( palette[ int(random( palette.length-1 )) ], alf*.75 );
}
void randFillUser()
{
  fill( palette[ int(random( palette.length-1 )) ], alf*.75 );
}




///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 18 ) );
  smooth();

  //  stroke(#EFEFEF);
  fill(#69EF19);
  text( " "+dailyMsg, this.width*.45, this.height-18);
}

