
// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;
int alf = 42;
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
  fix.alpha(alf);
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
      fix.ranPalStroke(palette);
      strokeWeight( random( alf) );
    }


    //  drop a curve every 4th point
    if( _pvectors.size() % 4 == 0 ) {
      pv1 = (PVector)_pvectors.get( _pvectors.size()-1 );
      pv2 = (PVector)_pvectors.get( _pvectors.size()-2 );
      pv3 = (PVector)_pvectors.get( _pvectors.size()-3 );
      pv4 = (PVector)_pvectors.get( _pvectors.size()-4 );

      fix.ranPalStroke(palette);
      strokeWeight( random(25) );
      curve( pv1.x, pv1.y, pv2.x, pv2.y, pv3.x, pv3.y, pv4.x, pv4.y );


      strokeWeight( random(25) );
      point( pv1.x, pv1.y );
      point( pv2.x, pv2.y );
      point( pv3.x, pv3.y);
      point( pv4.x, pv4.y );
      
     
    } else {

      strokeWeight( random( 9.9) );
      fix.ranPalStroke(palette);

      point( lastPt.x, lastPt.y );
    }
  }
  noStroke();
  fill(r,g,b,alf);
  ellipse(x, y, diam, diam);
  fix.hexagon(x, y, diam);
  
  if( ct >= maxCt ) {
    doExit();
  }
  ct++;
}


//  interactive Zoog
void zoog2() {

  smooth();
  noFill();
  
  ellipseMode(CENTER);
  rectMode(CENTER);
  /*
  fix.ranPalStroke(palette);
  randFillUser();
  rect(mouseX, mouseY, alf, alf*5);
  */  
  fix.ranPalStroke(palette);
//  randFillUser();
  ellipse( mouseX, mouseY-30, 60, 60 );

  
  fix.ranPalStroke(palette);
//  randFillUser();
  ellipse( mouseX-19, mouseY-30, 16, 32 );
  ellipse( mouseX+19, mouseY-30, 16, 32 );
  
  fix.ranPalStroke(palette);
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




///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{

  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + fix.getTimestamp() + ".png" );
  }

  noLoop();
  exit();
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

