/******************************************
  KINETIC FIRE
  
  by: Eric Fickes ( .com )
  
  for: Subterranean Gallery

******************************************/

import SimpleOpenNI.*;


SimpleOpenNI context;
float        zoomF =0.4f;
float        rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
                                   // the data from openni comes upside down
float        rotY = radians(0);
boolean      autoCalib=true;

PVector      bodyCenter = new PVector();
PVector      bodyDir = new PVector();
PVector      com = new PVector();                                   
PVector      tmp = new PVector();                                   

int[] userList;
// int[]   depthMap;
int[]   userMap;
int     steps   = 4;  // to speed up the drawing, draw every third point
int     index;
PVector rwp;



PImage imgDepth = new PImage();	//	depth
PImage imgIr = new PImage();	//	ir
PImage imgRgb = new PImage();	//	ir
PImage imgTexture = new PImage();
PImage fire1, fire2, fire3, fire4;

ArrayList<PVector> joints = new ArrayList<PVector>();
String stamp = "[refresh]+[redraw]";

////////////////////////////////
void setup()
{
//  size(1200, 900,P3D);  // strange, get drawing error in the cameraFrustum if i use P3D, in opengl there is no problem
  size( displayWidth, displayHeight, P3D );
  background(255);
  frameRate(60);
  
//	textureMode(NORMAL);
//	textureWrap(REPEAT);

  context = new SimpleOpenNI(this);
  if(context.isInit() == false)
  {
     println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
     exit();
     return;  
  }else{

  	println("KINECT IN EFFECT YO!");

  }

  // disable mirror
  context.setMirror(false);

  // enable depthMap generation 
	// context.enableIR();
	context.enableDepth();
	context.enableRGB();
	

  // enable skeleton generation for all joints
  context.enableUser();

  smooth();  

	fire1 = loadImage("fire1.png");
	fire2 = loadImage("fire2.png");
	fire3 = loadImage("fire3.png");
	fire4 = loadImage("fire4.png");

  perspective(radians(45),
              float(width)/float(height),
              10,150000);
 }

