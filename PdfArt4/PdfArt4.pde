// https://github.com/ericfickes/FIXLIB	
import fixlib.*;

Fixlib fix = Fixlib.init(this);

String lines[];
String txt;
float xx,yy, tLen, txtSz;


void setup()
{
  size( displayWidth, displayHeight, P3D);	// text is fuzzy in P3D
  background(#CF1312);
  smooth();

//	ORANGE - EF6900

  lines = loadStrings("my.pdf");
  xx = width;
}


void draw()
{
	if(frameCount < lines.length )
	{
		txt = lines[frameCount];
		tLen = txt.length();
		txtSz = width/tLen;


	  
	  fill( txtSz, txtSz, txtSz, random(txtSz, tLen) );

	  textAlign(RIGHT);
	  textSize(txtSz);
	text(txt, xx, yy);

// MAKE IT RAIN TEXT ( ALA STALACTITES)
	fill( tLen, tLen, tLen );
	textAlign(CENTER,TOP);
	textSize(random(txtSz));


  pushMatrix();
  translate(xx, random(height), tLen);
  rotate( random(-HALF_PI, HALF_PI) );
  	text( txt, 0,0 );
  popMatrix();



/*
	  if(xx<width)
	  {
	  	xx += txtSz;// txt.length();
	  } 
	  else
	  {
	  	xx = 0;//random(PI);
	  }
*/xx = random(width);

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
		tLen = 14;
		textSize(tLen);

		fill(#EF1975);
		text("ERICFICKES.COM", 0, height-(tLen*2) );

		fill(#19EF75);
		text("ERICFICKES.COM", 0, height-(tLen*1) );

		fill(#1975EF);
		text("ERICFICKES.COM", 0, height );

		save(fix.pdeName()+fix.getTimestamp()+".png");
		noLoop();
		exit();
	}


}



////// S SAVE HANDLER /////////

void keyPressed(){
switch(key)
{
  case 's':
    save( fix.pdeName() + fix.getTimestamp() + ".png");
  break;

  case ESC:
    save( fix.pdeName() + fix.getTimestamp() + ".png");
    noLoop();
    exit();
  break;
}


} 