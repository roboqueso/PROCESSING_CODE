import nervoussystem.obj.*;
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
	size(2000, 1000, P3D);
	smooth(8);
	pixelDensity(displayDensity());
	sketchSmooth();
}

void setup() {
  background(255);
  rectMode(CENTER);
  cX = (int)width/2;
  cY = (int)height/2;
  
  cubeA = createGraphics(300,cY, P3D);
  // cubeB = createGraphics(300,300, P3D);
  
  //  create your group
  
} 

void draw() {
  drawAndSave(cubeA, 100, 200, biggin);

  image(cubeA, xx, cY);
 

  if( xx >= width && yy < height ){

  	xx  = 0;
  	yy += 180;

println("DOES THIS WORK?!?.............................");
println("biggin: "+biggin.size());

	OBJExport obj = (OBJExport) createGraphics( width, height, "nervoussystem.obj.OBJExport", fix.pdeName()+".obj");
	obj.beginDraw();
	obj.pushMatrix();
	//obj.translate(cubeA.width/2, cubeA.height/2);
	obj.beginShape(TRIANGLE_STRIP);

		for (int i = 0; i<biggin.size(); i++)
		{
		
			PVector pv = (PVector)biggin.get(i);
  //obj.rotateX(frameCount/100);
  //obj.rotateY(frameCount/200);
			obj.vertex(pv.x,pv.y,pv.z);
		}
	obj.endShape(CLOSE);
	obj.popMatrix();

    obj.endDraw();
    obj.dispose();



//	clear it and restart it
// biggin = new ArrayList<PVector>();

    save(this+".png");
    exit();


  } else if(xx >= width && yy > height){



    save(this+".png");
    exit();
  } else {
  	xx++;

  }
}

void drawAndSave(PGraphics cube, float xd, float yd, ArrayList<PVector> rt) {

	int vX = cube.width/2;
	int vY = cube.height/2;

	cube.beginDraw();
	cube.lights();
	cube.clear();
	/*
LIGHTEST - only the lightest colour succeeds: C = max(A*factor, B)

DIFFERENCE - subtract colors from underlying image.

EXCLUSION - similar to DIFFERENCE, but less extreme.

SCREEN - opposite multiply, uses inverse values of the colors.

REPLACE - the pixels entirely replace the others and don't utilize alpha (transparency) values
*/
// PShape pBox = cube.createShape( BOX, 80, vX, vY);
PShape pBox = cube.createShape( RECT, 90, 44, vX, vY);

	cube.blendMode(LIGHTEST);
	// cube.translate(vX, vY);

	cube.strokeWeight(TWO_PI);
	cube.stroke(frameCount%255, xx%255, yy%255);
	cube.noFill();
	cube.rotateX(frameCount/xd);
	cube.rotateY(frameCount/yd);
	// cube.box(80);
	cube.shape(pBox);
	// cube.rotateX(frameCount/xd);
	// cube.rotateY(frameCount/yd);
	// 	cube.strokeWeight(TWO_PI);
	// 	cube.stroke(frameCount%255, xx%255, yy%255);
	// cube.fill(255);
	// cube.box(80);
//println("pBox: " + pBox.x + " " + pBox.y + " " + pBox.z + " ");
	//	TODO: Figure out how to record all the vertices of the above BOX objects into
	//	on PShape ( GROUP? )
	cube.endDraw();


	for(int vv = 0; vv <= pBox.getVertexCount(); vv++)
	{
		PVector pv = pBox.getVertex(vv);
		// rt.add(pv);	//vertex( pv.x, pv.y, pv.z );
    //rt.add( new PVector( pv.x, pv.y, pv.z+random(44) ) );
    rt.add( new PVector( vX+pv.x, vY+pv.y, pv.z ) );

	}
}
