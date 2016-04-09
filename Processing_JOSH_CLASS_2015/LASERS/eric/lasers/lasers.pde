
import processing.pdf.*;

float cX, cY, xx, yy, xx2, yy2, rad,angle, angle2, sw = 12;


Boolean dec = false;

int decStop = 0, decAmt = 9;

void setup()
{
// NOTE: once finalized, rerun sketch and AI centric dimension
size(1280, 960);    
// size(2554,980);



frameRate(420);


	smooth();
	frameRate(666);
	cX = width/2;
	cY = height/2;
	rad = 666;

	noFill();
}



void draw()
{
	angle = frameCount;
	xx = cX - int( cos(radians(angle)) * rad );
	yy = cY - int( sin(radians(angle)) * rad );

	angle2 = -frameCount;

	xx2 = cX - int( cos(radians(angle2)) * rad );
	yy2 = cY - int( sin(radians(angle2)) * rad );

strokeWeight(sw);

	// strokeWeight(sw/PI);
	stroke(random(255));
	hexagon( xx, yy, rad);//rad, angle2/(rad/sw) );

	stroke(frameCount%2==0?0:255);
    star( 5, 
          xx, yy, 
          rad*1.4,rad*1.4, 
          frameCount%180,
          random(0.2, 0.9) * cos(PI / angle) );

	// strokeWeight(sw/PI);
	
	stroke(random(255));
	hexagon( xx2, yy2, rad);//, rad, angle2/(rad/sw) );

	stroke(frameCount%2==0?255:0);
    star( 5, 
          xx2, yy2, 
          rad*1.4,rad*1.4, 
          frameCount%180,
          random(0.2, 0.9) * cos(PI / angle2) );

  
	if(frameCount%15==0)
	{
		rad -= decAmt;
	}



  if( (rad) < sw/3 ){
  // if( frameCount > (width*1.5) ){

  	lasers();

//  SAVE PDF
    beginRecord(PDF, fileStamp()+".pdf");
      image(get(),0,0);
    endRecord();

//  SAVE PNG
    save(fileStamp()+".png");

    noLoop();

    noLoop();
  }
// }
}

//////////////////////////////////////////////////////////////////////////
void lasers()
{
    textAlign(CENTER,CENTER);
    textFont( createFont("Slaytanic", 666 ));
    
	cY -= 75;

    textSize(555);
    fill(0);
    text("LASERS", cX, cY );

    textSize(550);
    fill(100);
    text("LASERS", cX, cY );


    textSize(545);
    fill(150);
    text("LASERS", cX, cY );

    textSize(540);
    fill(0);
    text("LASERS", cX-1, cY-1 );

    fill(255);
    text("LASERS", cX, cY );

}
//////////////////////////////////////////////////////////////////////////
//  HEXAGON inspired by http://www.rdwarf.com/lerickson/hex/index.html
void hexagon( float startX, float startY, float shapeSize ) {

  strokeCap(PROJECT);
  strokeJoin(BEVEL);

  startX -= ( shapeSize/2 );
  startY -= ( shapeSize/2 );


  line( startX, startY+(shapeSize*.5), startX+(shapeSize*.25), startY );
  line( startX+(shapeSize*.25), startY, startX+(shapeSize*.75), startY );
  line( startX+(shapeSize*.75), startY, startX+(shapeSize), startY+(shapeSize*.5) );

  line( startX+(shapeSize), startY+(shapeSize*.5), startX+(shapeSize*.75), startY+shapeSize );
  line( startX+(shapeSize*.75), startY+shapeSize, startX+(shapeSize*.25), startY+shapeSize );
  line( startX+(shapeSize*.25), startY+shapeSize, startX, startY+(shapeSize*.5) );
}



void star(int n, float cx, float cy, float w, float h, float startAngle, float proportion)
{
  strokeCap(PROJECT);
  strokeJoin(MITER);

  if (n > 2)
  {
    float angle = TWO_PI/ (2 *n);  // twice as many sides
    float dw; // draw width
    float dh; // draw height

    w = w / 2.0;
    h = h / 2.0;

//fill( random(255), n*r*proportion );

    beginShape();
    for (int i = 0; i < 2 * n; i++)
    {
      dw = w;
      dh = h;
      if (i % 2 == 1) // for odd vertices, use short radius
      {
        dw = w * proportion;
        dh = h * proportion;
      }
      vertex(cx + dw * cos(startAngle + angle * i), 
      cy + dh * sin(startAngle + angle * i));
    }
    endShape(CLOSE);
  }
}

//  return unique filename_timestamp string
public String fileStamp(){
  return split( this.toString(), "[")[0] + "_" +month()+day()+year()+hour()+minute()+millis();
}
