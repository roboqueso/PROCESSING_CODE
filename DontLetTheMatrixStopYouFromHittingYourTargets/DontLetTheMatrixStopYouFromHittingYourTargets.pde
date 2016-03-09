int[] nz = new int[966];
boolean gotNoise = false, isFinal = true;
boolean vert = true;
float xx=0, yy=0;

////////////////////////////////////////////////////////////////////////////////////////////////
void setup() {
  size(1024, 768);  //640, 960);
  background(#001800);
  frameRate(303);
  smooth();
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
    stroke(random(42, 255), 37, 37, 42);
  }



  stroke( 0, random(11, 50), 0);

  strokeWeight(random(TWO_PI,11));
  point(xx+cos(frameCount), yy+sin(frameCount));

  strokeWeight(1);
  line(xx+cos(frameCount)-random(42), yy+sin(frameCount), xx+random(42), yy);



  if (xx>1024||xx<-11)
  {
    xx=random(xx);

    bullsEye( xx, yy, random(42, 210));

    strokeWeight(random(11, 42));
    stroke(random(42, 96), 11, 11);
    line(1024, yy, xx, yy);

    //  draw dot core
    strokeWeight(1);
    noFill();
    for ( int dx = 1024; dx >= xx; dx-= 12 ) {
      if(int(random(2))%2==0){
        stroke(random(42, 96), 11, 11);  
      } else {
        stroke(#001100);
      }
      rect( dx, yy, 5, 5 );
    }

    //  always reset strokeWeight
    strokeWeight(1);
    stroke(random(227));
  }

  if ( frameCount>(1024+768)*21) {

    fill(#EF2012);
    textFont(createFont("Silom", 23));

    fill(#EFEFEF);

    //    TOP RIGHT CORNER-ISH ( between the time and the battery )
    text("ERICFICKES.COM", (1024/2)*1.2, 25 );  // 28

    if (isFinal) {
      save( pdeName() + getTimestamp() + ".png" );
    }
    noLoop();
  }
}







///////////////////////////////////////////////////////////////////////////////////////////////
String getTimestamp() {
  return ""+month()+day()+year()+hour()+minute()+second()+millis()+"";
}



/////////////
//  TODO: Is there a better way to get the current sketch name?
String pdeName() {
  return split( this.toString(), "[")[0];
}

///////////////////////////////////////////////////////////////////////
void bullsEye( float a, float b, float shapeSize ) {

  int tmp = (int)shapeSize;

  while (  tmp >= 0 ) {

    strokeWeight(tmp/24);
    fill(0);
    stroke(255);

    ellipse( a, b, tmp, tmp);
    tmp -= int(shapeSize/6);
  }
}

