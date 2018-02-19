//
//  Pattern inspired by the MCP
//
Boolean isFinal = true;

int alf = 37;

int cX;
int cY;

float shapeSize = 100;

int mcpStartX = 0;
int mcpStartY = 0;

int mcpWidth = 90;

int siloHeight = 666;  // currently used for top and bottom

float strokeSize = 98;  //69;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(9);

  //  setup variables
  cX = width/2;
  cY = height/2;

  mcpWidth = width;

}


////////////////////////////////////////////////////
//
void draw()
{
  
// triangle circle - http://processing.org/learning/basics/trianglestrip.html

float outerRad = mcpWidth*4;
float innerRad = 69;
float px = 0, py = 0, angle = 0;
float pts = 69;  //18;
float rot = 360.0/pts;

//noFill();

//fill( 9, alf*2 );
noFill();

beginShape(TRIANGLE_STRIP); 
for (int i = 0; i < pts; i++) {
  smooth();
  
  // inner
  strokeWeight( random(100) );
  randStroke();  

  px = cX + cos(radians(angle))*innerRad;
  py = cY + sin(radians(angle))*innerRad;
  vertex(px, py); 
  angle += rot;
  
  // outer
  strokeWeight( random(shapeSize/2) );

//randStroke();  
stroke( #EFEF69, alf );

  px = cX + cos(radians(angle))*outerRad;
  py = cY + sin(radians(angle))*outerRad;
  angle += rot;
  vertex(px, py);
}
endShape();
// end sun triangle ------------------
  
  
  // MCP grid ------ >< -------
//  stroke(#75EF19, alf );  //36EF63
  strokeWeight(strokeSize);

  for( float tt = 0; tt <= mcpWidth; tt += shapeSize ) {
    smooth();
        
    stroke(0, (alf*7) );
    // silo top
    line( mcpStartX+tt, 0, mcpStartX+tt, siloHeight );

    //  TOP center
    stroke(#EE0000, alf);
    line( mcpStartX+tt, 0, cX, cY );
    
    stroke(#EFEF19, alf);
    line( (mcpStartX+mcpWidth)-tt, height-siloHeight, cX, cY );
      
    //  CENTER down
    stroke(#75EF19, alf);
    line( (mcpStartX+mcpWidth)-tt, height , cX, cY );

    smooth();
    stroke(#1975EF, alf);
    line( cX, cY, mcpStartX+tt, siloHeight );

    stroke(0, (alf*7) );
    //  silo bottom
    line( (mcpStartX+mcpWidth)-tt, height-siloHeight, (mcpStartX+mcpWidth)-tt, height );
  }
  //  end MCP ----------------------

exit();
  
}





///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{   
  artDaily("ERICFICKES.COM" );

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + fix.getTimestamp() + ".png" );
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
  
  smooth();
  textFont( font );
  strokeWeight(1);

  stroke( #75EF19, 666 );
  text( " "+dailyMsg, this.width-240, this.height-20);
}



///////////////////////////////////////////////////////////
//  
//  draw heart
void heart( int x, int y, int w, int h ) 
{
  ellipseMode(RADIUS);
  smooth();

  //  stroke(#EF7519, alf);  // 37
  stroke(#EF1111, alf);  // 37

  strokeWeight(2);
  //  noFill();

  //  bubbles
  ellipse( x-w, y, w, w);
  ellipse( x+w, y, w, w);
  //  ellipseMode(MODE)
  //  MODE	Either CENTER, RADIUS, CORNER, or CORNERS


  //  lines	
  line( x-(w*2), y, x, y + w*PI);
  line( x+(w*2), y, x, y + w*PI);
}

