PImage bg;
PImage tmp;

//	todo: get "bubbles" to remain inside deck after being masked out
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
  smooth();
}

void draw () 
{

	//scale(random(-2,2));
	ellipse( random(width), random(height), frameCount%42, frameCount%42);

	if(frameCount%42==0){
		
		tmp = get();
		
		if(frameCount%84==0)
		{
			tmp.filter(INVERT);
		}

		tmp.mask(bg);

		image(tmp, random(width), frameCount%height, width, height);
	}


	if(frameCount> (width+height)){
		
		tmp = get();
		tmp.mask(bg);
		background(tmp);

		save(fix.pdeName()+fix.getTimestamp()+".png");
		noLoop();
		exit();
	}

}