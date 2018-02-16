
Boolean isFinal = true;
int alf = 37;
float shapeSize = 400;

int cX;
int cY;

//  #A59DA1, #D96D55, #F36613, #A9ABEA, #D23301, #F6FAFD, #AB6E9C, #D6F9FF, #F8751E, #768A00, #F05510, #FFEE51, #FFB02A, #D7D5FA
color[] palette = { 
#EF0000, #00EF00, #0000EF, #EFEFEF
};


int ct = 0;
int maxCt = 0;

float r, g, b, a, diam, x, y;
ArrayList _pvectors = new ArrayList();
PVector thisPt,lastPt, pv1, pv2, pv3, pv4 = new PVector();

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(21);

  //  setup variables
  cX = width/2;
  cY = height/2;

  noFill();
  smooth();
  
  maxCt = 360 * 3;
}


////////////////////////////////////////////////////
//

float _x = 135;
float _y = 135;

void draw()
{
  r = random(255);
  g = random(255);
  b = random(255);


  diam = random(20);
  x = random(width);
  y = random(height);
  
  
  // store this point
  _pvectors.add( new PVector( x, y ) );

  if( _pvectors.size() > 1 )
  {

    //  connect this point ( _x, _y ) to the last
    lastPt = (PVector)_pvectors.get( _pvectors.size()-2 );
    strokeWeight( random( alf) );///10) );


    if( frameCount % frameRate == 0 ) {
      stroke(#FF5E00, alf*1.5 );
      strokeWeight( random( shapeSize*alf) );
      ellipse( _x, _y, shapeSize*2, alf*2 ); 
    
      //  reset
      randStrokeUser();
      strokeWeight( random( alf) );
    }


    //  drop a curve every 4th point
    if( _pvectors.size() % 4 == 0 ) {
      pv1 = (PVector)_pvectors.get( _pvectors.size()-1 );
      pv2 = (PVector)_pvectors.get( _pvectors.size()-2 );
      pv3 = (PVector)_pvectors.get( _pvectors.size()-3 );
      pv4 = (PVector)_pvectors.get( _pvectors.size()-4 );

      randStrokeUser();
      strokeWeight( random(25) );
      curve( pv1.x, pv1.y, pv2.x, pv2.y, pv3.x, pv3.y, pv4.x, pv4.y );


      strokeWeight( random(25) );
      point( pv1.x, pv1.y );
      point( pv2.x, pv2.y );
      point( pv3.x, pv3.y);
      point( pv4.x, pv4.y );
      
     
    } else {

      strokeWeight( random( 9.9) );
      randStrokeUser();

      point( lastPt.x, lastPt.y );
    }
  }
  noStroke();
  fill(r,g,b,alf);
  ellipse(x, y, diam, diam);
  hexagon(x, y, diam);
  
  if( ct >= maxCt ) {
    exit();
  }
  ct++;
}


void textLines() {


textFont( createFont( "Helvetica", 300 ) );

fill(10, pow(alf,1.5) );//, (alf*4) );
// MAKE TEXT BIG
fill(#210000, pow(alf,1.5) );//, (alf*4) );
text("lines.lines.lines.lines.lines", 0, height*.3 );
fill(#000021, pow(alf,1.5) );//, (alf*4) );
text("lines.lines.lines.lines.lines", 0, height*.3 );
//  & curve
fill(#210000, pow(alf,1.5) );//, (alf*4) );
text("lines.lines.lines.lines.lines", 0, height*.49 );
fill(#000021, pow(alf,1.5) );//, (alf*4) );
text("lines.lines.lines.lines.lines", 0, height*.49 );
//  & quad
fill(#210000, pow(alf,1.5) );//, (alf*4) );
text("lines.lines.lines.lines.lines", 0, height*.65 );
fill(#000021, pow(alf,1.5) );//, (alf*4) );
text("lines.lines.lines.lines.lines", 0, height*.65 );

//  & triangle
fill(#210000, pow(alf,1.5) );//, (alf*4) );
text("lines.lines.lines.lines.lines", 0, height*.85 );
fill(#000021, pow(alf,1.5) );//, (alf*4) );
text("lines.lines.lines.lines.lines", 0, height*.85 );


}




void mousePressed() {
  println("mousePressed()");  
}


void keyPressed() {
  println("keyPressed()");
}


//  interactive Zoog
void zoog2() {

  smooth();
  noFill();
  
  ellipseMode(CENTER);
  rectMode(CENTER);
  /*
  randStrokeUser();
  randFillUser();
  rect(mouseX, mouseY, alf, alf*5);
  */  
  randStrokeUser();
//  randFillUser();
  ellipse( mouseX, mouseY-30, 60, 60 );

  
  randStrokeUser();
//  randFillUser();
  ellipse( mouseX-19, mouseY-30, 16, 32 );
  ellipse( mouseX+19, mouseY-30, 16, 32 );
  
  randStrokeUser();
//  randFillUser();
  line( mouseX-alf, mouseY+(alf*5), pmouseX-alf, pmouseY+(alf*5));
  line( mouseX+alf, mouseY+(alf*5), pmouseX-alf, pmouseY+(alf*5));  
}












void zoog() {

  ellipseMode(CENTER);
  rectMode(CENTER);
  stroke(0);
  fill(150);
  rect(100, 100, 20, 100 );
  fill(255);
  ellipse(100, 70, 60, 60);
  fill(0);
  ellipse(81, 70, 16, 32 );
  ellipse(119, 70, 16, 32);
  stroke(0);
  line(90, 150, 80, 160);
  line(110, 150, 120, 160);
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

float radius = 18, xx, yy;

void circle( float startX, float startY, float w, float h ) {

  float angle = 0;

  while ( angle < 360 ) {
    xx = startX - int( cos(radians(angle)) * radius );
    yy = startY - int( sin(radians(angle)) * radius );


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
  fill(255);
  text( " "+dailyMsg, this.width*.45, this.height-18);
}

