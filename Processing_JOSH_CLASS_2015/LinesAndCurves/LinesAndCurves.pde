import processing.pdf.*;

int i = 0, cX,cY; 

PGraphics container;
Boolean run = false;
void setup() 
{
    // NOTE: once finalized, rerun sketch and AI centric dimension
size(1280, 960, P3D );
frameRate(420);
	
	// background(255,0,0);
	smooth();
    
    cX=width/2;
    cY=height/2;
  	
  	container = createGraphics(1280, 960, P3D);
 
} 


void draw() {

 	container.beginDraw();
 	container.noFill();
	container.strokeJoin(MITER);
	container.strokeCap(PROJECT);

	if(!run)
	{
		container.background(255,0,0);
		container.smooth();
		container.strokeWeight(1);

	    for( int x = 0; x < container.height; x+=3)
	    {
	    	container.stroke( (x*TWO_PI)%255, (x*TWO_PI)%255, (x*HALF_PI)%255 );
	        container.line( 0, x, width, x );
	    }
	    run=true;
	} 


    container.smooth();

    container.bezierDetail( frameCount%100 );
	container.curveTightness( frameCount%100 );

    container.strokeWeight(11);
    container.stroke(0);
	doBez( container, cX, cY, i); 
 
    container.strokeWeight(9);
    container.stroke( 255 );
    doBez( container, cX, cY, i);  
 
    container.strokeWeight(TWO_PI);
    container.stroke( 200 );
 	doBez( container, cX, cY, i);  
 
 
    container.strokeWeight(PI);
    container.stroke( random(255) );
    doBez( container, cX, cY, i);  
 

 
    if (i < height ) {
        i++;
    } else {
        i = 0; 
    }
    
container.endDraw();

    if(frameCount>height)
    { 
		

		image(container,0,0);
/*
    //  SAVE PDF
	beginRecord(PDF, fileStamp()+".pdf");
	  image(get(),0,0);
	endRecord();
*/
    //  SAVE PNG
        save(fileStamp()+".png");

        noLoop();
    }
}

void doBez( PGraphics pg, float cX, float cY, float i)
{
	    pg.bezier( width*cos( radians(i) * i ), height*sin( radians(i) * i ),
            i* cos( radians(i) * frameCount ), 
            i* sin( radians(i) * frameCount ),
            i+noise(frameCount), i*noise(frameCount),
            cX*cos( radians(i) * i ), cY*sin( radians(i) * i ));
}

//  return unique filename_timestamp string
public String fileStamp(){
  return split( this.toString(), "[")[0] + "_" +month()+day()+year()+hour()+minute()+millis();
}
