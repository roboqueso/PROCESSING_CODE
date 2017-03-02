
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
// color[]       userClr = new color[]{ color(255,0,0),
//                                      color(0,255,0),
//                                      color(0,0,255),
//                                      color(255,255,0),
//                                      color(255,0,255),
//                                      color(0,255,255)
//                                    };

  int[]   depthMap;
  int[]   userMap;
  int     steps   = 11;  // to speed up the drawing, draw every third point
  int     index;
  PVector realWorldPoint;


//  store joints if user is detected
ArrayList<PVector> joints = new ArrayList<PVector>();
PImage imgTexture = new PImage();
float tX, tY;
// PGraphics hirez;

///////////////////////////////////////////////////////////////////////////////
void setup()
{
  // size(1024,768,P3D);  // strange, get drawing error in the cameraFrustum if i use P3D, in opengl there is no problem
  background(255);
  context = new SimpleOpenNI(this);
  if(context.isInit() == false)
  {
     println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
     exit();
     return;  
  }

  // disable mirror
  context.setMirror(true);

  // enable depthMap generation 
  context.enableDepth();
  context.enableRGB();
  // enable skeleton generation for all joints
  context.enableUser();

  strokeWeight(PI);
  smooth();  
  // perspective(radians(45),
  //             float(width)/float(height),
  //             10,150000);


  // resize sketch to match kinect
  size( context.depthWidth()*2, context.depthHeight()*2, P3D);
 }

///////////////////////////////////////////////////////////////////////////////
void draw()
{
  // update the cam
  context.update();

  
  
  // set the scene pos

  translate(context.depthWidth(), context.depthHeight(), 0);
  rotateX(rotX);
  rotateY(rotY);
  scale(zoomF);

  depthMap = context.depthMap();
  userMap = context.userMap();


  translate(0,0, -1000);  // set the rotation center of the scene 1000 infront of the camera


  // draw the pointcloud

  if(frameCount%steps==0)
  {

    
    imgTexture = context.depthImage();
    imgTexture.resize(width, height);
    tint(frameCount%255,frameCount%255,frameCount%255, 100);

    beginShape(TRIANGLES);

      texture(imgTexture);
      

      for(int y=0;y < context.depthHeight();y+=steps)
      {

        for(int x=0;x < context.depthWidth();x+=steps)
        {
          index = x + y * context.depthWidth();
          
          stroke( (color) imgTexture.get( (int)x, (int)y) );

          if(depthMap[index] > 0)
          { 
            // draw the projected point
            realWorldPoint = context.depthMapRealWorld()[index];

            if(userMap[index] == 0)
            {
              vertex(realWorldPoint.y,realWorldPoint.x, realWorldPoint.z/steps, realWorldPoint.y, realWorldPoint.x);
            }

          }
        } 
      } 
    endShape();
}




imgTexture = context.rgbImage();
imgTexture.resize(width,height);


  beginShape(QUADS);  //TRIANGLES);
    texture(imgTexture);
    tint(255,255);

  for(int y=0;y < context.depthHeight();y+=steps)
  {
    for(int x=0;x < context.depthWidth();x+=steps)
    {
      index = x + y * context.depthWidth();

      if(depthMap[index] > 0)
      { 
        // draw the projected point
        realWorldPoint = context.depthMapRealWorld()[index];

        if(userMap[index] != 0)
        {
          stroke(realWorldPoint.x%255, realWorldPoint.y%255, realWorldPoint.z%255 );
          vertex(realWorldPoint.x, realWorldPoint.y, realWorldPoint.z, realWorldPoint.y, realWorldPoint.x );

        }
      }
    } 
  } 
  endShape();



}

///////////////////////////////////////////////////////////////////////////////
// draw the skeleton with the selected joints
void drawSkeleton(int userId)
{
  // strokeWeight(3);

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

AddJoint(bodyCenter);
AddJoint(bodyDir);

  
  bodyDir.mult(200);  // 200mm length
  bodyDir.add(bodyCenter);
  
  // stroke(255,200,200);
  stroke(bodyCenter.x%255,bodyCenter.y%255,bodyCenter.z%255);

  line(bodyCenter.x,bodyCenter.y,bodyCenter.z,
       bodyDir.x ,bodyDir.y,bodyDir.z);

  // strokeWeight(1);
 


}

///////////////////////////////////////////////////////////////////////////////
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
  
  AddJoint(jointPos1);
  AddJoint(jointPos2);

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

  AddJoint(jointL);
  AddJoint(jointH);
  AddJoint(jointR);
}



//////////////////////////////////////////////

//  
//  Store point helper that does all the safety checks for you
void AddJoint(PVector pt)
{
  if( pt!=null 
    && !Float.isNaN(pt.x) 
    && !Float.isNaN(pt.y) 
    && !Float.isNaN(pt.z)
    && pt.x>0 
    && pt.y>0
    && pt.z>0 ) 
  {
    joints.add(pt);
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
    // image(hirez,0,0);
    save(pdeName() + getTimestamp() + ".png");
    // save( pdeName() + getTimestamp() + "_BIG2.tiff");
  break;

  case ESC:

   if(context!=null){
     context.close();
   }
    save(pdeName() + getTimestamp() + ".png");
    // save( pdeName() + getTimestamp() + "_BIG2.tiff");
    exit();
  break;


}

}  

public String getTimestamp() {
  return ""+month()+day()+year()+hour()+minute()+millis();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?
public String pdeName() {
  return split( this.toString(), "[")[0];
}