Boolean isFinal = true;
int ctMAIN = 0;
float alf = 13;

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

color[] p1 = { 
 #131213, #3c3b3c, #3d3c3d, #494849, #3f3c3e, #383637, #706e6f, #333132, #3d3b3c, #161616, #201f1f, #222222, #2a2828, #2e2d2d, #2f2e2e
 
  };
color[] p2 = { 
 
 #2C0E0F,#C98599,#F6EDF9,#6C2C2A,#50262B,#966576,#926E89,#BB8595,#CD91AB,#905869,#BC7B95,#8F4D52,#EB774C,#AD4932,#AA6878,#BA7379,#B76A79,#AF534D,#CA8589,#734650,#C87477,#EB8969,#D68674,#B28DAE,#C67B94,#613540,#D3B6D8,#F28753,#B46751,#CE562E,#DC7457,#C96769,#DA7865,#745268,#481411,#AB7388,#D96535,#8C3428,#DA6946,#AB6B85,#EA6B36,#AB5965,#BA6767,#CB7568,#B66B84,#CB6856,#D86A55,#A86667,#D88789,#D7A4B3,#B69DC7,#A67895,#C96A74,#D8979A,#76678B,#C55845,#6A221B,#F8A674,#A97579,#9988B0,#D38A95,#CA6545,#B78576,#F0AB8E,#D77B87,#D98757,#D87976,#E87B60,#BA7466,#7E6377,#DC7445,#946456,#CB9699,#E8B3B8,#9278A1,#EC9783,#9B8595,#3F191E,#CA7557,#55211F,#5B404E,#D8A796,#DB9683,#A97DA6,#CA491D,#5F1712,#A67565,#753D3A,#F4823C,#C79588,#C67544,#BBA6BC,#D26B65,#5E4A63,#E35C29,#8A3F40,#F8A55C,#865E82,#F0C5BB,#C0595F,#7D6059,#E2A076,#E19CA9,#D27B99,#E2531D,#BA3B15,#A26B90,#BB9F9B,#7F80A2,#442E3B,#C67B8C,#BD7384,#BD738C,#BD7B8C,#B57384,#B5738C,#C67B82,#C67384,#CE7B8E,#BD7C82,#CE7B81,#C6738C,#B47B8C,#B47C82,#CE7380,#CE738C,#C66B84
 
  };
////////////////////////////////////////////////////
//
void setup() {
  size(1024, 768 );
  
  //  ---------------------
  background (0);

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

      strokeWeight( 5); 
      ranPalStroke(p1);
      ellipse( xx, yy, outerXX+angle, outerYY+angle);

      ranPalStroke(p1);
      strokeWeight( 30 );
    line( xx, yy, outerXX, outerYY);

    ranPalStroke(p2);
    strokeWeight(.9);
    ellipse( xx, yy, alf, alf );
    
      ranPalStroke(p2);
      strokeWeight( random(.50) );    
      
    ellipse( xx, yy, outerYY, sin(outerXX) );
    line( xx, yy, outerYY, sin(outerXX) );
}

if( floor(angle) % 360 == 0 ) {
      radius *= 1.3;
      
      
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



