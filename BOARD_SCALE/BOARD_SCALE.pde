PImage bg;

void setup()
{
  // size(8192,2391, P3D);	//	1/8 = 1024, 298
  size(1024,298,P3D);
  
//	DO VECTOR
//	SCALE BACK UP IN AI

  //	shrink template
  bg = loadImage("deck_template.png");
  bg.resize(width,height);

  background( bg );
  // scale(.5);
}

void draw () 
{
	// scale(2);
	ellipse( random(width), random(height), frameCount%33, frameCount%33);

}