//
//  SineWave borrowed from http://processing.org/learning/basics/sinewave.html
//
Boolean isFinal = true;
int alf = 37;

int cX;
int cY;


int xspacing = 8;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave

float theta = 0.0;  // Start angle at 0
float amplitude = 5.0;  // Height of wave
float period = 100.0;  // How many pixels before the wave repeats
float dx;  // Value for incrementing X, a function of period and xspacing
float[] yvalues;  // Using an array to store height values for the wave
float x = 0;



////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024,768);
  background(66,111,66);

  //  setup variables
  cX = width/2;
  cY = height/2;

  frameRate(30);
  colorMode(RGB,255,255,255,100);
  smooth();
  w = width+16;
  dx = (TWO_PI / period) * xspacing;
  yvalues = new float[w/xspacing];
}


////////////////////////////////////////////////////
//
void draw()
{
  while( x <= height+alf ) {
    sineWave( x );
    x += alf;
  }
  exit();
}

/////
//  Draw a sine wave across the width of the screen
//  starting at the supplied startY position
void sineWave( float startY ) {
  // Increment theta (try different values for 'angular velocity' here
  theta += 0.02;

  // For every x value, calculate a y value with sine function
  float x = theta;
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = sin(x)*amplitude;
    x+=dx;
  }

  // A simple way to draw the wave with an ellipse at each location
  for (int xx = 0; xx < yvalues.length; xx++) {
    noStroke();
//    fill(255,50);
    fill( #EFEFEF, alf );
    ellipseMode(CENTER);
    ellipse(xx*xspacing,startY+yvalues[xx],16,16);
    //  width/2
  }
}

void calcWave() {

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
    save( split( this.toString(), "[")[0] + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
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

  smooth();
  textFont( createFont( "American Typewriter", 15 ) );
  strokeWeight(10);

  fill( #FFFFFF, 666 );

  text( " "+dailyMsg, this.width-240, this.height-20);
}
