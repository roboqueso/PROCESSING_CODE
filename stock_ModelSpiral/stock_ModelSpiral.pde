//  SEE:   https://ello.co/ericfickes/post/lcotfvizog7z61e4uh-afq
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);

ArrayList<PShape> shapes = new ArrayList<PShape>();
PShape s;
float cX, cY, x, y;
PVector vect = new PVector();
Boolean mouseCam = false;  // Maps camera() to mouse movement See: https://processing.org/tutorials/p3d/
Boolean lights =  false;  //  EXTRA lights
Boolean fillStyle = true;  //  TRUE: fill w/x,y or FALSE:;. leave style as is
int radius = 69;	//	circle radius
int getRad = 69;	//	Radius increaser
int frameMod = 69;	// % frameCount to control how many shapes get laid down
int preScale = 0;	//	pre-scale up shapes if needed
int ss = 0;	//	shape index

/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(displayWidth, displayHeight, P3D); // FX2D can't load OBJs?
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/*****************************************************************************/
void setup() 
{
  frameRate(666);
  background(#DE00FC);


  cX = width/2;
  cY = height/2;

  shapes.add( loadShape( "newscene.obj" ) );  
  //  ARRAYS OF OBJECTS
    //shapes.add( loadShape( "../_allmodelsP5/209726889/box_dispenser_1487.obj" ) );
    //shapes.add( loadShape( "../_allmodelsP5/124822996/box_tallClosed.obj" ) );
    //shapes.add( loadShape( "../_allmodelsP5/212779366/boxes_wall_display_1391.obj" ) );
    //shapes.add( loadShape( "../_allmodelsP5/212779421/cube_display_box_1367.obj" ) );
    //shapes.add( loadShape( "../_allmodelsP5/172516539/gift_box_192b.obj" ) );
    //shapes.add( loadShape( "../_allmodelsP5/190403630/juice_box_a_082.obj" ) );
    //shapes.add( loadShape( "../_allmodelsP5/218401617/product_package_box_1286.obj" ) );

//	PRE-SCALE IF NEEDED
if(preScale>1){
	for(PShape shp : shapes){
		println("preScaling: " + shp);
		shp.scale(preScale);
	}
}

println("\n   Here we go! \n ");

}


void draw() 
{
  
  // pick shape
  s = shapes.get( ss );

  if(s!=null )
  {

    //  get the point
    vect = fix.circleXY( cX, cY, radius, frameCount%360 );
    // reset X/Y to circle coordinates
    x = vect.x;
    y = vect.y;

 if(frameCount%frameMod==0){

   if(mouseCam)
   {
	camera(mouseX, cY, (cY) / tan(PI/6), mouseX, cY, 0, 0, 1, 0);
   }
  //  else{
  //   camera(cX, cY, (cY) / tan(PI/6), cX, cY, 0, 0, 1, 0);
  // }

   
  lights(); //    because P3D

  if(lights){
    ambientLight((frameCount%111), x%111, y%111 );
    emissive(y%111,(frameCount%111),x%111 );
    specular(x%111, y%111,(frameCount%111));
  }

	translate(x,y,0);//getRad);//frameCount%y);
  
  pushMatrix();

  //	USING box(43) FOR DEBUG PURPOSES
  //	box(43);

  	s.rotateX(frameCount);	//radians(frameCount));
  	s.rotateY(270);
	//	NOTE: it's hot w/ and w/out rotateZ
  	s.rotateZ(360);

  	if(fillStyle)
    {
  		s.disableStyle();
  		//	TODO: you can't stroke shapes?
  		s.setStroke( color((frameCount%255), x%255, y%255 ) );
  		stroke((frameCount%255), x%255, y%255  );
  		fill((frameCount%255),x%255, y%255 );
      	tint((frameCount%255), x%255, y%255  );
  	}
  	shape(s);

  popMatrix();


}	// end frameChecker

    //  increase radius every full circle
    if( frameCount % 360==0 )
    {
      radius += getRad;

      // increase shape counter to next one
      ss = (ss+1)%shapes.size();

      //  debug
      println("level up: "+ radius + " : " + s);
    }

  } 
  else 
  {
    println("no S? " + shapes.size() );
  }

  //  ENDER
  if( radius > (height*.85) )  
  {
    doExit();
  }
  
}

/**
  End of sketch closer
*/
void doExit(){
  String msg = "ericfickes.com";
  //  stamp bottom right based on textSize
  fill(0);
  textSize(16);
  text(msg, width-(textWidth(msg)+textAscent()), height-textAscent());

  //	SAVE W/META FOR RE-RUN HELP
  //	NAME-GROUP-lights_fillStyle_radius_getRad_frameMod_preScale-TIMESTAMP
  save( fix.pdeName() + "-"+ GROUP + "_" + lights + "_" + fillStyle + "_" + radius + "_" + getRad + "_" + frameMod + "_" + preScale + "-"+ fix.getTimestamp()+".png" );    //  USE .TIF IF COLOR  
  
  //  cleanup
  fix = null;
  shapes = null;

  exit();
}
