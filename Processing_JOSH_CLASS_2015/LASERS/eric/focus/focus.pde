import processing.pdf.*;

int txtSz = 1000;

void setup()
{
	size(1280, 960, P3D );
	background(255);
	textMode(MODEL);
	textAlign(CENTER, CENTER);
	textFont( createFont("Futura", txtSz ));	// Century Gothic	
}

void draw()
{
	textSize(txtSz);
	fill(frameCount%2==0?0:255);

	text("FOCUS", width/2, frameCount % (height/2), 1);


	pushMatrix();
		translate( width/2, height-frameCount % (height/2) );
		rotateX(180);
		text("FOCUS", 0,0, TWO_PI );
	popMatrix();


text("FOCUS", width/2, frameCount% (height/2), 2);


	pushMatrix();
		translate(width/2, height/2, -frameCount);	
		rotate(frameCount);
		text("FOCUS", 0,0,0);
	popMatrix();

	
text("FOCUS", width/2, frameCount% (height/2), 3);



	// txtSz -=1;	//	MAKES IT LOOK CRAZY
	txtSz -= 2;	//	FOCUS




  if(txtSz<=60)
  {

	textSize(106);

	//	LEFT TO RIGHT SMUDGE
	float x;
	for( x = 0; x <= (width/2); x+=3)
	{
		fill(x%2==0?0:255);
		text("FOCUS", x, height/2-5, 100);
	}
	//	RIGHT TO LEFT SMUDGE
	for( x = width; x >= (width/2); x-=3)
	{
		fill(x%2==0?0:255);
		text("FOCUS", x, height/2-5, 100);
	}

  	fill(0);
  	
  	text("FOCUS", width/2, height/2-5, 100);

  	fill(255);
  	textSize(104);
  	text("FOCUS", width/2, height/2-5, 101);

  	fill(0);
  	textSize(102);
  	text("FOCUS", width/2, height/2-5, 102);

  	fill(255);
  	textSize(100);
  	text("FOCUS", width/2, height/2-5, 103);


//	SAVE PDF
  	beginRecord(PDF, fileStamp()+".pdf");
  		image(get(),0,0);
	endRecord();

//	SAVE PNG
    save(fileStamp()+".png");

    noLoop();
  }  
}




//  return unique filename_timestamp string
public String fileStamp(){
  return split( this.toString(), "[")[0] + "_" +month()+day()+year()+hour()+minute()+millis();
}
