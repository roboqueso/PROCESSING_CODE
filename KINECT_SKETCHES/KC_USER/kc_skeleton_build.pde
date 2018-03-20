
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


int[]   depthMap;
int[]   userMap;
int     steps   = 15;  // to speed up the drawing, draw every third point
int     index;
PVector realWorldPoint;

ArrayList<PVector> points = new ArrayList<PVector>();
PImage imgTexture = new PImage();
float tX, tY;

PGraphics hirez;

///////////////////////////////////////////////////////////////
void setup()
{
  size(1024,768,P3D);  // strange, get drawing error in the cameraFrustum if i use P3D, in opengl there is no problem
  background(255);
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


  hirez = createGraphics(width, height,P3D);
  hirez.smooth();
  
  

  hirez.perspective(radians(45),
              float(width)/float(height),
              10,150000);


 }

///////////////////////////////////////////////////////////////
void draw()
{
  try{

hirez.beginDraw();
hirez.smooth();  
hirez.strokeWeight(PI);
    if(frameCount%30==0)
    {
      imgTexture = context.depthImage();
    } else {
      imgTexture = context.rgbImage();
    }


    // update the cam
    context.update();

    // set the scene pos
    hirez.translate(width/2, height/2, 0);
    hirez.rotateX(rotX);
    hirez.rotateY(rotY);
    hirez.scale(zoomF);
    
    depthMap = context.depthMap();
    userMap = context.userMap();
    
    hirez.translate(0,0,-1000);  // set the rotation center of the scene 1000 infront of the camera

    // draw the pointcloud
    hirez.beginShape(POINTS);

    for(int y=0;y < context.depthHeight();y+=steps)
    {
      for(int x=0;x < context.depthWidth();x+=steps)
      {
        index = x + y * context.depthWidth();
        

        //	DEPTH
        if(depthMap[index] > 0)
        { 
        	// hirez.strokeWeight(random(PI));
          // draw the projected point
          realWorldPoint = context.depthMapRealWorld()[index];

  		    hirez.stroke(realWorldPoint.z%255);
          hirez.strokeWeight(HALF_PI);
          hirez.point(realWorldPoint.x,realWorldPoint.y,realWorldPoint.z);
        }

        //	USER
        if(userMap[index] > 0)
        { 
        	//hirez.strokeWeight(random(HALF_PI,PI));
          // draw the projected point
          realWorldPoint = context.depthMapRealWorld()[index];

  AddPt(realWorldPoint);
          hirez.strokeWeight(PI);
  		    hirez.stroke( realWorldPoint.x%255,realWorldPoint.y%255,realWorldPoint.z%255 );
          // hirez.fill( (color)imgTexture.get( (int)realWorldPoint.x, (int)realWorldPoint.y) );
          hirez.point(realWorldPoint.x,realWorldPoint.y,realWorldPoint.z);
        }


      } 
    } 
    hirez.endShape();
    
    // draw the skeleton if it's available
    int[] userList = context.getUsers();
    for(int i=0;i<userList.length;i++)
    {
      if(context.isTrackingSkeleton(userList[i]))
        drawSkeleton(userList[i]);
      
      // draw the center of mass
      if(context.getCoM(userList[i],com))
      {

  AddPt(com);

hirez.strokeWeight(PI);
hirez.stroke( com.z%255 );//(color)imgTexture.get( (int)com.x, (int)com.y) );
hirez.fill( (color)imgTexture.get( (int)com.x, (int)com.y) );

  hirez.pushMatrix();
    hirez.translate(com.x, com.y, com.z);
    hirez.rotateX(rotX);
    hirez.rotateY(rotY);
    hirez.rotateZ( radians(com.z) );
    hirez.box(100);
  hirez.popMatrix();

        
        // hirez.beginShape();
        //   hirez.curveVertex(com.x - 15,com.y,com.z ); 
        //   hirez.curveVertex(com.x + 15,com.y,com.z );
          
        //   hirez.curveVertex(com.x,com.y - 15,com.z);
        //   hirez.curveVertex(com.x,com.y + 15,com.z);

        //   hirez.curveVertex( com.x, com.y, com.z);

        // hirez.endShape();
      }      
    }    



  //	DRAW SOMETHING WITH COLLECTED POINTS

  hirez.beginShape(POLYGON);

    //hirez.noStroke();
  	hirez.tint( random(frameCount%width), random(frameCount%height),random(frameCount%255));
  	hirez.texture(imgTexture);

  	for( PVector pt : points )
  	{
  		// NOTE: STILL DO NAN CHECK
  		if( ! Float.isNaN(pt.x) &&  ! Float.isNaN(pt.y) &&  ! Float.isNaN(pt.z) )
  		{
        hirez.stroke( (color)imgTexture.get( (int)pt.x, (int)pt.y) );

  			tX = map(pt.x, 0, context.depthWidth(), 0, width);
  			tY = map(pt.y, 0, context.depthHeight(), 0, height);

  			// println("pt " + pt.x + "," + pt.y  + "," + pt.z );

  			hirez.vertex(tX, tY, pt.z/100, tX, tY );
  			hirez.vertex(pt.x, pt.y, pt.z/100, pt.x, pt.y );

  			hirez.vertex(tY, tX, pt.z/100, random(imgTexture.width), random(imgTexture.height) );
  			hirez.vertex(pt.y, pt.x, pt.z/100, random(imgTexture.width), random(imgTexture.height) );



  		}
  	}
  hirez.endShape();
  points.clear();

  //	DRAW SOMETHING WITH COLLECTED POINTS
hirez.endDraw();
image(hirez,0,0);

  //// TODO: REVISIT AUTO SAVING
    //  AUTO SAVE
    if(frameCount%360==0){


    rotX = (radians(random(frameCount%360)));
    rotY = (radians(random(frameCount%360)));

hirez.beginDraw();
    hirez.strokeWeight(PI);
    hirez.translate(width/2, height/2, 0);
    hirez.rotateX(rotX);
    hirez.rotateY(rotY);
    hirez.smooth();  
    hirez.noFill();
  // hirez.strokeWeight(HALF_PI);

    // draw the pointcloud
    hirez.beginShape(POLYGON);

      hirez.tint( random(frameCount%width), random(frameCount%height),random(frameCount%255), 200);
      

    for(int y=0;y < context.depthHeight();y+=steps)
    {

      imgTexture = (y%3==0) ? context.depthImage() : context.rgbImage();

      hirez.texture( imgTexture );

      for(int x=0;x < context.depthWidth();x+=steps)
      {
        // stroke(random(255),random(100));
        // stroke( random(frameCount%width), random(frameCount%height),random(frameCount%255));//,random(100));
        // fill(frameCount%255);//,random(255));
        hirez.stroke( (color)imgTexture.get( (int)x, (int)y) );

        index = x + y * context.depthWidth();

        if(depthMap[index] > 0)
        { 
          // draw the projected point
          realWorldPoint = context.depthMapRealWorld()[index];
        	hirez.vertex(realWorldPoint.x,realWorldPoint.y,realWorldPoint.z, realWorldPoint.x,realWorldPoint.y);
        }
      } 
    } 
    hirez.endShape();

scale(random(-1,1));

hirez.endDraw();
tint(255);
image(hirez,0,0);


      save( fix.pdeName() + fix.getTimestamp() + ".png");

    }
  //// TODO: REVISIT AUTO SAVING


        
        
  }
  catch (RuntimeException exc)
  {
    if(context!=null){
     context.close();
    }
    hirez.textSize(42);
    hirez.text("CRASH::"+exc, 42, height/2);
    tint(255);
    image(hirez,0,0);
    save("CRASH_"+pdeName() + getTimestamp() + ".png");
  }
}

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
  
  bodyDir.mult(200);  // 200mm length
  bodyDir.add(bodyCenter);


