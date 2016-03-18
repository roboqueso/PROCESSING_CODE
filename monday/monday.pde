//  Load HTML from webpage and spit out a design
size( 1024, 768);  //TODO: final output : 1024 x 768
background( 1, 2, 3);

String url = "http://processing.org/learning/";
int[] eModes = {  
  CENTER, RADIUS, CORNER, CORNERS
};
//int[] tModes = {MODEL, SCREEN };  //, SHAPE};
String[] webData  = loadStrings( url );

//  
//  Set this to true when you want to save
//  this script to png
Boolean isFinal = true;
String outputFileName = "monday.png";
int xx = 0;
int eMode = 0;
int StartAngle = 15;
float conPI = 3.14;
float x = 0;
float y = 0;
float radius = 0.75;

int textX = 0;
int textY = 10;
String html;

for ( xx = 0; xx <= webData.length-1; xx++) 
{
  html = webData[xx];

  if ( html.length() > 0 ) {

    x = (this.width/2) + radius * cos(StartAngle);
    y = (this.height/2) + radius * sin(StartAngle);

    if ( textY >= this.height )
    {
      textX += ((this.width/2)*0.5);
      textY = 0;
    } 
    else {
      textY += 10;
    }

    fill( random(xx), random(xx), random(xx), 100 );
    text( html, textX, textY);  

    //  randomly do stuff befor drawing ellipse
    stroke( random(255), random(255), random(255) );
    noFill();
    ellipseMode( eModes[ (int)random(3) ] );
    ellipse( x, y, html.length()+random(xx), html.length()+random(xx) );
  }
}


fill( 200, 255, 200, 100 );
//  add words
text("ERICFICKES.COM", 0, height-11); 

if ( isFinal ) {
  //  save to png
  save( outputFileName );
}

