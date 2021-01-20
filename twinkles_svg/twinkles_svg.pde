//  SEE:     https://ello.co/ericfickes/post/hnlo3zdbq2vhlh9e0dasda

/*
FIRST = template to follow.

TWINKLES = TWINKLES tweaked for stars
* og : JOSH_CLASS_2015/_BURNED/twinkles

UNDER LUCKY STARS specs

 The design has to work for all three of the following print sizes, either by cropping or otherwise adjusting it:
                        = 300 dpi pixels

◆ 18x24 inches          = 5400, 7200
◆ 24x36 inches          = 7200, 10800
◆ A1 (23.4 x 33.1 in)   = 7020, 9930

 */
import processing.pdf.*;
import processing.svg.*;

float cX, cY, xx, yy, xx2, yy2, rad,angle, angle2, sw = 12;
Boolean dec = false;
int decStop = 0, decAmt = 16;	//	keep this in sync with large runs
int CONFIG_SCALE_FACTOR = 10;

PGraphics hires;


void settings(){
// ◆ 18x24 inches          = 
size(540 * CONFIG_SCALE_FACTOR, 720 * CONFIG_SCALE_FACTOR);

// ◆ 24x36 inches          = 
// size(7200, 10800);
// size(720 * CONFIG_SCALE_FACTOR, 1080 * CONFIG_SCALE_FACTOR);

// ◆ A1 (23.4 x 33.1 in)   = 
// size(7020, 9930);
// size(702 * CONFIG_SCALE_FACTOR, 993 * CONFIG_SCALE_FACTOR);

}


void setup()
{
  frameRate(666);
  
	cX = width/2;	//(width * CONFIG_SCALE_FACTOR)/2;
	cY = height/2;	//(height * CONFIG_SCALE_FACTOR)/2;
	rad = width;	//(width * CONFIG_SCALE_FACTOR);


//  SAVE SVG
	hires = createGraphics(
	                width,
	                height,
	                SVG,
	                this+".SVG");
	
	hires.textMode(MODEL);
	hires.smooth(8);
    hires.beginDraw();
		hires.noFill();
		
}




