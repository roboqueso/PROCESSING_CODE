Boolean isFinal = true;
int ctMAIN = 0;
int alf = 13;

int cX;
int cY;
int xx = 0;
int yy = 0;

int outerXX = 0;
int outerYY = 0;

int pad = 69;
int cubeSize = 50;

float angle = 0;
float maxAngle;
float radius = 36;
float outerRadius;

int offsetX = 0;
int offsetY = 0;

color[] p1 = { #EF0000, #00EF00, #0000EF, #CECE00, #FA7680, #EF1975, #007007, #EFEF00, #FA9187, #007007, #109109, #123123,#19EF57,#19EF19 };
color[] p2 = { #EF0000, #800813 };
////////////////////////////////////////////////////
//
void setup() {
  size(1024, 768 );
  
  //  ---------------------
  background (18);

  smooth();
  noFill();

  cX = int( this.width / 2 );
  cY = int( this.height / 2 );

  xx = -cubeSize;
  yy = xx;  

  strokeWeight( .5 );

  offsetX = 400;
  offsetY = 400;
  
  //  max angle = where does the circle stop?
  maxAngle = 10000;

  outerRadius = width*height;

}


////////////////////////////////////////////////////
//
void draw()
{
  smooth();
  noFill();
  
  xx = ( offsetX - int( cos(radians(angle)) * radius ) );
  yy = ( offsetY - int( sin(radians(angle)) * radius ) );
  
  outerXX = ( offsetX - int( cos(radians(angle)) * outerRadius ) );
  outerYY = ( offsetY - int( sin(radians(angle)) * outerRadius ) );


if( frameCount % 3 == 0 ) {
  
      strokeWeight( random(alf) );
      //stroke( #1975EF, alf );
      randStroke();
      ellipse( xx, yy, random(outerXX), random(outerYY) );

      strokeWeight( 50); 
      ranPalStroke(p1);
      line( xx, yy, outerXX+angle, outerYY+angle);

      ranPalStroke(p1);
      strokeWeight( 30 );

    line( xx, yy, outerXX, outerYY);

    
      ranPalStroke(p2);
      strokeWeight( random(50) );    
    line( yy, xx, outerYY, outerXX);
}

if( floor(angle) % 360 == 0 ) {
      radius *= 1.2;
      
      
      if(radius>height){
        radius=100;
      }
      outerRadius += alf;
}


angle += random(alf);

  if ( angle >= maxAngle )
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
    save( pdeName() + "-" + getTimestamp()+".png" );
  }

  super.stop();
}

//////////////////////////
int f0 = 0;
int f1 = 1;
//int f2 = 1;

int nextFib( int f2)
{
  //   int result = f2;
  f0 = f1;
  f1 = f2;
  f2 = f0 + f1;

  return f0 + f1;
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
void ranPalStroke(color[] palette)
{
  // pallete
  stroke( palette[ int(random( palette.length-1 )) ], alf );
}
void ranPalStroke100(color[] palette)
{
  // pallete
  stroke( palette[ int(random( palette.length-1 )) ], 100 );
}

void ranPalFill(color[] palette)
{
  fill( palette[ int(random( palette.length-1 )) ], alf );
}


///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  PFont font = createFont( "Silom", 15 );
  textFont( font );
  strokeWeight(1);

  stroke( #75EF19, 666 );
  text( " "+dailyMsg, this.width-175, this.height-15);
}




String getTimestamp() {
  return ""+month()+day()+year()+hour()+second()+millis();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?
String pdeName() {
  return split( this.toString(), "[")[0];
}



