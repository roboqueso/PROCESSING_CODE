import de.voidplus.leapmotion.*;

LeapMotion leap;

int sz = 100;

ArrayList<PVector> points = new ArrayList<PVector>();

PImage fire1, fire2, fire3, fire4;
PImage imgTexture = new PImage();

int colorTheme;

float   hand_roll;
float   hand_pitch;
float   hand_yaw;
float   hand_time;


PGraphics container;


void setup()
{
  size(2560, 1920, P3D);
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


// TODO: ADJUST DIMENSIONs
  container = createGraphics(width,height,P3D);
}


void draw()
{
  



if(frameCount%15==0)
{
  // HANDS
  for(Hand hand : leap.getHands()){

    
    // hand_roll        = hand.getRoll();
    // hand_pitch       = hand.getPitch();
    // hand_yaw         = hand.getYaw();
    // hand_time        = hand.getTimeVisible();

	points.add( hand.getPosition() );
	points.add( hand.getSpherePosition() );

    // FINGERS
    for(Finger finger : hand.getFingers()){
      
      points.add( finger.getPosition() );
      points.add( finger.getStabilizedPosition() );

    }
    
	points.add( hand.getStabilizedPosition() );
 
    
  }


  	container.beginDraw();
  	// container.background(255,10);
	container.noStroke();
	container.noFill();
	container.smooth();
  	
  	container.beginShape(POLYGON);

  	//	set color and texture
	switch(colorTheme)
	{

		case 1:

		// blue
		imgTexture = fire1;
		container.tint( random(20,40), random(40,60), random(80,160) );
		break;

		case 2:
		imgTexture = fire2;
		container.tint( #EF6900 );
		break;

		case 3:

		// pink
		imgTexture = fire3;
		container.tint(#EF1975);
		break;

		case 4:

		// green
		imgTexture = fire4;
		container.tint( random(20,40), random(200,215), random(11));
		break;

		default:
			imgTexture = fire1;
			container.noTint();
		break;
	}

	container.texture(imgTexture);

    for( PVector pt : points ){

      container.vertex(pt.x, pt.y, pt.z, random(imgTexture.width), random(imgTexture.height));

    }
  	container.endShape();
	points.clear();  


	container.endDraw();

	image(container,0,0);
  
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


  // case 'r':
  //   // save(pdeName() + getTimestamp() + ".png");
  //   saveHiRes(2);
  // break;

  case 's':
    // save(pdeName() + getTimestamp() + ".png");
    container.save( pdeName() + getTimestamp() + "_BIG2.tiff");
  break;

  case ESC:
    // save(pdeName() + getTimestamp() + ".png");
    container.save( pdeName() + getTimestamp() + "_BIG2.tiff");
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


