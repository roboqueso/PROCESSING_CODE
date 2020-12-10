//  SEE:   https://ello.co/ericfickes/post/vxz0r7rgaajv_p--sn8drg

//	Inspired by http://whatcolourisit.scn9a.org/
//	Coded by Eric Fickes - http://ericfickes.com

//  NOTE: This sketch was written to output to a BlinkStick USB device.
//  If you have a BlinkStick, uncommenting out the imports and device code blocks should "just work"
//
//  Because I no longer have a BlinkStick, this sketch was adjusted to be a color png generator.
//  As it sits, this sketch will save a .png every 59 & 60 seconds.  
//  The color change between even minutes is pretty negliable, but the 59 second mark is a nice variation.
//
//  Pressing S will get you an adhoc save

//import blinkstick.*;
//BlinkStick device;
float x, y;
int fontSz = 45;
String sHr, sMin, sSec, hexV;



void settings(){
  size((int)displayWidth/2, (int)displayHeight/2 );
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}

////////////////////////////////////////////////////////////////////////
void setup() 
{
  //frameRate(1); // THIS IS JUST A CLOCK, NO NEED TO RUN FAZS
	textAlign(CENTER,CENTER);
	fill(255);
	//device = BlinkStick.findFirst();
	//if(device!=null)
	//{
	//	//You need to set the mode only once
	//	device.setMode(2);
	//}
	//else
	//{
	//	println("NO BLINKSTICK");
	//	noLoop();
	//}
}

////////////////////////////////////////////////////////////////////////
void draw()
{
  	//	get time in string format
	sHr = ( hour() < 10) ? "0" + hour() : str(hour());
	sMin = (minute() < 10) ? "0" + minute() : str(minute());
	sSec = (second() < 10) ? "0" + second() : str(second());
  	//	make hexidecimal
	hexV = sHr + sMin + sSec;

	//	change background color
	background( unhex(hexV) );

  
	//	time
	textFont( createFont( "Courier New", (fontSz*PI) ) );
	// text( sHr + ":" + sMin + ":" + sSec, (width/PI)-(textAscent()+textDescent()), (height/2) );
	text( sHr + ":" + sMin + ":" + sSec, (width/2), textAscent()+textDescent() );


	//	hexidecimal
	//textSize(fontSz*PI);
	text("0x"+hexV, (width/2), height-(textAscent()+textDescent()) );



	//	send colors to BlinkStick
	//if(device!=null)
	//{
	//	//	"blink" color
	//	device.setIndexedColor(0, 0, unhex(hexV) );
	//	delay(160);
	//	device.setIndexedColor(1, 0, unhex(hexV) );
	//	delay(160);
	//	device.setIndexedColor(2, 0, unhex(hexV) );
	//	delay(160);


	//	//	"turn off LEDs"
	//	device.setIndexedColor(0, 0, 0 );
	//	delay(160);
	//	device.setIndexedColor(1, 0, 0 );
	//	delay(160);
	//	device.setIndexedColor(2, 0, 0 );
	//	delay(160);
	//}

// save each minute
if( (int(sSec) == 59 ) || (int(sSec) == 00 ) ) 
{
  save( this + "_"+ sHr + sMin + sSec + ".png");  
}

	//  auto stopper
	//if(frameCount>3600)
	//{
	//	//if(device!=null)
	//	//{
	//	//	device.turnOff();
	//	//}
	//	text("done",0,random(height));
	//	noLoop();
	//}
}



//////////////////////////////////////////////////////////////////////////
void keyPressed(){

  if( key == 's' || key == 'S')
  {
    save( this + "_"+ sHr + sMin + sSec + ".png");  
  }
}
