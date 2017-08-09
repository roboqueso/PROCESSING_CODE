import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.serial.*; 
import cc.arduino.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class build extends PApplet {

int    stageW   = 1280;
int    stageH   = 928;
int  clrBG    = 0xff242424;
float cX, cY;

// String pathDATA = "../../../data/";

// *************************************************************************************************************




Serial myPort;  // Create object from Serial class

//	data from art box
String serialString;
//	duration|inches|joystickX|joystickY|joystickButtonUp
String[] box_data;	// incoming serial data
int box_angle = 11;
int box_rotaryClicked   = 1;	//	"CLICKED" = 0


PVector pv1;
int rad = 42;

// *************************************************************************************************************

public void settings() {
	size(stageW, stageH, P3D);

}


// *************************************************************************************************************
public void setup() {
	
	background(clrBG);
	strokeWeight(11);

	cX = width/2;
	cY = height*.75f;
	rad = (int)(height *.75f);


// List all the available serial ports:
printArray(Serial.list());

	myPort = new Serial(this, Serial.list()[3], 115200);
	myPort.bufferUntil(10);      // int(10)	ASCII linefeed

	delay(500);
}


// *************************************************************************************************************
public void draw() {
	// background(clrBG);


	if( box_angle > 0 ){

		pv1 = circleXY( cX, cY, rad, box_angle );

		stroke(69, frameCount%255);
		strokeWeight(1);
		line( cX, cY, pv1.x, pv1.y );
		strokeWeight(7);
		point( pv1.x, pv1.y );

	}

	//	SAVE png on click
	if( box_rotaryClicked == 0){
		
		strokeWeight(7);
		stroke(frameCount%255, 11, 11 );
		line( cX, cY, pv1.x, pv1.y );

	}


	if(frameCount >= (width+height))
	{
		stampIt( 240 );
		save(fileStamp()+".png");
		exit();
	}
}









//////////////////////////////////////////////////////////////////////////
public void stampIt( int txtSz )
{
	String msg = "SENSORS";

    textAlign(CENTER,CENTER);
    textFont( createFont("Slaytanic", 666 ));
    
	// cY -= 75;

    textSize(txtSz+15);
    fill(0);
    text(msg, cX, cY );

    textSize(txtSz+10);
    fill(100);
    text(msg, cX, cY );


    textSize(txtSz + 5);
    fill(150);
    text(msg, cX, cY );

    textSize(txtSz);
    fill(0);
    text(msg, cX-1, cY-1 );

    fill(255);
    text(msg, cX, cY );

}




/////////////////////////////////////////////////////////////////////////////
public PVector circleXY( float centerX, float centerY, float radius, float angle )
{
  return new PVector(
                centerX - PApplet.parseInt( cos(radians(angle)) * radius ),
                centerY - PApplet.parseInt( sin(radians(angle)) * radius )
                );
}


// *************************************************************************************************************
//	Read data from the art box ( broadcasting via Serial )
public void serialEvent(Serial p) 
{
	try{
	serialString = p.readString().trim();

//DEBUG
println(">>>>>>> serialEvent : " + serialString ); 

		if(serialString!="")
		{
			//	DO STUFF WITH INCOMING SERIAL DATA

			//	EX:
			//	angle|rotaryClicked
			//	duration( 10 -> 180 )|(0-1)

			box_data = split( serialString , '|');

			//	make sure we received an array
			if(box_data.length>1)
			{
				box_angle = constrain( PApplet.parseInt( box_data[0]), 11, 180 );
				box_rotaryClicked = PApplet.parseInt( box_data[1] );

			}

		}
	}
	catch(Exception exc){
		//DEBUG
		println("XXX EXCEPTION: serialEvent : " + exc ); 
	}
} 


//  return unique filename_timestamp string
public String fileStamp(){
  return split( this.toString(), "[")[0] + "_" +month()+day()+year()+hour()+minute()+millis();
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
