//  SEE:   https://ello.co/ericfickes/post/qutcebewisvonz2c1tqskg
//  GOTO:  https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);
float cX, cY;
float x, y;
float a,b;
float amp = 234;
int alf = 45;
String msg = this.toString();
float r;
float g;
//float b;

Boolean isFinal = true;


void settings(){
  size(displayWidth, displayHeight, P3D);
  smooth(8);
}

//////////////////////////////////////////////////////////////////////////////
void setup() {  // this is run once.   
    
    background(#B0BDAD); 
    noFill();
 
    fix.alpha(alf);

    cX = width/2;
    cY = height/2;
 
//    strokeWeight(.5);

  // scan lines
  stroke(#EF0000, alf ); // 255
  for ( int ll = 0; ll <= width; ll += 2 ) 
  {  
    strokeWeight( random(1.1) );

    line( 0, ll, random(width), ll );
    line( ll, 0, ll, random(height) );
  }

} 
 
 
//////////////////////////////////////////////////////////////////////////////
void draw() {
 

    //  for(int i = 0; i < width*height; i++) {
    
    //  }
    
     
    a = cX + random(amp) * (180/PI);
    b = cY + random(amp) * (180/PI);
     
    for( int t = 0; t <= 360; t += 6 ) 
    {
    
    stroke( #EF0000, alf );
/*    
loadPixels();
    r = red(  pixels[ t] ) * 5;
    g = green(  pixels[t] ) * .25;
    b = blue(  pixels[t] ) * .25;
    
    pixels[t] = color(r, g, b);
updatePixels();
*/   
    x = cX - amp * sin(a * t * PI/180);
    y = cY - amp * sin(b * t * PI/180);
     
    point( x, y );
    point( y, x );
    
    x = ( cX - int( cos(radians(frameCount/alf)) * amp ) );
    y = ( cY - int( sin(radians(frameCount/alf)) * amp ) );
     
    point( x, y );
    point( y, x );
    
    stroke( #800813, alf );        
    try {
      line( x, y, y, x );
    } finally {
      fill(random(amp), random(amp), random(amp), alf);
      text(msg, random(width), random(height) ); 
    }
    translate(width/2, height/2);
    rotateY(map(frameCount, 0, width, -PI, PI));
    rotateX(map(frameCount, 0, height, -PI, PI));
    
    stroke(0, 255, 0);
    rotateX(x);
    rotateZ(0);
    rotateY(y-float(t)*1.305);
    
    point(t, t, 0);
    
    
    x = cX - amp * sin(a * t * TWO_PI/180) - ( cX - int( cos(radians(t/amp)) * amp ) );
    y = cY - amp * sin(b * t * TWO_PI/180) - ( cY - int( sin(radians(t/amp)) * amp ) );
     
    stroke( #0D00DE, alf );
    point( x, y );
    point( y, x );
  
  }
  

  
  x -= 0.01;
  y += 0.02;
  
  
   
  if( frameCount % 30 == 0 )
  {
    amp *= 2;
  }
   
   
  if( frameCount > height+width ) {
    textFont(createFont("Helvetica",42));
    fill(#676800);
    text("d00d", 3, height-5);
     
     if(isFinal){
       save( fix.pdeName() + fix.getTimestamp() + ".png");
     }
     
    noLoop();
    exit();
  }
 
}
