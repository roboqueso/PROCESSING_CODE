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
// https://github.com/ericfickes/FIXLIB	
import fixlib.*;

Fixlib fix = Fixlib.init(this);
float cX, cY, xx, yy, xx2, yy2, rad,angle, angle2, sw = 11;
Boolean dec = false;
int decStop = 0, decAmt = 7 ;	//	keep this in sync with large runs
int CONFIG_SCALE_FACTOR = 2;

PGraphics hires;
PImage placeholder;

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
	rad = width;

placeholder = loadImage("placeholder2_white.png");


//  SAVE SVG
	hires = createGraphics(
	                width,
	                height,
	                SVG,
	                this+".SVG");
	hires.smooth(8);
    
    hires.beginDraw();
		hires.textMode(MODEL);
	    hires.textAlign(CENTER);    
	// TODO: install all over open fonts and update here
      //textFont(loadFont("BebasNeueBold-48.vlw"), 48);
	    hires.textFont( createFont("BebasNeueBold", 48 ));
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
	hires.stroke(48, 48, random(240) );// - RANDO BLUE
  //hires.stroke(random(48,240),48, 48 );// - RANDO RED
  //hires.stroke(48,random(48,240), 48 );// - RANDO GREEN
  
  hexagon( xx, yy, rad, hires);//rad, angle2/(rad/sw) );

	//hires.stroke(frameCount%2==0?0:255); - BLACK
  hires.stroke(frameCount%2==0?#1975EF:#EFEFEF); //- BLUE
  //hires.stroke(frameCount%2==0?#EF2018:#EFEFEF); // - RANDO RED
  //hires.stroke(frameCount%2==0?#19EF75:#EFEFEF); // - RANDO GREEN
  
    star( 5, 
          xx, yy, 
          rad*1.4,rad*1.4, 
          frameCount%180,
          random(0.2, 0.9) * cos(PI / angle) , hires);

	// strokeWeight(sw/PI);
	
  //  hires.stroke(random(255)); - BLACK
  hires.stroke(48, 48, random(240) );// - RANDO BLUE
  //hires.stroke(random(48,240),48, 48 );// - RANDO RED
  //hires.stroke(48,random(48,240), 48 );// - RANDO GREEN

	hexagon( xx2, yy2, rad, hires);//, rad, angle2/(rad/sw) );

	//  hires.stroke(frameCount%2==0?255:0); - BLACK
  hires.stroke(frameCount%2==0?#EFEFEF:#1975EF); // - RANDO BLUE
  //hires.stroke(frameCount%2==0?#EFEFEF:#EF2018); // - RANDO RED
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

  	// twinkles(hires);
    //  DO THE TEXT ACTION BELOW



    //  TITLE
    hires.textSize(88);

// BACK BAR
    hires.noStroke();
    hires.fill(#1975ef, 80);
    hires.rect(0, (int)(height*.1)-80, width, 100);

    hires.fill(#ef1975);
    hires.text("THE BEST DAY WAS A FRIDAY", width/2, (int)(height*.1));    

    hires.fill(#19ef75);
    hires.text("THE BEST DAY WAS A FRIDAY", (width/2)+1, (int)(height*.1)+1);

    hires.fill(#EFEFEF);
    hires.text("THE BEST DAY WAS A FRIDAY", (width/2)+2, (int)(height*.1)+2);



  //  PROJECTION

//  TODO: why doesn't image work here?????
//hires.tint(#ef1975, 80);  // TINT image to match backbar
//hires.imageMode(CENTER);
//hires.image(placeholder, 0,0);




    //  FOOTNOTE
    
// BACK BAR
    hires.fill(#1975ef , 80);
    hires.noStroke();
    hires.rect(0, (height*.9)-7 , width, 100);
    
    hires.textSize(88);
    hires.fill(#ef1975);
    hires.text("03/30/2018", width/2, (int)(height*.95) );

    hires.fill(#19ef75);
    hires.text("03/30/2018", (width/2)+1, (int)(height*.95)+1 );

    hires.fill(#EFEFEF);
    hires.text("03/30/2018", (width/2)+2, (int)(height*.95)+2 );

  



	hires.endDraw();
	hires.dispose();


  // SHOW IT
  shape(loadShape(this+".SVG"), 0, 0);

tint(#ef1975, 80);  // TINT image to match backbar
imageMode(CENTER);
image(placeholder, cX, cY);

	//  SAVE PNG
    save(fileStamp()+".png");

  	System.gc();
    noLoop();

    println("DONE!");


	exit();
     
  }


}

//////////////////////////////////////////////////////////////////////////
void twinkles(PGraphics pg)
{
	pg.textMode(SHAPE);
    pg.textAlign(CENTER,CENTER);
    pg.textFont( createFont("Slaytanic", 480 ));
    
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
