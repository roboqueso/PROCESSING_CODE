
// https://github.com/ericfickes/FIXLIB	
import fixlib.*;

Fixlib fix = Fixlib.init(this);
int    stageW   = 1280;
int    stageH   = 928;
color  clrBG    = #424242;
float cX, cY;

// String pathDATA = "../../../data/";

float xx, yy, xx2, yy2,angle, angle2, sw = 12;
Boolean dec = false;
int decStop = 0, decAmt = 9;


// *************************************************************************************************************

import processing.serial.*;
import cc.arduino.*;

Serial myPort;  // Create object from Serial class

//	data from art box
int servoAngle,radarMS,radarIN,radarCM;
int btnUp   = 1;	//	"CLICKED" = 0


PVector pv1, pv2;
int rad = 42;

// *************************************************************************************************************

void settings() {
	size(stageW, stageH);//, P3D);

}


// *************************************************************************************************************
void setup() {
	
	background(clrBG);
	strokeWeight(11);
	smooth();

	noFill();


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
	


	if( servoAngle > 0 ){

		pv1 = fix.circleXY( cX, cY, radarMS%height, servoAngle );
		pv2 = fix.circleXY( cX-radarIN, cY-radarIN, radarIN%height, servoAngle );

		if(servoAngle%15==0)
		{
			strokeWeight(PI);
			stroke(radarMS, radarIN, radarCM, radarIN);

			line( cX, cY, pv1.x, pv1.y );


		} else {
			strokeWeight(HALF_PI);
			stroke(servoAngle, radarIN, radarCM%255);
		}


		strokeWeight(.5);
		stroke(servoAngle, radarIN);
		line( pv1.x, pv1.y, pv2.x, pv2.y );
		line( cX, cY, pv2.x, pv2.y );

		strokeWeight( PI );
		stroke( radarMS%255 );
		point( pv1.x, pv1.y );
		strokeWeight( HALF_PI );
		stroke(radarIN, radarCM, radarMS );
		point( pv1.x, pv1.y );


		strokeWeight( PI );
		stroke( radarMS%255 );
		point( pv2.x, pv2.y );
		strokeWeight( HALF_PI );
		stroke(radarIN, radarMS, radarCM );
		point( pv2.x, pv2.y );



rad = radarIN%90;

	xx = cX - int( cos(radians(servoAngle)) * rad );
	yy = cY - int( sin(radians(servoAngle)) * rad );

	xx2 = cX - int( cos(radians(servoAngle)) * rad );
	yy2 = cY - int( sin(radians(servoAngle)) * rad );


	stroke(radarMS, radarCM, radarIN);
	hexagon( pv1.x, pv1.y, rad/PI);//rad, servoAngle2/(rad/sw) );
	hexagon( pv2.x, pv2.y, rad/TWO_PI);//, rad, servoAngle2/(rad/sw) );

	stroke(frameCount%2==0?0:255);
    star( 5, 
          pv1.x, pv1.y, 
          rad/HALF_PI,rad/HALF_PI, 
          rad/HALF_PI,
          random(0.2, 0.9) * cos(HALF_PI / servoAngle) );



	stroke(frameCount%2==0?0:255);
    star( 5, 
          pv2.x, pv2.y, 
          rad/PI,rad/PI, 
          rad/PI,
          random(0.2, 0.9) * cos(PI / servoAngle) );




	}

	//	Fire Laser
	if( btnUp == 0){
		strokeWeight( radarIN%TWO_PI );
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
			save(fix.pdeName()+fix.getTimestamp()+".png");
		}
		break;

		case 'e':
		{
			doExit();
		}
		break;
	}
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


/////////////////////////////////////////////////////////////////////////////
//
void doExit()
{
	stampIt( 240 );
	save(fix.pdeName()+fix.getTimestamp()+".png");
  
	noLoop();
	exit();
}



//////////////////////////////////////////////////////////////////////////
void lasers()
{
    textAlign(CENTER,CENTER);
    textFont( createFont("Slaytanic", 666 ));
    
	cY -= 75;

    textSize(555);
    fill(0);
    text("LASERS", cX, cY );

    textSize(550);
    fill(100);
    text("LASERS", cX, cY );


    textSize(545);
    fill(150);
    text("LASERS", cX, cY );

    textSize(540);
    fill(0);
    text("LASERS", cX-1, cY-1 );

    fill(255);
    text("LASERS", cX, cY );

}
