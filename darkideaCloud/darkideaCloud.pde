//  SEE:   https://ello.co/ericfickes/post/r0lhzmhrmk4w9rjiouwjwq
//  GOTO:  https://github.com/ericfickes/FIXLIB   
import fixlib.*;

Fixlib fix = Fixlib.init(this);
//
Boolean isFinal = true;
Boolean gotZoog = false;  //  enables colored mouse follower brush
int alf = 100;
float shapeSize = 420;

int cX;
int cY;

float xx, yy;

color[] palette = {
//#A59DA1, #D96D55, #F36613, #A9ABEA, #D23301, #F6FAFD, #AB6E9C, #D6F9FF, #F8751E, #768A00, #F05510, #FFEE51, #FFB02A, #D7D5FA

//#EF0000, #00EF00, #0000EF, #EFEFEF


#EFEFEF, #EF1975, #19EF75, #1975EF, #DEFDAD, #DAD420, #420DAD, #ACEDAD, #B0000B, #B000B5, #B00B1E

};

int outerXX = 0;
int outerYY = 0;

float angle = 0;
float maxAngle;
float radius = 75;
float outerRadius;

int offsetX = 0;
int offsetY = 0;


int ct = 0;
int maxCt = 0;

void settings() {
  size(displayWidth, displayHeight, P3D);
  smooth(8);
  pixelDensity(displayDensity());
}

////////////////////////////////////////////////////
//
void setup() {
  frameRate(420);
  background(#DEFDAD);
  fix.alpha(alf);
  //  setup variables
  cX = width/2;
  cY = height/2;

  offsetX = cX;
  offsetY = cY;

  maxCt = 360 * 36;
  
  // white scan lines
    stroke(255, alf );
    for ( int ll = 0; ll <= width; ll += 2 ) 
    {  
      strokeWeight( random(alf) );
  
      line( 0, ll, width, ll );
      line( ll, 0, ll, height );
    }
}


////////////////////////////////////////////////////
//

void draw()
{
  smooth();
  strokeWeight( random(50) );
  
  xx = ( offsetX - int( cos(radians(angle)) * radius ) );
  yy = ( offsetY - int( sin(radians(angle)) * radius ) );

  outerXX = ( offsetX - int( cos(radians(angle)) * outerRadius ) );
  outerYY = ( offsetY - int( sin(radians(angle)) * outerRadius ) );
  
  stroke(random(255), alf*2);
  point(xx, yy);
  
  stroke(random(222), alf*2);
  point(outerXX, outerYY);
  
  stroke(random(199), alf);
  point( random(xx, outerXX), random( yy, outerYY ) );
  
  stroke(random(69), alf);
  point( lerp(xx, outerXX, random(.9) ), lerp( yy, outerYY, random(.9) ) );
  
    
if( angle >= maxCt ) {
  doExit();
}

if( frameCount % 45 == 0 ) {
  angle+=  TWO_PI;  //10;
  radius+= PI;  //3;
  offsetY = (int)random(displayHeight);
  offsetX = (int)random(displayWidth);
  
  stroke(random(255));
  line( xx, yy, outerXX, outerYY );
  stroke(random(255));
  line( outerXX, outerYY, offsetX, offsetY );
  
  
} else {
  angle += 5;
  
  //  wonky mouse followerr
  if(gotZoog)  zoog2();
  
}

}


//  interactive Zoog
void zoog2() {

  smooth();
  noFill();
  
  ellipseMode(CENTER);
  rectMode(CENTER);
  /*
  fix.ranPalStroke(palette);
  randFillUser();
  rect(mouseX, mouseY, alf, alf*5);
  */  
  fix.ranPalStroke(palette);
//  randFillUser();
  ellipse( mouseX, mouseY-30, 60, 60 );

  
  fix.ranPalStroke(palette);
//  randFillUser();
  ellipse( mouseX-19, mouseY-30, 16, 32 );
  ellipse( mouseX+19, mouseY-30, 16, 32 );
  
  fix.ranPalStroke(palette);
//  randFillUser();
  line( mouseX-alf, mouseY+(alf*5), pmouseX-alf, pmouseY+(alf*5));
  line( mouseX+alf, mouseY+(alf*5), pmouseX-alf, pmouseY+(alf*5));  
}












void zoog() {

  ellipseMode(CENTER);
  rectMode(CENTER);
  stroke(0);
  fill(150);
  rect(100, 100, 20, 100 );
  fill(255);
  ellipse(100, 70, 60, 60);
  fill(0);
  ellipse(81, 70, 16, 32 );
  ellipse(119, 70, 16, 32);
  stroke(0);
  line(90, 150, 80, 160);
  line(110, 150, 120, 160);
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
    save( fix.pdeName() + fix.getTimestamp() + ".png" );
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
  fill(#EE0000);
  text( " "+dailyMsg, this.width*.45, this.height-18);
}
