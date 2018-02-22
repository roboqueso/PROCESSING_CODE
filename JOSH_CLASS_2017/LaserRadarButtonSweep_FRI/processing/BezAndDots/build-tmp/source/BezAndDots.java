import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import fixlib.*; 
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

public class BezAndDots extends PApplet {


// https://github.com/ericfickes/FIXLIB	


Fixlib fix = Fixlib.init(this);

int    stageW   = 1280;
int    stageH   = 928;
int  clrBG    = 0xff424242;
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




Serial myPort;  // Create object from Serial class

//	data from art box
int servoAngle,radarMS,radarIN,radarCM;
int btnUp   = 1;	//	"CLICKED" = 0


PVector pv1, pv2;
int rad = 42;

// *************************************************************************************************************

public void settings() {
	size(stageW, stageH);//, P3D);

}


// *************************************************************************************************************
public void setup() {
	
	background(clrBG);
	noFill();
	ellipseMode(CENTER);
	rectMode(CENTER); 
	strokeCap(ROUND); 
	strokeJoin(ROUND);
	
	fix.alpha(rad);
	cX = width/2;
	cY = height-95;
	rad = 42;	//	this gets set again


	myPort = new Serial(this, Serial.list()[3], 115200);
	myPort.bufferUntil(10);      // int(10)	ASCII linefeed

	delay(250);
}


// *************************************************************************************************************
public void draw() {
	


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
public void stampIt( int txtSz )
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
public void doExit()
{
	stampIt( 240 );
	save(fix.pdeName()+".png");
	noLoop();
	exit();
}


///////////////////////////////////////////////
//  bezier helper
public void getFlowery(
  float x, float y,
  float x2, float y2,
  float x3, float y3, 
  float x4, float y4
)
{

    strokeWeight(12);
    stroke(0xffEF0000);
    bezier( x, y, x2, y2, x3, y3, x4, y4);
 
    strokeWeight(6);
    stroke(0xffEFEF00);
    bezier( x, y, x2, y2, x3, y3, x4, y4);
 
    strokeWeight(2);
    stroke(0xff000037);
    bezier( x, y, x2, y2, x3, y3, x4, y4);
}







/////////////////////////////////////////////////////////////////////////////
//
public void keyPressed() {
	switch(key){
		case 's':
		{
			//	just
			save(fix.pdeName()+".png");
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
public void serialEvent(Serial p) 
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
				servoAngle = PApplet.parseInt( box_data[0] );
				btnUp = PApplet.parseInt( box_data[1] );
				radarMS = PApplet.parseInt( box_data[2] );
				radarIN = PApplet.parseInt( box_data[3] );
				radarCM = PApplet.parseInt( box_data[4] );

			}

		}
	}
	catch(Exception exc){
		//DEBUG
		println("XXX EXCEPTION: serialEvent : " + exc ); 
	}
} 
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "BezAndDots" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
