//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);


int sColor = 0;
float x, y;
int sz = 1000;
float xx, yy, theta, r, i, cX, cY;

///////////////////////////////////////////////////////////////////////////////
void setup()
{
  size(7680, 4320);  // 8K
  smooth(8);
  background(#EFEFEF);
  frameRate(666);
  


		strokeCap(ROUND);

rectMode(CENTER);
ellipseMode(CENTER);

  noFill();

  
  x = y = -sz;
  cX = width/2;
  cY = height/2;
}


///////////////////////////////////////////////////////////////////////////////
void draw()
{  

    sColor = ( sColor == 0 ? 255 : 0 );
    stroke(sColor, random(155,255));


theta = sqrt(frameCount%width) * 2 * PI;
r = sqrt(frameCount%width);
xx = cX -cos(sqrt(frameCount%width)*2*PI)*sqrt(frameCount%width);
yy = cY - sin(sqrt(frameCount%width)*2*PI)*sqrt(frameCount%width);

ellipse( xx, yy, sz, sz );


if(frameCount%r==0)
{
	strokeWeight(HALF_PI);
	// stroke(sColor);//, random(122,222));
	rect( (cX+x)%width, y, r/theta, r/theta, -(theta/PI) );

strokeWeight(sqrt(sz));

	if(r%6==0)
	{
		// stroke( r, y, x, random(150,250));
		stroke( r, theta, xx, random(150,250));
		// strokeWeight(HALF_PI);
		line(xx, yy, x, y);
		line(y,x,yy,xx);
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

	strokeWeight(sqrt(sz));

    cX = random(width/2);
    cY = random(height/2);
  }
  

//  write every 6th frame
  if(frameCount%6==0)  saveFrame("FRAMES/#########.png");
  
  if( sz < 39 ){

    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
    
    noLoop();
    exit();
  }

}
