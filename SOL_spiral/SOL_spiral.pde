Boolean isFinal = true;
int ctMAIN = 0;
int alf = 13;

int cX;
int cY;
int xx = 0;
int yy = 0;
int pad = 4;
int cubeSize = 20;

float angle = 15;
float radius = 45;


////////////////////////////////////////////////////
//
void setup(){
  size(1024, 768 );
  //  ---------------------
  background (18);

  smooth();
  noFill();

  cX = this.width / 2;
  cY = this.height / 2;
    
  xx = -cubeSize;
  yy = xx;  
  
//exit();
  
}


////////////////////////////////////////////////////
//
void draw()
{

  xx = ( cX - int( cos(radians(angle)) * radius ) );
  yy = ( cY - int( sin(radians(angle)) * radius ) );

//randStroke();

  if( xx % 3 == 0 )
    stroke(#1975EF, alf);
  else if( xx % 4 == 0 )
    stroke(#19EF75, alf);
  else
    stroke(#75EF19, alf);


  ellipse( xx, yy, cubeSize+angle, cubeSize+angle );

  angle++;
//  radius += (PI * radius) / yy;
  radius += .25;

  if( xx <= (this.width-cubeSize) )
  {  
    xx += cubeSize;
  }
  else
  {
    xx = -cubeSize;
    yy += cubeSize;
    alf--;
  }


  if( yy >= this.height )
  {  
    exit();
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
save( fix.pdeName() + fix.getTimestamp() + ".png" );
  }

  super.stop();
}

///////////////////////////////////////////////////////////
//  Helper to random(255) stroke
void randFill()    {  fill( random(255), random(255), random(255), random(100) );  }
void randStroke()  {  stroke( random(255), random(255), random(255), random(100) );  }

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  PFont font = createFont( "Silom", 30 );
  textFont( font );
  
  fill( #000000, 666 );
  stroke( #696969, 666 );
    
  for( int ii = this.width-275; ii < this.width; ii += 5 )
  {

//    randFill();
//    randStroke();
//    cube( ii, int( this.height-( cubeSize*2) ), cubeSize*2 );
    ellipse( ii, int( this.height-( cubeSize*3.2) ), cubeSize*2 , cubeSize*2 );
  }
  
  fill( #EFEFEF, 666 );  
  text( " "+dailyMsg, this.width-275, this.height-cubeSize*2.69);
}





/*
///////////////////////////////////////////////////////////
//  
//  Spits the installed list of fonts out in a grid
void fontGrid() 
{
  fill(255);
  stroke(255);
  String[] fontList = PFont.list();
  int x = 10;
  int y = 10;
  PFont font;

  for( int ct = 0; ct <= fontList.length-1; ct++ ){   

  
    // load it & show it
    font = createFont( fontList[ct], 18);
    textFont( font );

    text(fontList[ct], x, y);
    
    if( ct % 55 == 0)
    {
      x += 330;
      y = 0;
    }
    else
    {
      y += 20;
    }
    
  }

}
*/

