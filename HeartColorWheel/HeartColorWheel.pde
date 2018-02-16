//import processing.opengl.*;

//  inspired by http://processing.org/learning/transform2d/
//  Spinning color

Boolean isFinal = true;
int ctMAIN = 0;
int alf = 37;
float randCirc = 10;

float registerX = 0;
float registerY = 0;

//  art frame settings
int outerRectX;
int outerRectY;
int outerRectWidth = 212;
int outerRectHeight = 30;



/////////////////////////////////////////////////
void setup() {
  size( 1024, 768 );  //, OPENGL);
  background(37);
  frameRate(303);
  fontGrid();
  
  smooth();
  noFill();


  
  registerX = 100;
  registerY = 100;  
  
  
//  heart( 500,500, 100,100 );
//  exit();
  
}


/////////////////////////////////////////////////
void draw(){

  if (frameCount % 9 == 0) {

    pushMatrix();    
    
    if( frameCount % 91 == 0 )
    {
      registerY += 18; 
    }
    translate( registerX, registerY );
    
    noTint();

    rotate(radians(frameCount * 2  % 360));

    randCirc = random(360);

    heart( int(randCirc),int(randCirc),int(randCirc),int(randCirc));
    
    popMatrix();
  }
  
  ctMAIN++;
  
  if( ctMAIN == 1996 )
  {
    exit();
  }
  
}


///////////////////////////////////////////////////////////
//  
//  Spits the installed list of fonts out in a grid
void fontGrid() 
{
  fill(255, 75);
  stroke(255, 75);
  String[] fontList = PFont.list();
  int x = 0;
  int y = 0;
  PFont font;

  for( int ct = 0; ct <= fontList.length-1; ct++ ){   

  
    // load it & show it
//    font = createFont( fontList[ct], 10);
    font = createFont( "AmericanTypeWriter", 20);
    textFont( font );
//    text(fontList[ct], x, y);
    text("ERIC & FLETCH & EVE & ", x, y);

    if( ct % 55 == 0)
    {
      x += 250;
      y = 0;
    }
    else
    {
      y += 20;
    }
    
  }

}

///////////////////////////////////////////////////////////
//  
//  draw heart
void heart( int x, int y, int w, int h ) 
{
  ellipseMode(RADIUS);
  smooth();
  stroke(#EF1975, 37);  
  strokeWeight(2);
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
//  End handler, saves png to ../OUTPUT
void exit() 
{
  stroke( 255, 0,0,100);
  heart( (this.width/2), (this.height/2), 69, 69);
  
  
artDaily("ERICFICKES.COM");
//  artDaily("HAPPY VALENTINES 2012");

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

  rotate(0);
  strokeWeight(2);
  
  stroke(255, 0,0, 100);

//randStroke();
fill( 255, 0,0,100);
rect( this.width-220, this.height-120, outerRectWidth, outerRectHeight );
//heart( this.width-220, this.height-120, outerRectWidth, outerRectHeight);
  
//randStroke();
fill( 205, 0,0,100);
rect( this.width-217, this.height-117, outerRectWidth-6, outerRectHeight-6 );
//heart( this.width-217, this.height-117, outerRectWidth-6, outerRectHeight-6);

//randStroke();
fill( 155, 0,0,100);
rect( this.width-214, this.height-114, outerRectWidth-12, outerRectHeight-12 );
//  heart( this.width-214, this.height-114, outerRectWidth-12, outerRectHeight-12);
  
fill( 0, 0,0,100);
  
  PFont font = createFont("Helvetica-Bold", 12); // createFont( installedFontName )
  textFont(font);
  text( " "+dailyMsg, this.width-211, this.height-100, 100 );
}
