//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);



//  draw circles and stuff, save on exit

Boolean isFinal = true;

float r = 1;  // 75;
float theta = 0;

int cX = 0;
int cY = 0;

int alf = 42;

//color[] colors = { #EFEFEF, #1975EF, #19EF75, #EF1975 };

float ranX = 0;
float ranY = 0;

///////////////////////////////////////////////////////////
//  
void setup() {
  size( 1024, 768);
  background(19);
  smooth();

  cX = width/2;
  cY = height/2;
  
  fill(#1975EF, 100);

  //NOTE : the translate call above makes the x,y jacked up
  text( "ERICFICKES.COM", 0,0 );

}

///////////////////////////////////////////////////////////
//  
void draw() {

  
    // Polar to Cartesian conversion
    float x = (PI*r) * cos(theta);
    float y = (PI*r) * sin(theta);


      
//    noFill();
noTint();
/*
    fill( #FEFEFE, 45 );    
    ellipse( cX-x, cY-y, 10, 10);
    
    fill( #EFEFEF, 45);    
    ellipse( cX+x, cY+y, 10, 10 );
  */  
//    randStroke();
if( second() % 2 == 0 )
  stroke( 255,0,0, alf );
else if( second() % 3 == 0 )
  stroke( 0,255,0, alf  );
else if( second() % 4 == 0 )
  stroke( 0,0,255, alf  );
else if( second() % 5 == 0 )
  stroke( 200,200,200, alf  );
else if( second() % 6 == 0 )
  stroke( 100,100,100, alf  );
else if( second() % 7 == 0 )
  stroke( 50,50,50, alf  );
else if( second() % 8 == 0 )
  stroke( 25,25,25, alf  );
else if( second() % 9 == 0 )
  stroke( 5,5,5, alf  );



    noFill();
    ellipse( cX+x, cY+y, 22, 22 );

  theta  += 3.314;  
  r      += 0.1234;

  //
  if( theta >= 10000 )
  {
    doExit();
  }



}

///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{

  //  if final, save output to png
  if( isFinal )
  {
    save( fix.pdeName() + fix.getTimestamp()+".png" );
  }

  noLoop();
  exit();
}
