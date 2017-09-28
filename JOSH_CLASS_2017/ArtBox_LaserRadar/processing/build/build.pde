int    stageW   = 1280;
int    stageH   = 928;
color  clrBG    = #242424;
float cX, cY;

// String pathDATA = "../../../data/";

// *************************************************************************************************************

import processing.serial.*;
import cc.arduino.*;

Serial myPort;  // Create object from Serial class

//	data from art box
int servoAngle,radarMS,radarIN,radarCM;
int btnUp   = 1;	//	"CLICKED" = 0


PVector pv1;
int rad = 42;

// *************************************************************************************************************

void settings() {
	size(stageW, stageH, P3D);

}


// *************************************************************************************************************
void setup() {
	
	background(clrBG);
	strokeWeight(11);

	cX = width/2;
	cY = height-95;
	rad = 42;	//	this gets set again


// List all the available serial ports:
printArray(Serial.list());

	myPort = new Serial(this, Serial.list()[3], 115200);
	myPort.bufferUntil(10);      // int(10)	ASCII linefeed

	delay(500);
}


// *************************************************************************************************************
void draw() {
	// background(clrBG);
// servoAngle|btnUp|radarMS|radarIN|radarCM

	if( servoAngle > 0 ){

		pv1 = circleXY( cX-radarIN, cY-radarCM, radarMS%height, servoAngle );

		stroke(servoAngle, frameCount%255);
		
		strokeWeight(1);
		line( cX, cY, pv1.x, pv1.y );

		strokeWeight( random(radarIN) );
		point( pv1.x, pv1.y );

	}

	//	SAVE png on click
	if( btnUp == 0){
		
		strokeWeight( random(PI, TWO_PI ) );
		stroke(radarMS, radarIN, radarCM );
		line( cX, cY, pv1.x, pv1.y );

	}


	//	SKETCH END & SAVE
	if(frameCount >= (width+height))
	{
		stampIt( 240 );
		save(fileStamp()+".png");
		exit();
	}
}









//////////////////////////////////////////////////////////////////////////
void stampIt( int txtSz )
{
	String msg = "SENSORS";

    textAlign(CENTER,CENTER);
    textFont( createFont("Slaytanic", 666 ));
    
    //	TODO : tweak SENSORS position
    //	actual middle?
	cY -= 95;

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
PVector circleXY( float centerX, float centerY, float radius, float angle )
{
  return new PVector(
                centerX - int( cos(radians(angle)) * radius ),
                centerY - int( sin(radians(angle)) * radius )
                );
}


// *************************************************************************************************************
//	Read data from the art box ( broadcasting via Serial )
void serialEvent(Serial p) 
{
	//	sketch doesn't need to know about these vars
	String serialString;
	String[] box_data;	// incoming serial data

	try
	{
	serialString = p.readString().trim();

//DEBUG
println("_____serialEvent : " + serialString ); 

		if(serialString!="")
		{
			//	DO STUFF WITH INCOMING SERIAL DATA

			//	EX:
		    //  servoAngle|btnUp|radarMS|radarIN|radarCM
		    //  EX: 12|1|4884|33|83
			box_data = split( serialString , '|');

			//	make sure we received an array
			//	Don't parse until you get expected Array length
			if(box_data.length==5)
			{
				//	servoAngle|btnUp|radarMS|radarIN|radarCM
				servoAngle = int( box_data[0] );
				btnUp = int( box_data[1] );
				radarMS = int( box_data[2] );
				radarIN = int( box_data[3] );
				radarCM = int( box_data[4] );

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

