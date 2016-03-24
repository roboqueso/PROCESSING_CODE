String lines[];
String txt;
float xx,yy;

void setup()
{
  size(1024, 768 );
  background(#EFEF39);
  lines = loadStrings("my.pdf");
}

void draw(){

	if(frameCount < lines.length )
	{
		txt = lines[frameCount];

	  fill( txt.length() );
	  
	  text( txt, random(width), yy );

	  if(yy<height)
	  {
	  	yy += TWO_PI;
	  } 
	  else
	  {
	  	yy = random(PI);
	  }


	} 
	else 
	{
save(this+".png");
		noLoop();	
	}


}
