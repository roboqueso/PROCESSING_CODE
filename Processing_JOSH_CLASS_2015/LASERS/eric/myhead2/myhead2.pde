//  grid with shrinking strokeWeight
import processing.pdf.*;

int sColor = 0;
float x, y;
int sz = 1200;

PGraphics pGraph;

float xx, yy, theta, r, i, cX, cY;

///////////////////////////////////////////////////////////////////////////////
void setup()
{
  size(1280, 960);
  // size(2560, 1920, P3D );
  frameRate(420);
  
  pGraph = createGraphics(width,height);

  
  x = y = -sz;
  cX = width/2;
  cY = height/2;

  beginRecord(PDF, fileStamp()+".pdf");

    pGraph.beginDraw();

}


///////////////////////////////////////////////////////////////////////////////
void draw()
{  

    pGraph.smooth();
    pGraph.strokeCap(ROUND);
    pGraph.rectMode(CENTER);
    pGraph.ellipseMode(CENTER);
    pGraph.noFill();

    sColor = ( sColor == 0 ? 255 : 0 );
    pGraph.stroke(sColor, random(155,255));

  theta = sqrt(frameCount%width) * 2 * PI;
  r = sqrt(frameCount%width);
  xx = cX -cos(sqrt(frameCount%width)*2*PI)*sqrt(frameCount%width);
  yy = cY - sin(sqrt(frameCount%width)*2*PI)*sqrt(frameCount%width);

  pGraph.ellipse( xx, yy, sz, sz );


  if(frameCount%r==0)
  {
    pGraph.strokeWeight(3);
    pGraph.stroke(0);
    pGraph.rect( (cX+x)%width, y, (r/theta)+1, (r/theta)+1, -(theta/PI) );
    
    pGraph.stroke(random(255));
  	pGraph.strokeWeight(1);
  	pGraph.rect( (cX+x)%width, y, r/theta, r/theta, -(theta/PI) );

    pGraph.strokeWeight(sqrt(sz));

  	if(r%6==0)
  	{
  		// stroke( r, y, x, random(150,250));
  		// stroke( r, theta, xx, random(150,250));
  		// strokeWeight(HALF_PI);
      pGraph.stroke(random(255));
  		pGraph.line(xx, yy, x, y);
  		pGraph.line(y,x,yy,xx);
  	}
  }
  	

  //  increment size
  if(x<width){
    x+=sz;
  } else {
    x = -sz;
    y += sz;
  }

  if( y > height ){

    y = -sz;
    sz -= sqrt(sz);

	   pGraph.strokeWeight(sqrt(sz));

    cX = random(width/2);
    cY = random(height/2);
  }
  


  
  if( sz < 40 ){

    pGraph.endDraw();

    image(pGraph,0,0);

    endRecord();

    stop();
  }

}



//  return unique filename_timestamp string
public String fileStamp(){
  return split( this.toString(), "[")[0] + "_" +month()+day()+year()+hour()+minute()+millis();
}



