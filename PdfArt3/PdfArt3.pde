String lines[];
String txt;
float xx,yy, tLen, txtSz;


void setup()
{
  size( displayWidth, displayHeight );
  background(#CF1312);


//	ORANGE - EF6900

  lines = loadStrings("my.pdf");
}


void draw()
{
// fill( random(20,40), random(200,215), random(11), 5);
// rect(0,0, displayWidth, displayHeight);

	if(frameCount < lines.length )
	{
		txt = lines[frameCount];
		tLen = txt.length();
		txtSz = tLen;

	  // stroke( random(20,40), random(200,215), random(11) );
	  // line( random(yy), yy, random(yy), yy);


	  // fill( tLen, tLen, tLen );
	  fill( txtSz, txtSz, txtSz );
	  // textSize(random(tLen));
	  textSize(txtSz);

// MAKE IT RAIN TEXT ( ALA STALACTITES)
/*
 	textAlign(CENTER);

  pushMatrix();
  translate(xx, random(height));
  rotate(-HALF_PI);
  	text( txt, 0,0 );
  popMatrix();
*/
text(txt, xx, yy);

	  if(xx<width)
	  {
	  	xx += txtSz;// txt.length();
	  } 
	  else
	  {
	  	xx = 0;//random(PI);
	  }


	  if(yy<height)
	  {
	  	yy += txt.length();
	  } 
	  else
	  {
	  	yy = random(PI);
	  }


	} 
	else 
	{
		tLen = 14;
		textSize(tLen);

		fill(#EF1975);
		text("ERICFICKES.COM", 0, height-(tLen*2) );

		fill(#19EF75);
		text("ERICFICKES.COM", 0, height-(tLen*1) );

		fill(#1975EF);
		text("ERICFICKES.COM", 0, height );

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


