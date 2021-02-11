import nervoussystem.obj.*;
//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);



/*

Take the drawCube function and record each of the vertices laid down by the multi BOXes

Save all verte into an array

Loop back into a PShape

Can you OBJ extracted tube objects?!?

* if yes, repeat technique with ELLIPSE for tubes

*/

PGraphics cubeA;
PGraphics cubeB;
PImage texture;
PVector pt;
int cX, cY;
float xx, yy = 0;


ArrayList<PVector> biggin = new ArrayList<PVector>();


void settings(){
	size(displayWidth, displayHeight, P3D);
	smooth(8);
	pixelDensity(displayDensity());
	sketchSmooth();
}

void setup() {
  background(255);
  rectMode(CENTER);
  cX = (int)width/2;
  cY = (int)height/2;
  
  cubeA = createGraphics( (int)random(300,42),cY, P3D);
  // cubeB = createGraphics(300,300, P3D);
  
  //  create your group
  
} 

void draw() {
  drawAndSave(cubeA, 100+noise(frameCount), 200+noise(frameCount), biggin);

  image(cubeA, xx, (frameCount%displayHeight)+noise(frameCount));
 

  if( xx >= width && yy < height ){

  	xx  = 0;
  	yy += random(180);

println("DOES THIS WORK?!?.............................");
println("biggin: "+biggin.size());

	OBJExport obj = (OBJExport) createGraphics( width, height, "nervoussystem.obj.OBJExport", fix.pdeName()+fix.getTimestamp()+".obj");
	obj.beginDraw();
	obj.pushMatrix();
	//obj.translate(cubeA.width/2, cubeA.height/2);
	obj.beginShape(TRIANGLE_STRIP);

		for (int i = 0; i<biggin.size(); i++)
		{
		
			PVector pv = (PVector)biggin.get(i);

			obj.vertex(pv.x+noise(frameCount),pv.y+noise(frameCount),pv.z+noise(frameCount));
		}
	obj.endShape(CLOSE);
	obj.popMatrix();

    obj.endDraw();
    obj.dispose();



    save(this+".png");
    exit();


  } else if(xx >= width && yy > height){



    save(this+".png");
    exit();
  } else {
  	xx++;
    yy++;
  }
}

void drawAndSave(PGraphics cube, float xd, float yd, ArrayList<PVector> rt) {

	int vX = cube.width/2;
	int vY = cube.height/2;

	cube.beginDraw();
	cube.lights();
	cube.clear();
	
PShape pBox = cube.createShape( RECT, 90+noise(frameCount), 45+noise(frameCount), vX+noise(frameCount), vY+noise(frameCount));

	cube.blendMode(LIGHTEST);
	cube.strokeWeight(TWO_PI);
	cube.stroke(frameCount%255+noise(frameCount), xx%255, yy%255);
	cube.noFill();
	cube.rotateX(frameCount/xd+noise(frameCount) );
	cube.rotateY(frameCount/yd+noise(frameCount) );
	// cube.box(80);
	cube.shape(pBox);

	cube.endDraw();


	for(int vv = 0; vv <= pBox.getVertexCount(); vv++)
	{
		PVector pv = pBox.getVertex(vv);

    rt.add( new PVector( vX+pv.x, vY+pv.y, pv.z ) );

	}
}
