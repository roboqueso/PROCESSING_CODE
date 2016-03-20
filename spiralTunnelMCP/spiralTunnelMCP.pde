// circles
Boolean isFinal = true;
int ctMAIN = 0;
float alf = 11;

int cX;
int cY;
int xx = 0;
int yy = 0;

int outerXX = 0;
int outerYY = 0;

int cubeSize = 69;

float angle = 359;
float maxAngle;
float maxCir;
float radius = 111;
float outerRadius;

int offsetX = 0;
int offsetY = 0;

////////////////////////////////////////////////////
//
void setup() {
  // size to match image
  size(1024, 768);
  frameRate(303);
  background(0,0,18);

  //  -------------------------------------------


  smooth();

  cX = int( this.width / 2 );
  cY = int( this.height / 2 );

  xx = -cubeSize;
  yy = xx;  

  offsetX = 450;
  offsetY = 450;

  //  max angle = where does the circle stop?
  maxAngle = 360 * 20;  //19;
  maxCir = 360 * 10;

  outerRadius = pow(radius, PI);  //pow( radius, 2 );

  noFill();
  
  
  

  // MCP grid ------ >< -------
  stroke(#FF1919, pow(alf,2.5) );

  //  for( float tt = (cubeSize*4); tt <= (this.width-(cubeSize*4)); tt += cubeSize ) {
  float pad = (cubeSize*4);

  for( float tt = pad; tt <= this.height-pad; tt += cubeSize ) {
    
    // silo top
    smooth();
    strokeWeight(2);
    line( 0, tt, angle*.75, tt );

    //  center grid
    smooth();
    strokeWeight(cubeSize*1.5);
    line( angle*.75, tt, this.height-(angle*.75), tt );
    
  
    //  silo bottom
    smooth();    
    strokeWeight(2);
    line( this.height-(angle*.75), tt, this.width, tt);
  }

// debug
exit();

  strokeWeight(1.5);

}


////////////////////////////////////////////////////
//
void draw()
{
  smooth();
  xx = ( offsetX - int( cos(radians(angle)) * radius ) );
  yy = ( offsetY - int( sin(radians(angle)) * radius ) );

  outerXX = ( offsetX - int( cos(radians(angle)) * outerRadius ) );
  outerYY = ( offsetY - int( sin(radians(angle)) * outerRadius ) );

  if( angle > maxCir ) 
  {


    if( frameCount % 3 == 0 ) {
      smooth();
      stroke(#19EF75,alf);
      strokeWeight( random(12) );
      line( xx, yy, outerXX, outerYY );

    }

  
  } 
  else 
  {

    smooth();
    ellipse( xx, yy, radius, radius);


  }

  if ( angle >= maxAngle )
  {
    exit();
  }

  angle += 12;
}





///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void exit() 
{   
  artDaily("ERICFICKES.COM" );


  //  if final, save output to png
  if ( isFinal )
  {
    save( this + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
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

  PFont font = createFont( "Silom", 15 );
  textFont( font );
  strokeWeight(1);

  stroke( #75EF19, 666 );
  text( " "+dailyMsg, this.width-185, this.height-18);
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


















/*
///////////////////////////////////////////////////////////
 //  
 //  Spits the installed list of fonts out in a grid
 void fontGrid() 
 {
 fill(255);
 stroke(255);
 String[] fontList = PFont.list();
 int x = 10;
 int y = 10;
 PFont font;
 
 for( int ct = 0; ct <= fontList.length-1; ct++ ){   
 
 
 // load it & show it
 font = createFont( fontList[ct], 18);
 textFont( font );
 
 text(fontList[ct], x, y);
 
 if( ct % 55 == 0)
 {
 x += 330;
 y = 0;
 }
 else
 {
 y += 20;
 }
 
 }
 
 }
 */
