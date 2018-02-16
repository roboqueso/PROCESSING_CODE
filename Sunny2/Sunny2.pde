// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);
Boolean isFinal = true;
int alf = 42;


int shapeSize = 10000;
float minShapeSize = 15;
//float maxShapeSize = 100;

int cX;
int cY;


color[] palette = { 
#A59DA1,#D96D55,#F36613,#A9ABEA,#D23301,#F6FAFD,#AB6E9C,#D6F9FF,#F8751E,#768A00,#F05510,#FFEE51,#FFB02A,#D7D5FA
};

int x = 0;
int y = 0;

int ct = 0;
float maxCt = 0;

PImage img;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(#A1A1A1);  //#B4B4B4);  //#CBCBCB);
  fix.alpha(alf);
  /*
  img = loadImage( "Weather-Report-Sunny.png");
  img.loadPixels();
  image(img, 0, height-img.height);
  */
  cX = width / 2;
  cY = height / 2;

  noFill();
  smooth();

  stroke(10,alf);
  for(int yy = 0; yy < height; yy += 2 ) {
    strokeWeight( random(1.9) );
    line( 0, yy, width, yy ); 
  }

}


////////////////////////////////////////////////////
//


void draw()
{
float radius1, radius2, radius3;
float xx1, yy1, xx2, yy2, xx3, yy3, xx4, yy4;
float angle1, angle2, angle3;
float startX1, startY1, startX2, startY2, startX3, startY3;

  //  init
  float sunX = width*.6;
  float sunY = height*.55;
  float sunWidth = 400;
  
  // init 
  radius1 = sunWidth*.6;
  radius2 = sunWidth*.7;
  radius3 = sunWidth*.8;
  
  //startX1 = startX2 = startX3 = (width/2);
  startY1 = startY2 = startY3 = sunY;
  
  angle1 = 90;
  angle2 = 45;
  angle3 = 90;
  
  //  Sunny
  fill(0);
  textFont( createFont( "New", 250 ) );  // Moderna  MonaKo
  text("Sunny", cX-275, 200 );
  
  //  vertical dot bar

// debug
//line( sunX, 0, sunX, height );

  float gridX1 = sunX-150;
  float gridX2 = sunX+150;
  float gridXX, gridYY, gridCt;
  float shapeSize = 5;
  gridYY = gridCt = 0;
  gridXX = gridX1;
  boolean flip = true;

  strokeWeight(shapeSize);
  stroke(0, 200);
  
  
  while( gridCt < (gridX1 * gridX2) ) {
   
    smooth();
    
    if( !flip && gridXX >= ( gridX2-shapeSize ) )
    {
      // stop right here
    } 
    else
    {
      point( gridXX, gridYY );
    }
    
    if( gridXX >= gridX2 ) {
        flip = !flip;
      
        gridYY += (shapeSize*2);
        
      if( flip )
        gridXX = gridX1;
      else
        gridXX = gridX1 + (shapeSize*2);

    } else {
      gridXX += (shapeSize*2);
    }
    
    gridCt++; 
  }
  
  
  //  sun ellipse
  strokeWeight(50);
  fill(255, 200);
  stroke(255);
  ellipse( sunX, sunY, sunWidth, sunWidth );
  
  //  outer barbed-wire looking sun border
// draw circles
  while ( angle1 < 450 ) {
    
    smooth();
    
    xx1 = sunX - int( cos(radians(angle1)) * radius1 );
    yy1 = startY1 - int( sin(radians(angle1)) * radius1 );

    xx2 = sunX - int( cos(radians(angle2)) * radius2 );
    yy2 = startY2 - int( sin(radians(angle2)) * radius2 );

    xx3 = sunX - int( cos(radians(angle3)) * radius3 );
    yy3 = startY3 - int( sin(radians(angle3)) * radius3 );
/*
    xx4 = startX4 - int( cos(radians(angle4)) * radius4 );
    yy4 = startY4 - int( sin(radians(angle4)) * radius4 );
*/


stroke(255);

strokeWeight(10);
point( xx1, yy1 );

//strokeWeight(10);
point( xx2, yy2 );

//strokeWeight(10);
point( xx3, yy3 );
//point( xx4, yy4 );

smooth();
strokeWeight(.2);
line( xx1, yy1, xx2, yy2);
// line( xx1, yy1, xx3, yy3);
line( xx2, yy2, xx3, yy3);

    angle1 += 3;
    angle2 += 6;
    angle3 += 12;
  }
  

  //  random points coming in from the right
  float dotX, dotY;
  dotX = dotY = 0;
  
  for( int dotCt = 0; dotCt < 222; dotCt++ ) {

    dotX = lerp( cX, width*1.5, random(.9) );
    dotY = lerp( 0, height*1.5, random(.9) );

    stroke( #EFEFEF, 75 );
    strokeWeight( random( 69 ) );  

    point( dotX, dotY );

  }
  
  //  weather character?
  

  
  doExit();
}



///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{

  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
save( fix.pdeName()+".png" );
  }
  
  noLoop();
  exit();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 18 ) );
  smooth();

  //  stroke(#EFEFEF);
//  fill(#EE0000);
  //fill(#00EE00);
  fill(#EFEFEF);
  text( " "+dailyMsg, 18, this.height-18);
//  text( " "+dailyMsg, this.width*.45, this.height-18);
}


