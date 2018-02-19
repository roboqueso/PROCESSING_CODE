// https://github.com/ericfickes/FIXLIB	
import fixlib.*;

Fixlib fix = Fixlib.init(this);

String lines[];
String txt;
float xx,yy, tLen;

void setup()
{
  size( displayWidth, displayHeight );
  background(#EF2014);

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

	  // stroke( random(20,40), random(200,215), random(11) );
	  // line( random(yy), yy, random(yy), yy);


	  fill( tLen, tLen, tLen );
	  textSize(random(tLen));

	  text( txt, random( width ), yy );

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

	    save( fix.pdeName() + fix.getTimestamp() + ".png");
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
