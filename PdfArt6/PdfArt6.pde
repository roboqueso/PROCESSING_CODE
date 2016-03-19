String lines[];
String txt;
float xx,yy, tLen, txtSz;


void setup()
{
  size( displayWidth, displayHeight, P3D);	// text is fuzzy in P3D
  background(#013459);
  smooth();

//	blue - #013459
//	red  - #CF1312
//	ORANGE - EF6900

  lines = loadStrings("my2.pdf");
  xx = width;
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

	  
	fill( txtSz, random(txtSz, tLen), random(txtSz, tLen), random(txtSz, tLen) );
	// textAlign(RIGHT);
	textSize(txtSz);
	text(txt, xx, yy);




	stroke(txtSz,txtSz,txtSz);
	
	// line(yy, xx, tLen, txtSz);
	line(tLen, yy, txtSz, tLen);


// MAKE IT RAIN TEXT ( ALA STALACTITES)
	fill( tLen, tLen, tLen );
	textAlign(CENTER,BOTTOM);
	textSize(random(txtSz));

  pushMatrix();
  translate(xx, random(height), tLen);
  // rotate( random(-HALF_PI, HALF_PI) );
  rotate(-HALF_PI);
  	text( txt, 0,0 );
  popMatrix();


	  if(xx<width)
	  {
	  	xx += txtSz;// txt.length();
	  } 
	  else
	  {
	  	xx = 0;//random(PI);
	  }
		// xx = frameCount%height;//random(width);

	  if(yy<height)
	  {
	  	yy += txtSz;
	  } 
	  else
	  {
	  	yy = random(txtSz);
	  }


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


