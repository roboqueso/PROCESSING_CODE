import processing.pdf.*;

int txtSz = 1000;

PGraphics pg;

void setup()
{
	size(1280, 960, P3D);

	pg = createGraphics(width,height,P3D);
	
	pg.beginDraw();	
	pg.background(255);
	pg.textMode(MODEL);
	pg.textAlign(CENTER, CENTER);
	pg.textFont( createFont("Futura", txtSz ));	// Century Gothic

}

void draw()
{
	pg.textSize(txtSz);
	pg.fill(frameCount%2==0?0:255);



	pg.text("FOCUS", width/2, frameCount % (height/2), 1);
	pg.endDraw();

	pg.pushMatrix();
		pg.translate( width/2, height-frameCount % (height/2) );
		pg.rotateX(180);
		pg.text("FOCUS", 0,0, TWO_PI );
	pg.popMatrix();


pg.text("FOCUS", width/2, frameCount% (height/2), 2);


	pg.pushMatrix();
		pg.translate(width/2, height/2, -frameCount);	
		pg.rotate(frameCount);
		pg.text("FOCUS", 0,0,0);
	pg.popMatrix();

	
pg.text("FOCUS", width/2, frameCount% (height/2), 3);



	// txtSz -=1;	//	MAKES IT LOOK CRAZY
	txtSz -= 2;	//	FOCUS




  if(txtSz<=60)
  {

	pg.textSize(106);

	//	LEFT TO RIGHT SMUDGE
	float x;
	for( x = 0; x <= (width/2); x+=3)
	{
		pg.fill(x%2==0?0:255);
		pg.text("FOCUS", x, height/2-5, 100);
	}
	//	RIGHT TO LEFT SMUDGE
	for( x = width; x >= (width/2); x-=3)
	{
		pg.fill(x%2==0?0:255);
		pg.text("FOCUS", x, height/2-5, 100);
	}

  	pg.fill(0);
  	
  	pg.text("FOCUS", width/2, height/2-5, 100);

  	pg.fill(255);
  	pg.textSize(104);
  	pg.text("FOCUS", width/2, height/2-5, 101);

  	pg.fill(0);
  	pg.textSize(102);
  	pg.text("FOCUS", width/2, height/2-5, 102);

  	pg.fill(255);
  	pg.textSize(100);
  	pg.text("FOCUS", width/2, height/2-5, 103);



//	beginRecord(PDF, fileStamp()+".pdf");
	image(pg, 0,0);
//	endRecord();

    save(fileStamp()+".png");

    stop();
  }  
}




//  return unique filename_timestamp string
public String fileStamp(){
  return split( this.toString(), "[")[0] + "_" +month()+day()+year()+hour()+minute()+millis();
}