void draw()
{
  lights();

	// update the cam
	context.update();
	userList 	= context.getUsers();

//	60 fps, run draw every half second
if(frameCount%15==0) {

	//	TODO: come up with a better way to randomly set texture flame
	if(frameCount%60==0)
		imgTexture = fire1;
	else if(frameCount%120==0)
		imgTexture = fire2;
	else if(frameCount%150==0)
		imgTexture = fire3;
	else
		imgTexture = fire4;


	// depthMap = context.depthMap();
	userMap		= context.userMap();

	// imgIr		= context.irImage();
	imgDepth	= context.depthImage();
	imgRgb 		= context.rgbImage();

imgRgb.mask(imgDepth);
tint(255,100);
image(imgRgb, 0, frameCount%height, width, imgRgb.height);

  // set the scene pos
  translate(width/2, height/2, 0);
  rotateX(rotX);
  rotateY(rotY);
  scale(zoomF);
  
  translate(0,0,-1000);  // set the rotation center of the scene 1000 infront of the camera
  

  // stroke(255);
  noStroke();
  fill(0);

  for(int i=0;i<userList.length;i++)
  {
    
    if(context.isTrackingSkeleton(userList[i]))
    {
      drawSkeleton(userList[i]);
      tmp = getLimb(userList[i], SimpleOpenNI.SKEL_HEAD );
    }
    
    // draw the center of mass
    if(context.getCoM(userList[i],com))
    {
      if(com.x>0)
      {    

        sphereDetail(
            (int) map(com.x, 0, width, 3, 21),
            (int) map(com.y, 0, height, 3, 21)
          );

        pushMatrix();
          translate(com.x, com.y, com.z);
          sphere(42);
        popMatrix();
      }
    }



  	// stroke(random(frameCount%255));
  	noStroke();
	fill(frameCount%255);
	tint(frameCount%255);

  strokeWeight(random(PI,11));
    curveTightness( map(com.z, 0, width, -5, 5) );

    beginShape();//QUAD_STRIP);  //   POINTS, LINES, TRIANGLES, TRIANGLE_FAN, TRIANGLE_STRIP, QUADS, or QUAD_STRIP

    for(PVector pt : joints ){
      curveVertex(pt.x%width, pt.y%height, pt.z);
    }
    endShape();


    noStroke();
    noFill();
    smooth();
	    tint(tmp.z%255,tmp.x%255,tmp.y%255);

	    beginShape(POLYGON);//QUADS);  //   POLYGON, TRIANGLES, QUADS, or QUAD_STRIP
	 
	    texture(imgTexture);
	    
	    for(PVector pt : joints )
    {

    vertex(
      pt.x-modelX(pt.x, pt.y, pt.z),
      pt.y-modelY(pt.x, pt.y, pt.z),
      pt.z-modelZ(pt.x, pt.y, pt.z), modelX(pt.x, pt.y, pt.z)%width, 
                                modelY(pt.x, pt.y, pt.z)%height);


	      // vertex(pt.x, pt.y, pt.z, pt.x%imgTexture.width, pt.y%imgTexture.height);
      vertex(pt.x, pt.y, pt.z, random(imgTexture.width), random(imgTexture.height));

    }
	    endShape();
  // }

	joints.clear();


	scale(-1,1);
	tint(255);
	image(get(), 0, -frameCount%height, width/2, imgIr.height );

	
  //	POINT CLOUD
  beginShape(POINTS);
  for(int y=0;y < context.depthHeight();y+=steps)
  {
	strokeWeight(random(TWO_PI));

    for(int x=0;x < context.depthWidth();x+=steps)
    {
		index = x + y * context.depthWidth();
		stroke(random(255));

      if(userMap[index] > 0)
      { 
      	
        // draw the projected point
        rwp = context.depthMapRealWorld()[index];
        // point(rwp.x,rwp.y,rwp.z);

		point(
			rwp.x-modelX(rwp.x,rwp.y,rwp.z),
			rwp.y-modelY(rwp.x,rwp.y,rwp.z),
			rwp.z-modelZ(rwp.x,rwp.y,rwp.z)
			);

      }
    } 
  } 
  endShape();

  }    // END for each user


}	// end frameCount checker

  //  AUTO SAVER
  if(frameCount%width==0){
    save( this + ".png");
    noLoop();
    exit();
  }


}




// draw the skeleton with the selected joints
void drawSkeleton(int userId)
{

  joints.add( getLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW  ));
  // joints.add( getLimb(userId, SimpleOpenNI.SKEL_LEFT_FINGERTIP  ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_LEFT_FOOT  ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_LEFT_HAND  ));
  // joints.add( getLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP  ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE  ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER  ));
  
	joints.add( getLimb(userId, SimpleOpenNI.SKEL_HEAD  ));
	// joints.add( getLimb(userId, SimpleOpenNI.SKEL_NECK  ));
	joints.add( getLimb(userId, SimpleOpenNI.SKEL_TORSO  ));

  joints.add( getLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW  ));
  // joints.add( getLimb(userId, SimpleOpenNI.SKEL_RIGHT_FINGERTIP  ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_RIGHT_FOOT  ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_RIGHT_HAND  ));
  // joints.add( getLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP  ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE  ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER  ));
  




  // draw body direction
  getBodyDirection(userId,bodyCenter,bodyDir);
  
  bodyDir.mult(200);  // 200mm length
  bodyDir.add(bodyCenter);

  joints.add(bodyCenter);
  joints.add(bodyDir);
}

PVector getLimb(int userId,int jointType1 )
{
  PVector jointPos1 = new PVector();
  float  confidence;
  
  // draw the joint position
  confidence = context.getJointPositionSkeleton(userId,jointType1,jointPos1);

  return jointPos1;
}

