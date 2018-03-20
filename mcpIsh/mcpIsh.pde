//
//  Pattern inspired by the MCP
//
Boolean isFinal = true;

int alf = 37;

int cX;
int cY;

int shapeSize = 100;

int mcpStartX = 0;
int mcpStartY = 0;

int mcpWidth = 800;

int siloHeight = 666;  // currently used for top and bottom

float strokeSize = 15;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(19);

  //  setup variables
  cX = width/2;
  cY = height/2;

  mcpStartX = cX - (mcpWidth/2);

}


////////////////////////////////////////////////////
//
void draw()
{
  // MCP grid ------ >< -------
  stroke(#75EF19, alf );  //36EF63
  strokeWeight(strokeSize);

  
  for( float tt = 0; tt <= mcpWidth; tt += shapeSize ) {

    smooth();
    // silo top
    line( mcpStartX+tt, 0, mcpStartX+tt, siloHeight );
  
    smooth();
    //  center grid
    line( mcpStartX+tt, siloHeight, (mcpStartX+mcpWidth)-tt, height-siloHeight );

    smooth();
    //  silo bottom
    line( (mcpStartX+mcpWidth)-tt, height-siloHeight, (mcpStartX+mcpWidth)-tt, height );
  }
  //  end MCP



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
  PFont font = loadFont( "BanglaMN-20.vlw" );
  
  
  textFont( font );
  strokeWeight(1);

  stroke( #75EF19, 666 );
  text( " "+dailyMsg, this.width-200, this.height-18);
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

