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
String serialString;
String[] box_data;	// = split(men, '|');
int box_duration = 0;
int box_inches    = 0;






// *************************************************************************************************************

void settings() {
	size(stageW, stageH);

}


// *************************************************************************************************************
void setup() {
	
	background(clrBG);
	strokeWeight(11);

	cX = width/2;
	cY = height/2;

	/*
// List all the available serial ports:
printArray(Serial.list());
*/
	myPort = new Serial(this, Serial.list()[3], 115200);
	myPort.bufferUntil(10);      // int(10)	ASCII linefeed

	delay(500);
}


// *************************************************************************************************************
void draw() {
	background(clrBG);

	//	shrinking text ( closer = smaller )
	stampIt( 27*box_inches );


}









//////////////////////////////////////////////////////////////////////////
void stampIt( int txtSz )
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






// *************************************************************************************************************
//	Read data from the art box ( broadcasting via Serial )
void serialEvent(Serial p) 
{
	serialString = p.readString().trim();

//DEBUG
println(">>>>>>> serialEvent : " + serialString ); 


	if(serialString!=null)
	{
		//	DO STUFF WITH INCOMING SERIAL DATA


		//	EX: 
		//	duration|inches ( 1 -> 20 )
		box_data = split( serialString , '|');

		box_duration = int( box_data[0] );
		box_inches = int( box_data[1] );
	}
} 
