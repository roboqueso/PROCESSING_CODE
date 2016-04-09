int txtSz = 1000;

void setup()
{
	size(1280, 960, P3D);
	// textMode(SHAPE);
	textAlign(CENTER, CENTER);	
}

void draw()
{
	textSize(txtSz);

text("focus", width/2, frameCount% (height/2), frameCount );

	fill(frameCount%2==0?0:255);

	pushMatrix();
		translate( width/2, height-frameCount % height, frameCount/2 );
		rotateX(180);
		text("focus", 0,0, TWO_PI );
	popMatrix();

text("focus", width/2, frameCount% (height/2), frameCount );

	pushMatrix();
		// textSize(frameCount);
		// translate(frameCount%width, frameCount%height, frameCount );
		translate(width/2, height/2, -frameCount);
		
		rotate(frameCount);

		text("focus", 0,0,0);
	popMatrix();

text("focus", width/2, frameCount% (height/2), frameCount );

	// txtSz -=1;	//	MAKES IT LOOK CRAZY
	// txtSz -= 2;	//	FOCUS
	// txtSz -= 3;	//	?
txtSz -= 4;	//	?


  if(txtSz<=40)
  {
  	fill(255);
  	text("focus", width/2, frameCount% (height/2), frameCount );

    save(fileStamp()+".png");

    stop();
  }  
}




//  return unique filename_timestamp string
public String fileStamp(){
  return split( this.toString(), "[")[0] + "_" +month()+day()+year()+hour()+minute()+millis();
}
