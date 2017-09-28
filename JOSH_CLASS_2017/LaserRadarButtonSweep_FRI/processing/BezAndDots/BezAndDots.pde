int    stageW   = 1280;
int    stageH   = 928;
color  clrBG    = #424242;
// float cX, cY;

//	SKETCH DATA
	Boolean isFinal = true;
	int buf;
	// float tX, tY, inLeft, inRight, wvStart,i;


	////  CIRCLEY THING
	float cX, cY, inc, m; 
	float r, g, b;
	int tmr_Interval = 10;  // seconds


//	SKETCH DATA

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
	noFill();
	ellipseMode(CENTER);
	rectMode(CENTER); 
	strokeCap(ROUND); 
	strokeJoin(ROUND);
	smooth();

	cX = width/2;
	cY = height-95;
	rad = 42;	//	this gets set again


	myPort = new Serial(this, Serial.list()[3], 115200);
	myPort.bufferUntil(10);      // int(10)	ASCII linefeed

	delay(250);
}


// *************************************************************************************************************
void draw() {
	


	if( servoAngle > 0 ){

		pv1 = circleXY( cX, cY, radarIN%height, servoAngle );
		pv2 = circleXY( cX, cY-radarCM, radarCM+radarIN, servoAngle );

		if(servoAngle%15==0)
		{
			strokeWeight(PI);
			stroke(radarIN, radarCM, servoAngle);
			line( cX, cY, pv1.x, pv1.y );

			stroke(radarMS, radarIN, radarCM );

			strokeWeight(1);
			line( pv1.x, pv1.y, pv2.x, pv2.y );

		} else {
			stroke(servoAngle, frameCount%255);
		}

	    smooth();
	 
	    strokeWeight(1);
	    stroke(frameCount%2==0?0:255, radarIN );
	    ellipse( cX, cY, servoAngle, servoAngle );
	 
	    strokeWeight(14);
	    stroke(frameCount%2==0?0:255);
	    point( pv1.x, pv1.y );
	    point( width-pv1.x, height-pv1.y );
	 
	    strokeWeight(9);
	    stroke(frameCount%2==0?255:0);
	    point( pv1.x, pv1.y );
	    point( width-pv1.x, height-pv1.y );
	    
	    strokeWeight(4);
	    stroke(frameCount%2==0?0:255);
	    point( pv1.x, pv1.y );
	    point( width-pv1.x, height-pv1.y );
	 

	getFlowery( pv1.x, pv1.y,
	            pv2.x, pv2.y,
	            pv1.y, pv1.x,
	            pv2.y, pv2.x );
	 



			stroke(radarMS);
			line( cX, cY, pv2.x, pv2.y );

			strokeWeight( TWO_PI );
			stroke( radarMS%255 );
			point( pv1.x, pv1.y );
			strokeWeight( PI );
			stroke(radarIN, radarCM, radarMS );
			point( pv1.x, pv1.y );


			strokeWeight( TWO_PI );
			stroke( radarMS%255 );
			point( pv2.x, pv2.y );
			strokeWeight( PI );
			stroke(radarIN, radarMS, radarCM );
			point( pv2.x, pv2.y );


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
void doExit()
{
	stampIt( 240 );
	save(fileStamp()+".png");
	exit();
  
	noLoop();
	System.gc();
	super.stop();
}


///////////////////////////////////////////////
//  bezier helper
void getFlowery(
  float x, float y,
  float x2, float y2,
  float x3, float y3, 
  float x4, float y4
)
{

    strokeWeight(12);
    stroke(#EF0000);
    bezier( x, y, x2, y2, x3, y3, x4, y4);
 
    strokeWeight(6);
    stroke(#EFEF00);
    bezier( x, y, x2, y2, x3, y3, x4, y4);
 
    strokeWeight(2);
    stroke(#000037);
    bezier( x, y, x2, y2, x3, y3, x4, y4);
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
			doExit();
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

