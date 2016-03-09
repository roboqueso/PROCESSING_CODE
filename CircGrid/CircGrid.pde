Boolean isFinal = true;
int ctMAIN = 0;
float alf = 33;

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
  
  stroke(#EFEFEF, alf);
  
  xx = -cubeSize;
  yy = xx;  
  
//exit();
  
}


////////////////////////////////////////////////////
//
void draw()
{

//    xx = ( cX - int( cos(radians(angle)) * radius ) );
//    yy = ( cY - int( sin(radians(angle)) * radius ) );

  if( xx % 2 == 0 )
    stroke( #19EF75, alf );
  else if( xx % 3 == 0 )
    stroke( #0DEEF0, alf );
  else if( xx % 4 == 0 )
    stroke( #0E750F, alf );
  else
    stroke( #75EF19, alf );
  
  //  ALTERING ELLIPSE SIZES MAKES FOR DIFF GRID ACTION
  if( xx % 2 == 0 )
    ellipse( xx, yy, cubeSize*2, cubeSize*2 );
  else if( xx % 3 == 0 )
    ellipse( xx, yy, cubeSize*3, cubeSize*3 );
  else if( xx % 4 == 0 )
    ellipse( xx, yy, cubeSize*4, cubeSize*4 );
  else if( xx % 5 == 0 )
    ellipse( xx, yy, cubeSize*5, cubeSize*5 );
  else
    ellipse( xx, yy, cubeSize, cubeSize );  
  
  
  //  #1
  cube( xx, yy, cubeSize );



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
void exit() 
{   
  artDaily("ERICFICKES.COM");


  //  if final, save output to png
  if ( isFinal )
  {
    save( this + "-" + month()+day()+year()+hour()+minute()+millis() +".png" );
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
    
  for( int ii = this.width-325; ii < this.width; ii += 5 )
  {

//    randFill();
//    randStroke();
    cube( ii, int( this.height-( cubeSize*2) ), cubeSize*2 );
  }
  
  fill( #EFEFEF, 666 );  
  text( " "+dailyMsg, this.width-275, this.height-72);
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
////////////////////////////////////////////////////////////////
//  
float x1, x2, x3, x4;
float y1, y2, y3, y4;

void cube( int x, int y, int cSize ) {
  
  
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
   int result = f2;
   f0 = f1;
   f1 = f2;
   f2 = f0 + f1;
   return result;
}
