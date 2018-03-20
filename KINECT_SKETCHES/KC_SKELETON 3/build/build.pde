
import SimpleOpenNI.*;


SimpleOpenNI context;
float        zoomF =0.5f;
float        rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
                   // the data from openni comes upside down
float        rotY = radians(0);
boolean      autoCalib=true;

PVector      bodyCenter = new PVector();
PVector      bodyDir = new PVector();
PVector      com = new PVector();                                   
PVector      com2d = new PVector();                                   
color[]       userClr = new color[]{ color(255,0,0),
                     color(0,255,0),
                     color(0,0,255),
                     color(255,255,0),
                     color(255,0,255),
                     color(0,255,255)
                   };

int[]   depthMap;
int[]   userMap;
int     steps   = 15;  // to speed up the drawing, draw every third point
int     index;
PVector realWorldPoint;

ArrayList<PVector> points = new ArrayList<PVector>();
PImage imgTexture = new PImage();
float tX, tY;


///////////////////////////////////////////////////////////////
void setup()
{
  size(1024,768,P3D);  // strange, get drawing error in the cameraFrustum if i use P3D, in opengl there is no problem
  frameRate(60);
  context = new SimpleOpenNI(this);

  if(! context.isInit() )
  {
     println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
     exit();
     return;  
  }

  // disable mirror
  context.setMirror(false);

  // enable depthMap generation 
  context.enableDepth();
  context.enableRGB();

  // enable skeleton generation for all joints
  context.enableUser();

  // stroke(255,255,255);
  smooth();  
  perspective(radians(45),
              float(width)/float(height),
              10,150000);
 }

///////////////////////////////////////////////////////////////
void draw()
{

  if(frameCount%30==0)
  {
    imgTexture = context.depthImage();
  } else {
    imgTexture = context.rgbImage();
  }


  // update the cam
  context.update();

  //background(0,0,0);
  
  // set the scene pos
  translate(width/2, height/2, 0);
  rotateX(rotX);
  rotateY(rotY);
  scale(zoomF);
  
  depthMap = context.depthMap();
  userMap = context.userMap();
  
  translate(0,0,-1000);  // set the rotation center of the scene 1000 infront of the camera

  // draw the pointcloud
  beginShape(POINTS);

  for(int y=0;y < context.depthHeight();y+=steps)
  {
    for(int x=0;x < context.depthWidth();x+=steps)
    {
      index = x + y * context.depthWidth();
      

      //	DEPTH
      if(depthMap[index] > 0)
      { 
      	strokeWeight(1);
        // draw the projected point
        realWorldPoint = context.depthMapRealWorld()[index];
		// stroke( random(frameCount%width), random(frameCount%height),random(frameCount%255), 100);
		stroke(frameCount%255);
        point(realWorldPoint.x,realWorldPoint.y,realWorldPoint.z);
      }

      //	USER
      if(userMap[index] > 0)
      { 
      	strokeWeight(random(HALF_PI,PI));
        // draw the projected point
        realWorldPoint = context.depthMapRealWorld()[index];

AddPt(realWorldPoint);

		stroke( (color)imgTexture.get( (int)realWorldPoint.x, (int)realWorldPoint.y) );
        fill( (color)imgTexture.get( (int)realWorldPoint.x, (int)realWorldPoint.y) );
        point(realWorldPoint.x,realWorldPoint.y,realWorldPoint.z);
      }


    } 
  } 
  endShape();
  
  // draw the skeleton if it's available
  int[] userList = context.getUsers();
  for(int i=0;i<userList.length;i++)
  {
    if(context.isTrackingSkeleton(userList[i]))
      drawSkeleton(userList[i]);
    
    // draw the center of mass
    if(context.getCoM(userList[i],com))
    {
      // stroke(100,255,0);
      strokeWeight(random(PI));

AddPt(com);

      beginShape(TRIANGLES);
      	tint(frameCount%255);
      	texture(imgTexture);

        vertex(com.x - 15,com.y,com.z, com.x - 15,com.y); 
        vertex(com.x + 15,com.y,com.z, com.x + 15,com.y);
        
        vertex(com.x,com.y - 15,com.z, com.x,com.y - 15);
        vertex(com.x,com.y + 15,com.z, com.x,com.y + 15);

        vertex(com.x,com.y,com.z - 15, com.x,com.y);
        vertex(com.x,com.y,com.z + 15, com.x,com.y);
      endShape();
    }      
  }    



//	DRAW SOMETHING WITH COLLECTED POINTS

beginShape(POLYGON);

	tint( random(frameCount%width), random(frameCount%height),random(frameCount%255), 200);
	texture(imgTexture);

	for( PVector pt : points )
	{
		// NOTE: STILL DO NAN CHECK
		if( ! Float.isNaN(pt.x) &&  ! Float.isNaN(pt.y) &&  ! Float.isNaN(pt.z) )
		{
			tX = map(pt.x, 0, context.depthWidth(), 0, width);
			tY = map(pt.y, 0, context.depthHeight(), 0, height);

			// println("pt " + pt.x + "," + pt.y  + "," + pt.z );

			vertex(tX, tY, pt.z/100, tX, tY );
			vertex(pt.x, pt.y, pt.z/100, pt.x, pt.y );

			vertex(tY, tX, pt.z/100, random(imgTexture.width), random(imgTexture.height) );
			vertex(pt.y, pt.x, pt.z/100, random(imgTexture.width), random(imgTexture.height) );

			vertex( lerp(tY, pt.y, random(.9)), lerp(tX, pt.x, random(.9)), pt.z/100, random(imgTexture.width), random(imgTexture.height) );
			vertex( lerp(tX, pt.x, random(.9)), lerp(tY, pt.y, random(.9)), pt.z/100, random(imgTexture.width), random(imgTexture.height) );
		}
	}
endShape();
points.clear();

//	DRAW SOMETHING WITH COLLECTED POINTS


//// TODO: REVISIT AUTO SAVING
  //  AUTO SAVE
  if(frameCount%360==0){

noFill();

strokeWeight(random(PI));


  // draw the pointcloud
  beginShape(POLYGON);

    tint( random(frameCount%width), random(frameCount%height),random(frameCount%255), 200);
    

  for(int y=0;y < context.depthHeight();y+=steps)
  {

    imgTexture = (y%3==0) ? context.depthImage() : context.rgbImage();

    texture( imgTexture );

    for(int x=0;x < context.depthWidth();x+=steps)
    {
      // stroke(random(255),random(100));
      // stroke( random(frameCount%width), random(frameCount%height),random(frameCount%255));//,random(100));
      // fill(frameCount%255);//,random(255));
      stroke( (color)imgTexture.get( (int)x, (int)y) );

      index = x + y * context.depthWidth();

      if(depthMap[index] > 0)
      { 
        // draw the projected point
        realWorldPoint = context.depthMapRealWorld()[index];
      	vertex(realWorldPoint.x,realWorldPoint.y,realWorldPoint.z, realWorldPoint.x,realWorldPoint.y);
      }
    } 
  } 
  endShape();


    save( fix.pdeName() + fix.getTimestamp() + ".png");



  }
//// TODO: REVISIT AUTO SAVING


        
          


}