void drawLimb(int userId,int jointType1,int jointType2)
{
  PVector jointPos1 = new PVector();
  PVector jointPos2 = new PVector();
  float  confidence;
  
  // draw the joint position
  confidence = context.getJointPositionSkeleton(userId,jointType1,jointPos1);
  confidence = context.getJointPositionSkeleton(userId,jointType2,jointPos2);

  stroke(255,0,0,confidence * 200 + 55);
  line(jointPos1.x,jointPos1.y,jointPos1.z,
       jointPos2.x,jointPos2.y,jointPos2.z);
  
  drawJointOrientation(userId,jointType1,jointPos1,50);
}

void drawJointOrientation(int userId,int jointType,PVector pos,float length)
{
  // draw the joint orientation  
  PMatrix3D  orientation = new PMatrix3D();
  float confidence = context.getJointOrientationSkeleton(userId,jointType,orientation);
  if(confidence < 0.001f) 
    // nothing to draw, orientation data is useless
    return;
    
  pushMatrix();
    translate(pos.x,pos.y,pos.z);
    
    // set the local coordsys
    applyMatrix(orientation);
    
    // coordsys lines are 100mm long
    // x - r
    stroke(255,0,0,confidence * 200 + 55);
    line(0,0,0,
         length,0,0);
    // y - g
    stroke(0,255,0,confidence * 200 + 55);
    line(0,0,0,
         0,length,0);
    // z - b    
    stroke(0,0,255,confidence * 200 + 55);
    line(0,0,0,
         0,0,length);
  popMatrix();
}

// -----------------------------------------------------------------
// SimpleOpenNI user events

void onNewUser(SimpleOpenNI curContext,int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
  
  context.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext,int userId)
{
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curContext,int userId)
{
  //println("onVisibleUser - userId: " + userId);
}


void getBodyDirection(int userId,PVector centerPoint,PVector dir)
{
  PVector jointL = new PVector();
  PVector jointH = new PVector();
  PVector jointR = new PVector();
  float  confidence;
  
  // draw the joint position
  confidence = context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_SHOULDER,jointL);
  confidence = context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_HEAD,jointH);
  confidence = context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_SHOULDER,jointR);
  
  // take the neck as the center point
  confidence = context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,centerPoint);
  
  /*  // manually calc the centerPoint
  PVector shoulderDist = PVector.sub(jointL,jointR);
  centerPoint.set(PVector.mult(shoulderDist,.5));
  centerPoint.add(jointR);
  */
  
  PVector up = PVector.sub(jointH,centerPoint);
  PVector left = PVector.sub(jointR,centerPoint);
    
  dir.set(up.cross(left));
  dir.normalize();
}



////// S SAVE HANDLER /////////

void keyPressed(){
switch(key){

  case 'm':
   if(context!=null){
     context.setMirror(!context.mirror());
    }
    break;


  case 's':
    imgTexture = get();
    imgTexture.filter(INVERT);
    imgTexture.mask(get());
    image(imgTexture,0,0);
    save( this + ".png");
    // save( fix.pdeName() + fix.getTimestamp() + "_BIG2.tiff");
  break;

  case ESC:

   if(context!=null){
     context.close();
   }
    save( this + ".png");
    // save( fix.pdeName() + fix.getTimestamp() + "_BIG2.tiff");
    exit();
  break;



    case LEFT:
      rotY += 0.1f;

      break;
    case RIGHT:
      // zoom out
      rotY -= 0.1f;

      break;
    case UP:
      if(keyEvent.isShiftDown())
        zoomF += 0.01f;
      else
        rotX += 0.1f;
      break;
    case DOWN:
      if(keyEvent.isShiftDown())
      {
        zoomF -= 0.01f;
        if(zoomF < 0.01)
          zoomF = 0.01;
      }
      else
        rotX -= 0.1f;
      break;

}

}  