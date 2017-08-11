import processing.video.*;
import processing.serial.*;
import cc.arduino.*;



int    stageW   = 1280;
int    stageH   = 720;
color  clrBG    = #EFEFEF;
float cX, cY;

// *************************************************************************************************************


Capture cam;

Serial myPort;  // Create object from Serial class

//	data from art box
int servoAngle,radarMS,radarIN,radarCM;
int btnUp   = 1;	//	"CLICKED" = 0

PImage texture;

PVector pv1, pv2, pv3;
int rad = 42;

// *************************************************************************************************************

void settings() {
	size(stageW, stageH, P3D);

}


// *************************************************************************************************************
void setup() {
	
	background(clrBG);
	// Pulling the display's density dynamically
	pixelDensity(displayDensity());
	smooth();

	rectMode(CORNER); 	//  CORNER, CORNERS, CENTER, or RADIUS
	strokeCap(ROUND);	//	SQUARE, PROJECT, or ROUND
	strokeJoin(ROUND);	//	MITER, BEVEL, ROUND


	//	CAMERA
	String[] cameras = Capture.list();
	if (cameras.length == 0) {
		println("There are no cameras available for capture.");
		exit();
	} else {
		println("Available cameras:");
		for (int i = 0; i < cameras.length; i++) {
		println(cameras[i]);
		}

		// The camera can be initialized directly using an 
		// element from the array returned by list():
		cam = new Capture(this, cameras[0]);
		cam.start();     
	} 


	cX = width/2;
	cY = height-95;
	rad = 42;	//	this gets set again


// List all the available serial ports:
// printArray(Serial.list());

	myPort = new Serial(this, Serial.list()[3], 115200);
	myPort.bufferUntil(10);      // int(10)	ASCII linefeed

	delay(500);
}


// *************************************************************************************************************
void draw() {
	
	if (cam.available()) 
	{ 
		// Reads the new frame
		cam.read();
		// filter(INVERT);
		texture = cam;
		tint(255, 42);
		texture.filter(INVERT);
	} 

	if( servoAngle > 0 ){

		pv1 = circleXY( cX, cY, radarMS%height, servoAngle );
		pv2 = circleXY( cX, cY-radarCM, radarCM, servoAngle );
		pv3 = circleXY( cX, cY-radarIN, radarIN, servoAngle );

		if(servoAngle%15==0)
		{
			strokeWeight(1);
			stroke(radarCM);
			line( cX, cY, pv1.x, pv1.y );

			stroke(radarMS, radarIN, radarCM );
		} else {
			stroke(servoAngle, frameCount%255);
		}


		strokeWeight(HALF_PI);
        stroke(clrBG);


        beginShape();
			

			texture(texture);

			// rotateX(radarIN);
			rotateY(radarIN);
			// rotateZ(radarIN);

		// vertex( pv1.x, pv1.y );
		vertex( pv1.x+radarIN, pv1.y+radarIN, servoAngle, pv1.x, pv1.y );
		
		// vertex( pv2.x, pv2.y );
		vertex( pv2.x+radarIN, pv2.y+radarIN, servoAngle, pv2.x, pv2.y );

		// vertex( pv3.x, pv3.y );
		vertex( pv3.x+radarIN, pv3.y+radarIN, servoAngle, pv3.x, pv3.y );


        endShape();






		strokeWeight( PI );
		stroke(radarIN, radarCM, radarMS );

		point( pv1.x, pv1.y );
		point( pv2.x, pv2.y );
		point( pv3.x, pv3.y );

	}

	//	Fire Laser
	if( btnUp == 0){
		strokeWeight( 1 );
		stroke(radarMS%255, radarIN, radarCM );
		line( pv2.x, pv2.y, pv1.x, pv1.y );
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
//
void keyPressed() {
	switch(key){
		case 's':
		{
			//	just
			save(fileStamp()+".png");
		}
		break;

		case 'e':
		{
			stampIt( 240 );
			save(fileStamp()+".png");
			exit();
		}
		break;
	}
}


/////////////////////////////////////////////////////////////////////////////
//
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

