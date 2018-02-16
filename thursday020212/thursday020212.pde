Boolean isFinal = true;

float r = 12; 
float theta = .12;

int cX = 0;
int cY = 0;

int alf = 100.00;

///////////////////////////////////////////////////////////
//  
void setup() {
  size( 1024, 768);
  background(r);
  smooth();
  
  rectMode(CENTER);
  stroke( r, r, r );
  strokeWeight(1);
  
  cX = width/2;
  cY = height/2;
}

///////////////////////////////////////////////////////////
//  
void draw() {
  
  // Polar to Cartesian conversion
  float x = r * cos(theta);
  float y = r * sin(theta);
  
  
  //  color adjuster
  // if( r <= 300 )
  if(frameCount%3==0)
  {
    stroke( r*noise(frameCount), random(r*noise(frameCount)), random(r*noise(frameCount)), alf );
  }
  // else if( r <= 600 )
  else if(frameCount%4==0)
  {
    stroke( random(r*noise(frameCount)), r*noise(frameCount), random(r*noise(frameCount)), alf );
  }
  else if(frameCount%5==0)
  {
    stroke( random(r*noise(frameCount)), random(r*noise(frameCount)), r*noise(frameCount), alf );
  }
  else
  {
    stroke( random(r), random(r),  random(r), alf );
  }
    
  noFill();
  
  
  rect( x + cX, y + cY, r, r );


  theta += 1;
  r += 1;

  if( r % 6 == 0 )
  {
    alf -= 0.5;
  }

  //
  if( r >= 1000 )
  {
    exit();
  }
  
}



///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void exit() 
{
  stroke(255, 255, 255);
  text( "ERICFICKES.COM", 0, height-11);

  //  if final, save output to png
  if( isFinal )
  {
  save( split( this.toString(), "[")[0] + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
  }

  super.stop();
}
