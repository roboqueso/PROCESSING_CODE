
import fixlib.*;

Fixlib fix = Fixlib.init(this);
String lines[];
// color[] palette = { #013459, #CF1312, #EF6900, #E8DA83, #CBFB5C, #1A74E2, #061C3F };
ArrayList palette;
PImage img;
String txt;
float cX, cY, xx,yy, tLen, txtSz;
int colorIdx;

void setup()
{
  size( displayWidth, displayHeight, P3D);	// text is fuzzy in P3D
  // size( 1024, 728, P3D);

  background(#efefef);
  smooth();

  img = loadImage("make-kinect-like-this.jpg");
  palette = fix.getImgColors(img);

  lines = loadStrings("BlueNoiseThroughOptimalTransport.pdf");
  cX = width/2;
  cY = height/2;

  fix.paletteGrid(palette);
}


void draw()
{

	if(frameCount < lines.length )
	{
		txt = lines[frameCount];
		tLen = txt.length();
		txtSz = width/tLen;
		colorIdx = frameCount % (palette.size()-1);
// fun to watch
surface.setTitle(txt);


try {

			xx = cX - int( cos(radians(tLen)) * frameCount%txtSz );
			yy = cY - int( sin(radians(tLen)) * frameCount%txtSz );

	
	fill( (Integer)palette.get( colorIdx ) , random(200,tLen) );
	textSize(txtSz);
	text(txt, xx, yy, width, txtSz);

	fill( frameCount%255, frameCount%255, frameCount%255,  random(txtSz, tLen) );
	textSize(txtSz-PI);
	text(txt, xx-PI, yy+PI, width, txtSz);	


		stroke( (Integer)palette.get( colorIdx ) );
	
		xx = cX - int( cos(radians(txtSz)) * frameCount%txtSz );
		yy = cY - int( sin(radians(txtSz)) * frameCount%txtSz );

		fill( (Integer)palette.get( colorIdx ) , 25 );
		stroke( (Integer)palette.get( colorIdx ) );

		rect(xx, yy, txtSz, txtSz, tLen);
		ellipse(yy, xx, txtSz, txtSz);

}
  catch (RuntimeException exc)
  {
	textSize(42);
    text("CRASH::"+exc, 42, height/2);
    tint(255);
    save("CRASH_"+pdeName() + getTimestamp() + ".png");
  }


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
    // save(pdeName() + getTimestamp() + ".png");
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  break;

  case ESC:
    // save(pdeName() + getTimestamp() + ".png");
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
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


