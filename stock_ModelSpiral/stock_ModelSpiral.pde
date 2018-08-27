/**
stock_ModelSpiral
*/


// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);

ArrayList<PShape> shapes = new ArrayList<PShape>();
PShape s;
float x, y;
PVector vect = new PVector();
Boolean fillStyle = true;	//	fill w/x,y or leave style as is
int radius = 43;
int frameMod = 8;	// % frameCount to control how many shapes get laid down
int getRad = (int)(width/4);	//	Radius increaser

/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(1760, 880, P3D); // FX2D can't load OBJs?
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/*****************************************************************************/
void setup() 
{
  background(-1);

// TODO: get modesl into ROOT P5 folder on both machine
//  NOT: in each sketch data

  shapes.add( loadShape( "../_allmodelsP5/172516642/stationary_003.obj" ) );





}


void draw() 
{
  // pick random shape
  // s = shapes.get( (int)random(shapes.size()-1) );
  s = shapes.get( frameCount%shapes.size() );

  if(s!=null )
  {
//  get the point
  x = width/2;  // random(frameCount,width);
  y = height/2;  // random(frameCount,height);

  vect = fix.circleXY( x, y, radius, frameCount%360 );

 if(frameCount%frameMod==0){
  // reset X/Y to circle coordinates
  x = vect.x;
  y = vect.y;

  // SAVE THE SHINY STUFF FOR ONCE THE CONCEPT IS PROVEN
  // hint(DISABLE_DEPTH_TEST);
  // camera();
  // lights(); //    because P3D
  // ambientLight(x%255, y%255,(frameCount%255));
  // emissive(x%255, y%255,(frameCount%255) );
  // specular(x%255, y%255,(frameCount%255) );

	translate(x,y,1);//frameCount%y);
  
    pushMatrix();

//	USING box(43) FOR DEBUG PURPOSES
//	box(43);

	s.rotateX(frameCount);
	s.rotateY(frameCount);
	s.rotateZ(frameCount);

	if(fillStyle){
		s.disableStyle();
		//	TODO: you can't stroke shapes?
		// s.setStroke( color(x%255,  y%255, (frameCount%255)) );
		// fill(x%255, y%255,(frameCount%255) );
fill(0, 102, 153);    // Set the SVG fill to blue
stroke(255);
	}

	shape(s);

    popMatrix();


}	// end frameChecker

    //  increase radius every full circle
    if( frameCount % 360==0 )
    {
      radius += getRad;
    }

  } 
  else 
  {
    delay(666); // maybe just chill for a bit
    println("no S? " + shapes.size() );
  }

  if( radius > height)
  {
    save(fix.pdeName()+fix.getTimestamp()+".png");
    noLoop();
    exit();
  } else {
    //  debug
    println("radius: ["+frameCount+"]" + radius);
  }
  
}
