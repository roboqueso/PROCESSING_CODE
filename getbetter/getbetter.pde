//  Load HTML from webpage and spit out a design
size( 1024, 768);  //TODO: final output : 1024 x 768
background( 36, 36, 36);

//String url = "http://processing.org/learning/";
String url = "http://www.ericfickes.com";
int[] eModes = {  CENTER, RADIUS, CORNER, CORNERS};
String[] webData  = loadStrings( url );

int xx = 0;
int eMode = 0;
int StartAngle = 15;
float conPI = 3.14;
float x = 0;
float y = 0;
float radius = 0.75;



for ( xx = 0; xx <= webData.length-1; xx++) 
{
  
  strokeWeight( random(7) );
  noFill();
//  noTint();

  x = (displayHeight/2) + radius * ( cos( StartAngle ) * (conPI / 180) );
  y = (displayWidth/2) + radius * ( cos( StartAngle ) * (conPI / 180) );

  stroke( random(210), random(240), random(240) );

  eMode = eModes[ (int)random(3) ];
  //  randomly do stuff befor drawing ellipse
  ellipseMode( eMode );

  x = ( x > displayWidth ) ? 20 : x+xx * 10;
  y = ( y > displayHeight ) ? 20 : y+xx * 10;

  ellipse( x, y, webData[xx].length()*eMode, webData[xx].length()*eMode );
  text("get better", x, y);
  
  
  //  show text from web
  fill(random(255));
  text( webData[xx], random(displayWidth-x), random(displayHeight-y) );
  text( webData[xx], random(x), random(y) );
}



//  add words
text("ERICFICKES.COM", 1200, 600); 

//  save to png
save( split( this.toString(), "[")[0] + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
