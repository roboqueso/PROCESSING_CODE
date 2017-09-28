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

		pv1 = circleXY( cX, cY, radarMS%height, servoAngle );
		pv2 = circleXY( cX-radarIN, cY-radarIN, radarIN%height, servoAngle );

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
//////////////////////////////////////////////////////////////////////////
//  HEXAGON inspired by http://www.rdwarf.com/lerickson/hex/index.html
void hexagon( float startX, float startY, float shapeSize ) {

  strokeCap(PROJECT);
  strokeJoin(BEVEL);

  startX -= ( shapeSize/2 );
  startY -= ( shapeSize/2 );


  line( startX, startY+(shapeSize*.5), startX+(shapeSize*.25), startY );
  line( startX+(shapeSize*.25), startY, startX+(shapeSize*.75), startY );
  line( startX+(shapeSize*.75), startY, startX+(shapeSize), startY+(shapeSize*.5) );

  line( startX+(shapeSize), startY+(shapeSize*.5), startX+(shapeSize*.75), startY+shapeSize );
  line( startX+(shapeSize*.75), startY+shapeSize, startX+(shapeSize*.25), startY+shapeSize );
  line( startX+(shapeSize*.25), startY+shapeSize, startX, startY+(shapeSize*.5) );
}



void star(int n, float cx, float cy, float w, float h, float startAngle, float proportion)
{
  strokeCap(PROJECT);
  strokeJoin(MITER);

  if (n > 2)
  {
    float angle = TWO_PI/ (2 *n);  // twice as many sides
    float dw; // draw width
    float dh; // draw height

    w = w / 2.0;
    h = h / 2.0;

//fill( random(255), n*r*proportion );

    beginShape();
    for (int i = 0; i < 2 * n; i++)
    {
      dw = w;
      dh = h;
      if (i % 2 == 1) // for odd vertices, use short radius
      {
        dw = w * proportion;
        dh = h * proportion;
      }
      vertex(cx + dw * cos(startAngle + angle * i), 
      cy + dh * sin(startAngle + angle * i));
    }
    endShape(CLOSE);
  }
}



//  return unique filename_timestamp string
public String fileStamp(){
  return split( this.toString(), "[")[0] + "_" +month()+day()+year()+hour()+minute()+millis();
}

