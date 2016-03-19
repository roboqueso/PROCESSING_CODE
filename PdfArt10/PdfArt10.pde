String lines[];
color[] palette = { #013459, #CF1312, #EF6900, #E8DA83, #CBFB5C, #1A74E2, #061C3F };
String txt;
float xx,yy, tLen, txtSz;


void setup()
{
  size( displayWidth, displayHeight, P3D);	// text is fuzzy in P3D
  background(#efefef);
  smooth();

//	blue - #013459
//	red  - #CF1312
//	ORANGE - #EF6900

  lines = loadStrings("rtmp_specification_1.0.pdf");
  xx = width/2;
  yy = height/2;
}


void draw()
{


	if(frameCount < lines.length )
	{
		txt = lines[frameCount];
		tLen = txt.length();
		txtSz = width/tLen;

// fun to watch
frame.setTitle(txt);


	fill( random(txtSz),  random(txtSz),  random(txtSz), tLen );
	textSize(txtSz);
	text(txt, xx, yy, width, txtSz);

	// stroke( random(txtSz), random(txtSz), random(txtSz), random(txtSz, tLen) );
	stroke( palette[ int(random( palette.length-1 )) ], random(txtSz, tLen) );
	

	line(xx, yy, txtSz, tLen);
	line(tLen, txtSz, yy, xx);


  pushMatrix();
  translate(xx, yy, tLen);
  	
  	rotate( radians(frameCount) );
	
	fill( tLen, tLen, tLen );
	textAlign(RIGHT,CENTER);
	textSize(txtSz);
  	text( txt, 0,0, width, txtSz );


  	rotate( radians(tLen) );

	fill( frameCount%txtSz, frameCount%txtSz, frameCount%txtSz, random(255) );
	textAlign(LEFT,CENTER);
	textSize(random(txtSz));
  	text( txt, 0,0, width, txtSz );

  popMatrix();


	} 
	else 
	{



		tLen = 39;
		textSize(tLen);
		fill(0);
		text("ERICFICKES.COM", width, height-tLen );

		fill(255);
		text("ERICFICKES.COM", width-2, height-tLen );

		fill(0);
		text("ERICFICKES.COM", width-4, height-tLen );

		fill(255);
		text("ERICFICKES.COM", width-6, height-tLen );


// P3D RENDER HACK = grab a screenshot of the sketch and drop it on the stage as an image
// If you don't do this, P3D will *not* save any of the drawing in the PNG, just the background
		PImage ss = get();
		image(ss,0,0);


		noLoop();
	}


		PImage ss = get();
		image(ss,0,0);


}



////// S SAVE HANDLER /////////

void keyPressed(){
switch(key)
{
  case 's':
    save(pdeName() + getTimestamp() + ".png");
  break;

  case ESC:
    save(pdeName() + getTimestamp() + ".png");
    exit();
  break;
}


} 




public String getTimestamp() {
  return ""+month()+day()+year()+hour()+minute()+millis();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?
public String pdeName() {
  return split( this.toString(), "[")[0];
}


