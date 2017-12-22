/*
Remember before running

  1. Get LEAP drivers
    https://www.leapmotion.com/setup/

  2. Get LEAP P5 driver
    Sketch > Import > Add Library
    filter for LEAP
*/


import de.voidplus.leapmotion.*;

LeapMotion leap;

int sz = 100;

ArrayList<PVector> points = new ArrayList<PVector>();

PImage fire1, fire2, fire3, fire4;
PImage imgTexture = new PImage();

int colorTheme;

Boolean isHandMode = false;

void setup()
{
  size(displayWidth, displayHeight, P3D);
  background(255);
  smooth();
  noFill();
  noStroke();
  
  fire1 = loadImage("fire1.png");
  fire2 = loadImage("fire2.png");
  fire3 = loadImage("fire3.png");
  fire4 = loadImage("fire4.png");
    
  leap = new LeapMotion(this);

  imgTexture = fire1;

}


void draw()
{
  
if(isHandMode){
  background(255);
}


if( (!isHandMode && frameCount%15==0) || (isHandMode) )
{
  // HANDS
  for(Hand hand : leap.getHands()){

  points.add( hand.getPosition() );
  points.add( hand.getSpherePosition() );

    // FINGERS
    for(Finger finger : hand.getFingers()){
      
      points.add( finger.getPosition() );
      points.add( finger.getStabilizedPosition() );

    }
    
  points.add( hand.getStabilizedPosition() );
     
  }
  noStroke();
  noFill();
  smooth();
    
    beginShape(POLYGON);

    //  set color and texture
  switch(colorTheme)
  {

    case 1:

    // blue
    imgTexture = fire1;
    tint( random(20,40), random(40,60), random(80,160) );
    break;

    case 2:
    imgTexture = fire2;
    tint( #EF6900 );
    break;

    case 3:

    // pink
    imgTexture = fire3;
    tint(#EF1975);
    break;

    case 4:

    // green
    imgTexture = fire4;
    // 173-255-47
    tint( random(75,175), random(200,255), random(11,50));
    break;

    default:
      imgTexture = fire1;
      noTint();
    break;
  }

  texture(imgTexture);

    for( PVector pt : points ){

      vertex(pt.x, pt.y, pt.z, random(imgTexture.width), random(imgTexture.height));

    }
    endShape();
  points.clear();  

  
  }




}





////// S SAVE HANDLER /////////

void keyPressed(){
switch(key)
{


  case '1':
    colorTheme = 1;
  break;

  case '2':
    colorTheme = 2;
  break;

  case '3':
    colorTheme = 3;
  break;

  case '4':
    colorTheme = 4;
  break;

  case '5':
    colorTheme = 0;
  break;


  case 'h':
    isHandMode = !isHandMode;
  break;

  case 's':
    save(pdeName() + getTimestamp() + ".png");

  break;

  case ESC:
    save(pdeName() + getTimestamp() + ".png");

    exit();
  break;
}


} 




public String getTimestamp() {
  return ""+month()+day()+year()+hour()+minute()+millis();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?
public String pdeName() {
  return split( this.toString(), "[")[0];
}