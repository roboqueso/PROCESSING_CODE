//  Load HTML from webpage and spit out a design
size( 1024, 768);  //TODO: final output : 1024 x 768
background(-1);

String url = "http://www.ericfickes.com";

String[] webData  = loadStrings( url );

int xx = 0;
float x = 0;
float y = 0;
float radius = 75;



for ( xx = 0; xx <= webData.length-1; xx++) 
{
  
  strokeWeight( random(7) );
  noFill();
//  noTint();

  x = (width/2) - radius * ( cos( xx+frameCount ) * (HALF_PI / 180) );
  y = (height/2) - radius * ( sin( xx+frameCount ) * (HALF_PI / 180) );

  x = x%width;
  y = y%height;

  stroke( random(210), random(240), random(240) );
  	point(x,y);
	point(y,x);


  ellipse( x, y, webData[xx].length()+xx, webData[xx].length()+xx );
  fill(webData[xx].length());
  text("get better", x, y);
  
  
  //  show text from web
  fill(webData[xx].length()%255);
  text( webData[xx], random(x), xx*HALF_PI%height );
  text( webData[xx], random(y), xx*TWO_PI%height );
}



//  add words
text("ERICFICKES.COM", 1200, 600); 

//  save to png
save( split( this.toString(), "[")[0] + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
