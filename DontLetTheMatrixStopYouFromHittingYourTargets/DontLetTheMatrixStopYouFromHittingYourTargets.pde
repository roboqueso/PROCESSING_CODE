//  SEE:   https://ello.co/ericfickes/post/283qzseyxxm0dvdjidfg5a
//  GOTO:  https://github.com/ericfickes/FIXLIB 
import fixlib.*;


Fixlib fix = Fixlib.init(this);

int[] nz = new int[966];
boolean gotNoise = true, isFinal = true;
boolean vert = true;
float xx=0, yy=0;

////////////////////////////////////////////////////////////////////////////////////////////////
void settings(){
  size(displayWidth, displayHeight, P3D);
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}


////////////////////////////////////////////////////////////////////////
void setup() {

  background(#DAD411);  //#001800);
  frameRate(303);
  noFill();
  rectMode(CENTER);
  strokeWeight(1);
}


////////////////////////////////////////////////////////////////////////////////////////////////
void draw() {

  if (frameCount< 966 ) {
    nz[frameCount-1] = int(random(-11, 11)*noise(frameCount));
  }


  // move
  if (yy<960) {
    xx += nz[int(yy)]*noise(random(PI))+PI;
    yy += 11;
  } 
  else {
    yy =0;
    xx += 21;
    stroke(random(45, 220), 45, 45, 45);
    //stroke(#CCEF20,42);
  }


  stroke(random(180));
  //stroke( 75, 45,random(11, 75) );
  //stroke(#242424);

  strokeWeight(random(TWO_PI,11));
  point(xx+cos(frameCount), yy+sin(frameCount));

  stroke(random(255));
  strokeWeight(1);
  line(xx+cos(frameCount)-random(42), yy+sin(frameCount), xx+random(42), yy);



  if (xx>displayWidth||xx<-11)
  {
    xx=random(xx);

    fix.bullsEye( xx, yy, random(42, 210));

    strokeWeight(random(11, 45));
    stroke(75, 11, random(45, 99));
    //stroke(#DAA520);
    line(displayWidth, yy, xx, yy);

    //  draw dot core
    strokeWeight(1);
    noFill();
    for ( int dx = displayWidth; dx >= xx; dx-= 12 ) {
      if(int(random(2))%2==0){
        stroke(11, random(42, 96), 11);
      } else {
        stroke(#420DAD);
      }
      rect( dx, yy, 5, 5 );
    }

    //  always reset strokeWeight
    strokeWeight(1);
    stroke(random(222));
  }

  if ( frameCount>(displayWidth+displayHeight)*11 ) {

    fill(#EF2012);
    textFont(createFont("Silom", 24));

    fill(#EFEFEF);

    //    TOP RIGHT CORNER-ISH ( between the time and the battery )
    text("ERICFICKES.COM", (displayWidth/2)*1.2, 25 );  // 28

    if (isFinal) {
      save( fix.pdeName() + fix.getTimestamp() + ".tif" );
    }
    noLoop();
    exit();
  }
}
