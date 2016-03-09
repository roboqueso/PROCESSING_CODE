Boolean isFinal = true;

int gridSize = 4;    // grid will always be gridSize X gridSize
int maxCt = 13;    // how many passes do you want?
int alf = 75;
int colWidth, rowHeight;
int x = 0, y = 0;
int[] nums = { 
  2, 2, 4, 4, 4, 4, 6, 8, 10
};


void setup() {
  background(alf);
  size(1024, 768);
  frameRate(303); 

  smooth();
  noFill();

  colWidth = floor( width / gridSize );
  rowHeight = floor( height / gridSize );
} 

//////////////////////////////////////////////////////////////////////
void draw() {

  moveSystem( x, y );

  fill( random(255), alf );
  stroke( random(255) );

  drawSystem( x, y );


  //  adjust grid size
  if ( frameCount % 21 == 0 ) {
    gridSize = nums[ floor( random(nums.length) ) ]; //floor(random( 2, 10 ));
    colWidth = floor( width / gridSize );
    rowHeight = floor( height / gridSize );
  }

  if ( frameCount > width )
  {
    artDaily("ERICFICKES.COM");
    
    if(isFinal){
      save(this+".png");
    }
    
    noLoop();
  }
}





//////////////////////////////////////////////////////////////////////
//    System for adjusting x & y coordinates
void moveSystem( float x, float y )
{

  switch( floor( random(10) ) )
  {
  case 0:
    {
      if ( x < width )
      {
        x += colWidth;
      } 
      else {
        x = 0;
        y += rowHeight;
      }
    }
    break;

  case 1:
    {
      x = frameCount-radians(x) * cos(x * frameCount * PI/180);
      y = frameCount-radians(y) * sin(y * frameCount * PI/180);
    }
    break;

  case 2:
    {
      x = 1/frameCount + radians(x) + cos( pow(y, PI) + y / frameCount ) * x;
      y = 1/frameCount + radians(x) + sin( pow(x, PI) + x / frameCount ) * y;
    }
    break;

  case 3:
    {
      if ( y > height )
      {
        y = random(colWidth);
      } 
      else {
        y += rowHeight+colWidth;
        x -= y;
      }
    }
    break;

  case 4 :
    {
      x = width/2 + cos(x) * radians(frameCount );
      y = width/2 + sin(y) * radians(frameCount );
    }
    break;

  case 5 :
    {
      x += random(colWidth);
      y += random(rowHeight);
    }
    break;

  case 6 :
    {
      if( x < width ) {
        x += colWidth;
      } else {
        x = colWidth;
        y += rowHeight;
      }
    }
    break;

  case 7 :
    {
      x += 9;
      y += 11;
    }
    break;

  case 8 :
    {
      if( x > width/2 ) {
        x -= 11;
        y -= PI;
      } else {
        x += 11;
        y += PI;
      }
    }
    break;

  case 9 :
    {
      x +=9;
      y -= 11;
    }
    break;
  }

  // set adjusted values by calling SET functions
  setX( ceil(x) );
  setY( ceil(y) );
} 

// coord helpers ///////////////////////////////////////////////////
void setX( int val )
{
  x = val;
}
// coord helpers ///////////////////////////////////////////////////
void setY( int val )
{
  y = val;
}


//////////////////////////////////////////////////////////////////////
//    System for laying down random drawings
void drawSystem( float x, float y )
{
  switch( floor(random(12)) )
  {
  case 0:
    {
      point( x, y );
      point( y, x );
      
      ellipse( x, y, x, x );
      ellipse( y, x, y, y );
    }
    break;

  case 1:
    {
      ellipse( x, y, x/PI, x/PI );
      ellipse( y, x, x/TWO_PI, x/TWO_PI );
    }
    break;

  case 2:
    {
      rect( x, y, y/PI, y/TWO_PI );
      rect( y, x, y*TWO_PI, y*QUARTER_PI );
    }
    break;

  case 3:
    {
      line( y, y, x, x );
    }
    break;

  case 4:
    {
      fill( random(255), random(255), random(255) );
      text( frameCount, x, y );
      noFill();
    }
    break;

  case 5:
    {
      line( y, height-x, width, y*noise(frameCount) );
    }
    break;

  case 6:
    {
      ellipse( y, x, x/TWO_PI, x/TWO_PI );
    }
    break;

  case 7:
    {
      rect( y, x, y/TWO_PI, y/TWO_PI );
    }
    break;

  case 8:
    {
      line( y, x, width-x, y );
    }
    break;

  case 9:
    {
      line( width-x, height-y, x, y );
    }
    break;

  case 10:
    {
      noFill();
      stroke(#1975EF);
      curve( width*noise(frameCount), height, height-x, y, x, width-y, width-x, height-y*noise(frameCount) );
    }
    break;

  case 11:
    {
      noFill();
      stroke(#EF2012);
      bezier( width, height, height-x, y, x, width-y, width-x, height-y );
    }
    break;
  }
}


///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 13 ) );
  smooth();

  fill(255);
  text( dailyMsg, 0, height-HALF_PI);
}