void draw()
{

	angle = frameCount;
	xx = cX - int( cos(radians(angle)) * rad );
	yy = cY - int( sin(radians(angle)) * rad );

	angle2 = -frameCount;

	xx2 = cX - int( cos(radians(angle2)) * rad );
	yy2 = cY - int( sin(radians(angle2)) * rad );

	hires.strokeWeight(sw);

	// strokeWeight(sw/PI);

  //  hires.stroke(random(255)); - BLACK
	//hires.stroke(42, 42, random(240) );// - RANDO BLUE
  hires.stroke(random(42,240),42, 42 );// - RANDO RED
  //hires.stroke(42,random(42,240), 42 );// - RANDO GREEN
  
  hexagon( xx, yy, rad, hires);//rad, angle2/(rad/sw) );

	//hires.stroke(frameCount%2==0?0:255); - BLACK
  //hires.stroke(frameCount%2==0?#1975EF:#EFEFEF); - BLUE
  hires.stroke(frameCount%2==0?#EF2018:#EFEFEF); // - RANDO RED
  //hires.stroke(frameCount%2==0?#19EF75:#EFEFEF); // - RANDO GREEN
  
    star( 5, 
          xx, yy, 
          rad*1.4,rad*1.4, 
          frameCount%180,
          random(0.2, 0.9) * cos(PI / angle) , hires);

	// strokeWeight(sw/PI);
	
  //  hires.stroke(random(255)); - BLACK
  //hires.stroke(42, 42, random(240) );// - RANDO BLUE
  hires.stroke(random(42,240),42, 42 );// - RANDO RED
  //hires.stroke(42,random(42,240), 42 );// - RANDO GREEN

	hexagon( xx2, yy2, rad, hires);//, rad, angle2/(rad/sw) );

	//  hires.stroke(frameCount%2==0?255:0); - BLACK
  //hires.stroke(frameCount%2==0?#EFEFEF:#1975EF); // - RANDO BLUE
  hires.stroke(frameCount%2==0?#EFEFEF:#EF2018); // - RANDO RED
  //hires.stroke(frameCount%2==0?#EFEFEF:#19EF75); // - RANDO GREEN
  
    star( 5, 
          xx2, yy2, 
          rad*1.4,rad*1.4, 
          frameCount%180,
          random(0.2, 0.9) * cos(PI / angle2) , hires);

   
	if(frameCount%15==0)
	{
		rad -= decAmt;
	}



  if( (rad) < sw/3 ){
  // if( frameCount > (width*1.5) ){

  	 twinkles(hires);

	hires.endDraw();
	hires.dispose();

    // shape(loadShape(this+".SVG"), 0, 0);

	//  SAVE PNG
    // save(fileStamp()+".png");
	System.gc();
    noLoop();

    println("DONE!");


	exit();
     
  }

}

//////////////////////////////////////////////////////////////////////////
void twinkles(PGraphics pg)
{
	pg.textMode(MODEL);
    pg.textAlign(CENTER,CENTER);
    pg.textFont( createFont("Slaytanic", 420 ));
    
	cY -= 75;

    pg.textSize(555);
    pg.fill(0);
    pg.text("twinkles", cX, cY );

    pg.textSize(550);
    pg.fill(100);
    pg.text("twinkles", cX, cY );


    pg.textSize(545);
    pg.fill(150);
    pg.text("twinkles", cX, cY );

    pg.textSize(540);
    pg.fill(0);
    pg.text("twinkles", cX-1, cY-1 );

    pg.fill(255);
    pg.text("twinkles", cX, cY );

}
//////////////////////////////////////////////////////////////////////////
//  HEXAGON inspired by http://www.rdwarf.com/lerickson/hex/index.html
void hexagon( float startX, float startY, float shapeSize, PGraphics pg ) {

  pg.strokeCap(PROJECT);
  pg.strokeJoin(BEVEL);

  startX -= ( shapeSize/2 );
  startY -= ( shapeSize/2 );


  pg.line( startX, startY+(shapeSize*.5), startX+(shapeSize*.25), startY );
  pg.line( startX+(shapeSize*.25), startY, startX+(shapeSize*.75), startY );
  pg.line( startX+(shapeSize*.75), startY, startX+(shapeSize), startY+(shapeSize*.5) );

  pg.line( startX+(shapeSize), startY+(shapeSize*.5), startX+(shapeSize*.75), startY+shapeSize );
  pg.line( startX+(shapeSize*.75), startY+shapeSize, startX+(shapeSize*.25), startY+shapeSize );
  pg.line( startX+(shapeSize*.25), startY+shapeSize, startX, startY+(shapeSize*.5) );
}



void star(int n, float cx, float cy, float w, float h, float startAngle, float proportion, PGraphics pg)
{
  pg.strokeCap(PROJECT);
  pg.strokeJoin(MITER);

  if (n > 2)
  {
    float angle = TWO_PI/ (2 *n);  // twice as many sides
    float dw; // draw width
    float dh; // draw height

    w = w / 2.0;
    h = h / 2.0;

//fill( random(255), n*r*proportion );

    pg.beginShape();
    for (int i = 0; i < 2 * n; i++)
    {
      dw = w;
      dh = h;
      if (i % 2 == 1) // for odd vertices, use short radius
      {
        dw = w * proportion;
        dh = h * proportion;
      }
      pg.vertex(cx + dw * cos(startAngle + angle * i), 
      cy + dh * sin(startAngle + angle * i));
    }
    pg.endShape(CLOSE);
  }
}

//  return unique filename_timestamp string
public String fileStamp(){
  return split( this.toString(), "[")[0] + "_" +month()+day()+year()+hour()+minute()+millis();
}