// draw the skeleton with the selected joints
void drawSkeleton(int userId)
{
  strokeWeight(3);

  // to get the 3d joint data
  drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);

  drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);

  drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);

  drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);

  drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);

  drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);  

  // draw body direction
  getBodyDirection(userId,bodyCenter,bodyDir);
  
  bodyDir.mult(200);  // 200mm length
  bodyDir.add(bodyCenter);


AddPt(bodyCenter);
AddPt(bodyDir);
  
  // stroke(255,200,200);
  stroke( (color)imgTexture.get( (int)bodyCenter.x, (int)bodyCenter.y) );

  beginShape();
    vertex(bodyCenter.x,bodyCenter.y,bodyCenter.z);
    vertex(bodyDir.x ,bodyDir.y,bodyDir.z);
  endShape();

  strokeWeight(1);
 
}


void drawLimb(int userId,int jointType1,int jointType2)
{
  PVector jointPos1 = new PVector();
  PVector jointPos2 = new PVector();
  float  confidence;
  
  // draw the joint position
  confidence = context.getJointPositionSkeleton(userId,jointType1,jointPos1);
  confidence = context.getJointPositionSkeleton(userId,jointType2,jointPos2);

  // stroke(255,0,0,confidence * 200 + 55);
  stroke( (color)imgTexture.get( (int)jointPos1.x, (int)jointPos1.y) );

AddPt(jointPos1);
AddPt(jointPos2);

  beginShape();
	  vertex(jointPos1.x,jointPos1.y,jointPos1.z);
	  vertex(jointPos2.x,jointPos2.y,jointPos2.z);
  endShape();
  
  // drawJointOrientation(userId,jointType1,jointPos1,50);
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


// // -----------------------------------------------------------------
// // Keyboard events

// void keyPressed()
// {
//   switch(key)
//   {
//   case ' ':
//     context.setMirror(!context.mirror());
//     break;
//   }
    
//   switch(keyCode)
//   {
//     case LEFT:
//       rotY += 0.1f;
//       break;
//     case RIGHT:
//       // zoom out
//       rotY -= 0.1f;
//       break;
//     case UP:
//       if(keyEvent.isShiftDown())
//         zoomF += 0.01f;
//       else
//         rotX += 0.1f;
//       break;
//     case DOWN:
//       if(keyEvent.isShiftDown())
//       {
//         zoomF -= 0.01f;
//         if(zoomF < 0.01)
//           zoomF = 0.01;
//       }
//       else
//         rotX -= 0.1f;
//       break;
//   }
// }

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
    
AddPt(jointL);
AddPt(jointH);
AddPt(jointR);
AddPt(up);
AddPt(left);

  dir.set(up.cross(left));
  dir.normalize();
}

//////////////////////////////////////////////

//  
//  Store point helper that does all the safety checks for you
void AddPt(PVector pt)
{
  if( pt!=null 
    && !Float.isNaN(pt.x) 
    && !Float.isNaN(pt.y) 
    && !Float.isNaN(pt.z)
    && pt.x>0 
    && pt.y>0
    && pt.z>0 ) 
  {
    points.add(pt);
  }
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
    save( fix.pdeName() + fix.getTimestamp() + ".png");
    // save( fix.pdeName() + fix.getTimestamp() + "_BIG2.tiff");
  break;

  case ESC:

   if(context!=null){
     context.close();
   }
  
    save( fix.pdeName() + fix.getTimestamp() + ".png");
    // save( fix.pdeName() + fix.getTimestamp() + "_BIG2.tiff");
    exit();
  break;


}

}  
