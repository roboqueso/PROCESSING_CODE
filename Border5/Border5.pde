//
//  This is a PRocessing sketch
//
Boolean isFinal = true;
float alf = 37;

int cX;
int cY;

color[] palette = { #EFEFEF, #EFEF00, #EF0000, #EF0000, #B00B13 };

ArrayList _pvectors = new ArrayList();
int ct = 0;
int maxCt = 0;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(6);

  //  setup variables
  cX = width/2;
  cY = height/2;

  // RED
  stroke( #B00B13, alf );
  maxCt = 360 * 3;
  drawFrame();

}


////////////////////////////////////////////////////
//

float _x = 135;
float _y = 135;
PVector thisPt,lastPt, pv1, pv2, pv3, pv4 = new PVector();

void draw()
{
  smooth();
  randStrokeUser();
  
  _x = lerp( 666, random(width), .8 );
  _y = lerp( 666, random(height-100), .8 );

  // store this point
  _pvectors.add( new PVector( _x, _y ) );
  
  
  //  dot
  strokeWeight( random(alf) );
  point( _x, _y );



  if( _pvectors.size() > 1 )
  {

    //  connect this point ( _x, _y ) to the last
  
    lastPt = (PVector)_pvectors.get( _pvectors.size()-2 );

//    line( lastPt.x, lastPt.y, _x, _y );
    strokeWeight( random(2.1) );
  
    ellipse( lastPt.x, lastPt.y, alf, alf );
    
    //  drop a curve every 4th point
    if( _pvectors.size() % 4 == 0 ) {
      pv1 = (PVector)_pvectors.get( _pvectors.size()-1 );
      pv2 = (PVector)_pvectors.get( _pvectors.size()-2 );
      pv3 = (PVector)_pvectors.get( _pvectors.size()-3 );
      pv4 = (PVector)_pvectors.get( _pvectors.size()-4 );

      curve( pv1.x, pv1.y, pv2.x, pv2.y, pv3.x, pv3.y, pv4.x, pv4.y );
     
    }
    
    
  }
  

  if( ct >= maxCt ) {
    exit();
  }
  
  ct++;
}

///////
//  draw frame
void drawFrame() {

  noFill();  
  rectMode(CORNER);
  
  strokeWeight( 100 );
  rect( 0,0, width, height);
  
  strokeWeight( 5 );
  rect( 64,65, width-128, height-129 );

  strokeWeight( 15 );
  rect( 84,85, width-168, height-168 );

  //  dashed line
  strokeWeight(6);
  int x = 110;
  int y = 110;

  strokeCap(PROJECT);

  for( int pp = 0; pp <= (width*height); pp++ ) { 

    if( x <= (width-110) ) {
      // top row    
      point( x, y );
      //  bottom row
      point( x, 790 );

      x += 10;

    } else if ( y <= 780 ) {
      
      // left row    
      point( (width-110), y );
      //  right row
      point( 110, y );
      y += 10;
    }
    
  }

  strokeWeight( 5 );
  rect( 122,122, width-245, height-245 );

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
  stroke( palette[ int(random( palette.length-1 )) ] , alf );
}
void randFillUser()
{
  fill( palette[ int(random( palette.length-1 )) ] , alf );
}


String getTimestamp() {
  return ""+month()+day()+year()+hour()+minute()+millis();
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
//  text( " "+dailyMsg, this.width-225, this.height-15);
  text( " "+dailyMsg, this.width-343, this.height-130);
  
//  fill( #003600 , 666 );
  fill(#CADDAC, pow(alf,3) );
//  text( " "+dailyMsg, this.width-226, this.height-16);
text( " "+dailyMsg, this.width-344, this.height-131);
}