AddPt(bodyCenter);
AddPt(bodyDir);
  
  // stroke(255,200,200);
  stroke( (color)imgTexture.get( (int)bodyCenter.x, (int)bodyCenter.y) );

  hirez.beginShape();
    hirez.vertex(bodyCenter.x,bodyCenter.y,bodyCenter.z);
    hirez.vertex(bodyDir.x ,bodyDir.y,bodyDir.z);
  hirez.endShape();

  // hirez.strokeWeight(1);
 
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
  hirez.stroke( (color)imgTexture.get( (int)jointPos1.x, (int)jointPos1.y) );

AddPt(jointPos1);
AddPt(jointPos2);

  hirez.beginShape();
	  hirez.vertex(jointPos1.x,jointPos1.y,jointPos1.z);
	  hirez.vertex(jointPos2.x,jointPos2.y,jointPos2.z);
  hirez.endShape();
  
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
    
  hirez.pushMatrix();
    hirez.translate(pos.x,pos.y,pos.z);
    
    // set the local coordsys
    hirez.applyMatrix(orientation);
    
    // coordsys lines are 100mm long
    // x - r
    hirez.stroke(255,0,0,confidence * 200 + 55);
    hirez.line(0,0,0,
         length,0,0);
    // y - g
    hirez.stroke(0,255,0,confidence * 200 + 55);
    hirez.line(0,0,0,
         0,length,0);
    // z - b    
    hirez.stroke(0,0,255,confidence * 200 + 55);
    hirez.line(0,0,0,
         0,0,length);
  hirez.popMatrix();
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
    image(hirez,0,0);
    save( fix.pdeName() + fix.getTimestamp() + ".png");
    // save( fix.pdeName() + fix.getTimestamp() + "_BIG2.tiff");
  break;

  case ESC:

   if(context!=null){
     context.close();
   }
    image(hirez,0,0);
    save( fix.pdeName() + fix.getTimestamp() + ".png");
    // save( fix.pdeName() + fix.getTimestamp() + "_BIG2.tiff");
    exit();
  break;


}

}  
