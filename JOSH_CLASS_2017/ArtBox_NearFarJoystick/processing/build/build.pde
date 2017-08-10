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
//	duration|inches|joystickX|joystickY|joystickButtonUp
String[] box_data;	// incoming serial data
int box_duration = 0;
int box_inches   = 0;
int joy_x   = 0;
int joy_y   = 0;
int joy_up  = 1;	//	"CLICKED" = 0




// *************************************************************************************************************

void settings() {
	size(stageW, stageH, P3D);

}


// *************************************************************************************************************
void setup() {
	
	background(clrBG);
	strokeWeight(11);

	cX = width/2;
	cY = height/2;


// List all the available serial ports:
printArray(Serial.list());

	myPort = new Serial(this, Serial.list()[3], 115200);
	myPort.bufferUntil(10);      // int(10)	ASCII linefeed

	delay(500);
}


// *************************************************************************************************************
void draw() {
	background(clrBG);


	if( box_inches > 1 ){

		//	shrinking text ( closer = smaller )
		stampIt( 27*box_inches );

	}

	//	SAVE png on click
	if( joy_up == 0){

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
	try{
	serialString = p.readString().trim();

//DEBUG
println(">>>>>>> serialEvent : " + serialString ); 

		if(serialString!="")
		{
			//	DO STUFF WITH INCOMING SERIAL DATA


			//	EX: 
			//	duration|inches|joystickX|joystickY|joystickButtonUp
			//	duration|inches ( 1 -> 20 )|(0-1023)|(0-1023)|(0-1)
			//	2805|18|509|519|1

			box_data = split( serialString , '|');
// printArray(box_data);
			//	make sure we received an array
			if(box_data.length>1)
			{
				box_duration = int( box_data[0] );
				box_inches = int( box_data[1] );
				joy_x = int( box_data[2] );
				joy_y = int( box_data[3] );
				joy_up = int( box_data[4] );
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

