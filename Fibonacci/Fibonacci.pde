Boolean isFinal = true;
int ctMAIN = 0;
int alf = 37;

int cX;
int cY;
int fib = 2;
int xx = 0;
int yy = 0;
int maxY;

////////////////////////////////////////////////////
//
void setup(){
  size(1024, 768 );
  //  ---------------------
  background (36);
  stroke( #EFEFEF, 10 );
  smooth();
  noFill();

  cX = this.width / 2;
  cY = this.height / 2;
  maxY = ( this.height - 60 );
}


////////////////////////////////////////////////////
//
void draw(){
  
  fib = nextFib(fib);

//  heart( fib+xx, fib+yy, fib+xx, fib+yy );

  if( yy >= (this.width-310) )  // <--- same distance as ART DAILY
  {
      stroke( #0E0E0E, alf );
      strokeWeight(3);
      
      line( yy, 0, yy, this.height );
  }
  else
  {
    heart( fib+xx, fib+yy, fib+xx, fib+yy );
    stroke(#EF7519, 25 );
    
    
  rect( fib, fib, xx, yy );
  }

//  rect( fib, fib, xx, yy );

  
  xx += fib;
  yy += fib;

  if( xx > this.width )
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
save( split( this.toString(), "[")[0] + "-" + month()+day()+year()+hour()+minute()+second()+millis() + ".png" );
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
  fill( #EFEFEF, 666 );

  PFont font = createFont( "Silom", 33 );
  textFont( font );
  
  text( " "+dailyMsg, this.width-303, this.height-50);
}




///////////////////////////////////////////////////////////
//  
//  draw heart
void heart( int x, int y, int w, int h ) 
{
  ellipseMode(RADIUS);
  smooth();
  
  if( x % 2 == 0 )
    stroke(#75EF19, alf );
  else if( x % 3 == 0 )
    stroke(#1975EF, alf );
  else
    stroke(#EF1975, alf );
  
//  strokeWeight(random(1));
//  scale( random(2) );
  
  noFill();
  
  //  bubbles
  //  ellipse(x, y, width, height)
  ellipse( x-w, y, w, w );
  ellipse( x+w, y, w, w );
  //  ellipseMode(MODE)
  //  MODE	Either CENTER, RADIUS, CORNER, or CORNERS
  
  //  FILL SHAPE
  
  //  lines	
  //  line(x1, y1, x2, y2)
  //stroke(#19EF75);
  line( x-(w*2), y, x, y + w*PI);
  line( x+(w*2), y, x, y + w*PI);
  
}



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
    font = createFont( fontList[ct], 20);
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

