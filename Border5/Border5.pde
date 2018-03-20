// https://github.com/ericfickes/FIXLIB	
import fixlib.*;

Fixlib fix = Fixlib.init(this);
Boolean isFinal = true;
int alf = 37;

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
  fix.alpha(alf);
  //  setup variables
  cX = width/2;
  cY = height/2;

  // RED
  stroke( #B00B13, alf );
  maxCt = 360 * 3;
  fix.drawFrame();

}


////////////////////////////////////////////////////
//

float _x = 135;
float _y = 135;
PVector thisPt,lastPt, pv1, pv2, pv3, pv4 = new PVector();

void draw()
{
  smooth();
  fix.ranPalStroke(palette);
  
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
    doExit();
  }
  
  ct++;
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
//  text( " "+dailyMsg, this.width-225, this.height-15);
  text( " "+dailyMsg, this.width-343, this.height-130);
  
//  fill( #003600 , 666 );
  fill(#CADDAC, pow(alf,3) );
//  text( " "+dailyMsg, this.width-226, this.height-16);
text( " "+dailyMsg, this.width-344, this.height-131);
}

