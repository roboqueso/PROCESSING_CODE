//  SEE:   https://ello.co/ericfickes/post/htl3pobzbzpjwdvcsmebbq
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);


ArrayList<PShape> shapes = new ArrayList<PShape>();
PShape s;
float x, y;
PVector vect = new PVector();

/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(displayWidth, displayHeight, P3D); // FX2D can't load OBJs?
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/*****************************************************************************/
void setup() 
{
  frameRate(420);
  background(#DC69EF);  
  blendMode(EXCLUSION);  //  DARKEST
  
  shapes.add( loadShape( "newscene.obj" ) );
  // shapes.add( loadShape("keychain/key_chain_031.obj"));

}


void draw() 
{
  // pick random shape
  // s = shapes.get( (int)random(shapes.size()-1) );
  s = shapes.get( frameCount%shapes.size() );
  
  if(s!=null){

	// 3D code
	hint(DISABLE_DEPTH_TEST);
	camera();
	lights(); //    because P3D

  ambientLight(vect.x, vect.y,(frameCount%255));
  emissive(vect.x, vect.y,(frameCount%255));
  specular(vect.x, vect.y,(frameCount%255));
 

  //  get the point
	x = random(frameCount,width);
	y = random(frameCount,height);
	vect = fix.circleXY( x, y, frameCount%(width/2), frameCount%360 );

  //s.disableStyle();

	translate(x,y,frameCount%y);

	pushMatrix();
  		s.rotateX(frameCount%360);
  		s.rotateY(frameCount%360);
  		s.rotateZ(frameCount%360);

	  	shape(s, x, y);
	  popMatrix();

	} 
  else 
  {
		delay(666); // maybe just chill for a bit
    println("no S? " + shapes.size() );
	}

  if(frameCount >= height )
  {
    save(fix.pdeName()+fix.getTimestamp()+".png");
    noLoop();
    exit();
  }
  
}
