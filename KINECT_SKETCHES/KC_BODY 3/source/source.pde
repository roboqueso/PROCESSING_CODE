/* --------------------------------------------------------------------------
 * SimpleOpenNI User3d Test
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect 2 library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / Zhdk / http://iad.zhdk.ch/
 * date:  12/12/2012 (m/d/y)
 * ----------------------------------------------------------------------------
 */
 
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
// color[]       userClr = new color[]{ color(255,0,0),
//                                      color(0,255,0),
//                                      color(0,0,255),
//                                      color(255,255,0),
//                                      color(255,0,255),
//                                      color(0,255,255)
//                                    };
int[] userList;
// int[]   depthMap;
int[]   userMap;
int     steps   = 4;  // to speed up the drawing, draw every third point
int     index;
PVector realWorldPoint;



PImage imgTexture = new PImage();
ArrayList<PVector> joints = new ArrayList<PVector>();

void setup()
{
  size(displayWidth-210,displayHeight-210,P3D);  // strange, get drawing error in the cameraFrustum if i use P3D, in opengl there is no problem
  context = new SimpleOpenNI(this);
  if(context.isInit() == false)
  {
     println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
     doExit();
     return;  
  }

  // disable mirror
  context.setMirror(false);

  // enable depthMap generation 
  context.enableDepth();
	// context.enableRGB();
  // enable skeleton generation for all joints
  context.enableUser();

  smooth();  
  perspective(radians(45),
              float(width)/float(height),
              10,150000);
 }

void draw()
{
  // update the cam
  context.update();
  // depthMap = context.depthMap();
  userMap = context.userMap();

  	// imgTexture = context.rgbImage();	//context.depthImage();
	imgTexture = context.depthImage();
	// imgTexture.filter(INVERT);

  // set the scene pos
  translate(width/2, height/2, 0);
  rotateX(rotX);
  rotateY(rotY);
  scale(zoomF);
  
  
 
  translate(0,0,-1000);  // set the rotation center of the scene 1000 infront of the camera
  
  // draw the skeleton if it's available
  userList = context.getUsers();
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


        stroke(com.x,com.y,com.z);//frameCount%255);
        fill(com.x%255,com.y%255,com.z%255, 100);

        pushMatrix();
          translate(com.x, com.y, com.z);
          sphere(42);
        popMatrix();
      }
    }
  }    
 
    


    
    strokeWeight(random(PI,11));
    // stroke(com.x, com.y, com.z);
    noStroke();
    fill(com.x%255,com.y%255,com.z%255, 50);
    curveTightness( map(com.x, 0, width, -5, 5) );

    beginShape();//QUAD_STRIP);  //   POINTS, LINES, TRIANGLES, TRIANGLE_FAN, TRIANGLE_STRIP, QUADS, or QUAD_STRIP
    
    for(PVector pt : joints ){
      // stroke( (color) imgTexture.get((int)pt.x, (int)pt.y));
      curveVertex(pt.x, pt.y, pt.z);
    }
    endShape();


    stroke(frameCount%255);
    textureWrap(REPEAT);
    tint(tmp.x%255,tmp.y%255,tmp.z%255);//,100);
    beginShape(POLYGON);//QUAD_STRIP);  //   POINTS, LINES, TRIANGLES, TRIANGLE_FAN, TRIANGLE_STRIP, QUADS, or QUAD_STRIP
    
    texture(imgTexture);
    
    for(PVector pt : joints ){
      vertex(pt.x, pt.y, pt.z, pt.x, pt.y);
    }
    endShape();
    joints.clear();


    // draw the user pointcloud
    if(frameCount%30==0)
    {
      beginShape(POINTS);
      for(int y=0;y < context.depthHeight();y+=steps)
      {
        strokeWeight(random(TWO_PI));

        for(int x=0;x < context.depthWidth();x+=steps)
        {
          index = x + y * context.depthWidth();
          

          if(userMap[index] > 0)
          { 
            // draw the projected point
            realWorldPoint = context.depthMapRealWorld()[index];

            // stroke(realWorldPoint.x%255,realWorldPoint.y%255,realWorldPoint.z%255);
            stroke(frameCount%255);
            point(realWorldPoint.x,realWorldPoint.y,realWorldPoint.z);

          }
        } 
      } 
      endShape();
    }

    if(tmp.x>0){    
      sphereDetail(
          (int) map(tmp.x, 0, width, 3, 30),
          (int) map(tmp.y, 0, height, 3, 30)
        );


        strokeWeight(random(11));
        stroke(frameCount%255);
        fill(frameCount%255,frameCount%255,frameCount%255, 100);

        pushMatrix();
          translate(tmp.x, tmp.y, tmp.z);
          sphere(frameCount%111);
        popMatrix();
      }


}

// draw the skeleton with the selected joints
void drawSkeleton(int userId)
{

  joints.add( getLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW  ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_LEFT_FINGERTIP  ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_LEFT_FOOT  ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_LEFT_HAND  ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP  ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE  ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER  ));
  
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_HEAD  ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_NECK  ));
	joints.add( getLimb(userId, SimpleOpenNI.SKEL_TORSO  ));

  joints.add( getLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW  ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_RIGHT_FINGERTIP  ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_RIGHT_FOOT  ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_RIGHT_HAND  ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP  ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE  ));
  joints.add( getLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER  ));
  




  // draw body direction
  getBodyDirection(userId,bodyCenter,bodyDir);
  
  bodyDir.mult(200);  // 200mm length
  bodyDir.add(bodyCenter);
  
  // stroke(255,200,200);
  // line(bodyCenter.x,bodyCenter.y,bodyCenter.z,
  //      bodyDir.x ,bodyDir.y,bodyDir.z);

  // strokeWeight(1);
  joints.add(bodyCenter);

 
}

PVector getLimb(int userId,int jointType1 )
{
  PVector jointPos1 = new PVector();
  float  confidence;
  
  // draw the joint position
  confidence = context.getJointPositionSkeleton(userId,jointType1,jointPos1);

// jointPos1.add(confidence,);

  // drawJointOrientation(userId,jointType1,jointPos1,50);
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
    // image(hirez,0,0);
    save( this);
    // save( this + "_BIG2.tiff");
  break;

  case ESC:

   if(context!=null){
     context.close();
   }
    save( this);
    // save( this + "_BIG2.tiff");
    doExit();
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
