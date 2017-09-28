int    stageW   = 1280;
int    stageH   = 928;
color  clrBG    = #424242;
float cX, cY;

//	SKETCH DATA


// circles
int cirXX;
int cirYY;
int startX = 0;
int startY = 0;
float angle      = 0; 
float radius     = 333;
float frequency  = 1;
int circleSize   = 100;
boolean gotGrid = false;
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
	strokeWeight(11);
	smooth();

	cX = width/2;
	cY = height-95;
	rad = 42;	//	this gets set again

  
  strokeWeight(2);


	myPort = new Serial(this, Serial.list()[3], 115200);
	myPort.bufferUntil(10);      // int(10)	ASCII linefeed

	delay(500);
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
		} else {
			stroke(servoAngle, frameCount%255);
		}


		strokeWeight(1);
		line( pv1.x, pv1.y, pv2.x, pv2.y );

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

	//	Fire Laser
	if( btnUp == 0){
		strokeWeight( radarIN%TWO_PI );
		stroke(radarMS%255, radarIN, radarCM );
		line( pv2.x, pv2.y, pv1.x, pv1.y );
	}


    for( int cc = 0; cc <= 6; cc ++ )
    {
//      noFill();
      smooth();

      cirXX = startX - int( cos(radians(servoAngle)) * radarIN );
      cirYY = startY - int( sin(radians(servoAngle)) * radarIN );
      
      stroke( #97EF51, radarIN*2 );
      strokeWeight( 1 );  
      hexagon( pv1.x, pv1.y, radarIN );
      

      //  points 
      strokeWeight( random( PI ) );  

//noStroke();
      fill( #97EF51, radarIN );  // EF5150
      point( random(pv1.x), random(pv1.y) );//, radarIN+radarCM );


      
      if( servoAngle % 3 == 0 ) {
      // sun ball
      if( servoAngle % 45 == 0 ) {
        stroke( #FF0000, radarIN );
      } else { 
        stroke( #EF3636, radarIN );  // 
      }
      
      strokeWeight(.25);

      line( pv1.x, pv1.y, cirXX, cirYY );
      }
      
      
      
  
      
    }

  
  
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



//////////////////////////////////////////////////////////////////////////
//  HEXAGON inspired by http://www.rdwarf.com/lerickson/hex/index.html
void hexagon( float startX, float startY, float shapeSize ) {

  line( startX, startY+(shapeSize*.5), startX+(shapeSize*.25), startY );
  line( startX+(shapeSize*.25), startY, startX+(shapeSize*.75), startY );
  line( startX+(shapeSize*.75), startY, startX+(shapeSize), startY+(shapeSize*.5) );

  line( startX+(shapeSize), startY+(shapeSize*.5), startX+(shapeSize*.75), startY+shapeSize );
  line( startX+(shapeSize*.75), startY+shapeSize, startX+(shapeSize*.25), startY+shapeSize );
  line( startX+(shapeSize*.25), startY+shapeSize, startX, startY+(shapeSize*.5) );
}


///////////////////////////////////////////////////////////
//  Helper to random(255) stroke
void randFill() {  
  fill( random(255), random(255), random(255), radarIN );
}
void randStroke() {  
  stroke( random(255), random(255), random(255), radarIN );
}
void randStroke100() {  
  stroke( random(255), random(255), random(255), 100 );
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

