//
//  SineWave borrowed from http://processing.org/learning/basics/sinewave.html
//
Boolean isFinal = true;
float alf = 37;

int cX;
int cY;

int dotSize = 16;  //16;  // size of ellipse used to draw sine wave
int xspacing = 8, yspacing = xspacing;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave

float theta = 0.0;  // Start angle at 0
float amplitude = 15;  // Height of wave
float period = 100.0;  // How many pixels before the wave repeats
float dx;  // Value for incrementing X, a function of period and xspacing
float[] xvalues, yvalues;  // Using an array to store height values for the wave
float x = 0;



////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(#000000);

  //  setup variables
  cX = width/2;
  cY = height/2;

//  frameRate(30);
//  colorMode(RGB,255,255,255,100);
  smooth();
  w = width+16;
  dx = (TWO_PI / period) * xspacing;
  xvalues = new float[w/yspacing];
  yvalues = new float[w/xspacing];
}


////////////////////////////////////////////////////
//
void draw()
{

  while( x <= width ) {
    sineWave( x, x );

    x += dotSize;
//x+=5;
  }

  exit();
}

/////
//  Sine Wave grid, axii starting and supplied x and y
void sineWave( float startX, float startY ) {
  // Increment theta (try different values for 'angular velocity' here
  theta += 0.02;

// NOTE: all of this code assumes the same settings for x and yvalues

  // For every x value, calculate a y value with sine function
  float x = theta;
  float y = theta;
  for (int i = 0; i < yvalues.length; i++) {
    xvalues[i] = sin(y)*amplitude;
    yvalues[i] = sin(x)*amplitude;
    x+=dx;
    y+=dx;
    
  }

//    strokeWeight(2);
noStroke();    
//    fill(   #EF4321, alf );
    

    ellipseMode(CENTER);


  // A simple way to draw the wave with an ellipse at each location
  int yy = 0;
  for (int xx = 0; xx < yvalues.length; xx++) {
    smooth();    
    fill( #EF3369, alf);
    //  HORIZONTAL
    ellipse(xx*xspacing,startY+yvalues[xx], dotSize, dotSize);

    //  VERTICAL
//    ellipse(startX+yvalues[xx], yy*yspacing,dotSize, dotSize);
    
    yy++;
  }
}


///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void exit() 
{   
  artDaily("ERICFICKES.COM" );

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





///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  //PFont font = createFont( "Silom", 15 );
  PFont font = loadFont( "Silom-20.vlw" );
  //PFont font = loadFont("BanglaMN-20.vlw");
  
  smooth();
  textFont( font );
  strokeWeight(10);

  fill( #FFFFFF, 666 );

  text( " "+dailyMsg, this.width-240, this.height-20);
}
