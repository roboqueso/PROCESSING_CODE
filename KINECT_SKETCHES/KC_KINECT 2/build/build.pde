/**

KC KINECT

Kinect powered painting app for Subterranean Gallery event Nov 7, 2014

Kinect detects points in skeleton ( and scene analyze? )

Store vectors

Draw shape using the points, filling text with ARTS ( kinect image or PNG assets )

**/

import SimpleOpenNI.*;

SimpleOpenNI  context;
PVector com = new PVector();                                   
PVector com2d = new PVector();                                   
int[] userList;
int ct;
float tX, tY, tZ, eSz;

//	FIRE STUFF

ArrayList<PVector> points = new ArrayList<PVector>();
PImage imgTexture = new PImage();

//	FIRE STUFF


void setup()
{
	size(displayWidth-210, displayHeight - 210, P3D); 

	context = new SimpleOpenNI(this);
   
  // enable depthMap generation 
  context.enableDepth();
  context.enableUser();
  
  // enable camera image generation
  context.enableRGB();
 
  background(255);
  
 
}


void draw()
{


	if(frameCount%10==0)
	{

		if(context!=null)
		{
		  // update the cam
		  context.update();
	  	  
		  //	grab user list
		  userList = context.getUsers();

		  //	got users?
			if(userList.length > 0 )
			{
				for(int i=0;i<userList.length;i++)
				{

					if(context.isTrackingSkeleton(userList[i]))
					{
						getSkeletonPoints(userList[i]);
					}      

					// draw the center of mass
					if(context.getCoM(userList[i],com))
					{
						context.convertRealWorldToProjective(com,com2d);

						AddPt(com);
						AddPt(com2d);
					}
				}    


				imgTexture = context.depthImage();

tint( random(frameCount%width), random(frameCount%height),random(frameCount%255), 200);
noStroke();

			  	beginShape(POLYGON);


			  	texture(imgTexture);


			    for( PVector pt : points ){

					// NOTE: STILL DO NAN CHECK
					if( ! Float.isNaN(pt.x) &&  ! Float.isNaN(pt.y) &&  ! Float.isNaN(pt.z) ){


tX = map(pt.x, 0, context.depthWidth(), 0, width);
tY = map(pt.y, 0, context.depthHeight(), 0, height);

// println("pt " + pt.x + "," + pt.y  + "," + pt.z );

vertex(tX, tY, pt.z/100, random(imgTexture.width), random(imgTexture.height) );
vertex(pt.x, pt.y, pt.z/100, random(imgTexture.width), random(imgTexture.height) );

vertex(tY, tX, pt.z/100, random(imgTexture.width), random(imgTexture.height) );
vertex(pt.y, pt.x, pt.z/100, random(imgTexture.width), random(imgTexture.height) );

vertex( lerp(tY, pt.y, random(.9)), lerp(tX, pt.x, random(.9)), pt.z/100, random(imgTexture.width), random(imgTexture.height) );
vertex( lerp(tX, pt.x, random(.9)), lerp(tY, pt.y, random(.9)), pt.z/100, random(imgTexture.width), random(imgTexture.height) );


					}
			    }
			  	endShape();
			  	points.clear();
			//	FIRE STUFF

			} 
			else 
			{

		// println( frameCount + " : no users ");

				imgTexture = context.userImage();

				// tint(255,random(100));
				// image(imgTexture, frameCount%width, frameCount%height, random(width), random(height));
				tint( random(frameCount%width), random(frameCount%height),random(frameCount%255),random(100));
				image(imgTexture, frameCount%width, random(height), random(width), random(height));

		  // draw depthImageMap
		  tint(255,random(50));
		  // image(context.depthImage(),frameCount%width,0);
		  image(context.userImage(), (width-context.depthWidth()),frameCount%height);

			}


		}

	}
	else
	{
		
		stroke(random(255),random(100));
		strokeWeight(random(TWO_PI));
		point( random(width), random(height) );

	}

}

//	
//	Store point helper that does all the safety checks for you
void AddPt(PVector pt)
{
	if(	pt!=null 
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


// draw the skeleton with the selected joints
void getSkeletonPoints(int userId)
{
  // to get the 3d joint data
  /*
  PVector jointPos = new PVector();
  context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,jointPos);
  println(jointPos);
  */
  
  //	tmp vector
  PVector pt = new PVector();
	
//	FIRE STUFF

	context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_NECK, pt); 
	AddPt(pt);

	context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, pt); 
	AddPt(pt);

	context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, pt); 
	AddPt(pt);

	context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_NECK, pt); 
	AddPt(pt);

	context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, pt); 
	AddPt(pt);

	context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, pt); 
	AddPt(pt);

	context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, pt); 
	AddPt(pt);

	context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, pt); 
	AddPt(pt);

	context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_TORSO, pt); 
	AddPt(pt);

	context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HIP, pt); 
	AddPt(pt);

	context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_KNEE, pt); 
	AddPt(pt);

	context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_TORSO, pt); 
	AddPt(pt);

	context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HIP, pt); 
	AddPt(pt);

	context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, pt); 
	AddPt(pt);


//	FIRE STUFF

/*
  context.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);

  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);

  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);

  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);

  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);

  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);  
  */
}

// -----------------------------------------------------------------
// SimpleOpenNI events

void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
  
  curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curContext, int userId)
{
  //println("onVisibleUser - userId: " + userId);
}

void onNewHand(SimpleOpenNI curContext,int handId,PVector pos)
{
  println("onNewHand - handId: " + handId + ", pos: " + pos);
  
  AddPt(pos);

}
void onTrackedHand(SimpleOpenNI curContext,int handId,PVector pos)
{
  //println("onTrackedHand - handId: " + handId + ", pos: " + pos );
	AddPt(pos);
  // ArrayList<PVector> vecList = handPathList.get(handId);
  // if(vecList != null)
  // {
  //   vecList.add(0,pos);
  //   if(vecList.size() >= handVecListSize)
  //     // remove the last point 
  //     vecList.remove(vecList.size()-1); 
  // }  
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
  break;

  case ESC:
  	if(context!=null){
  		context.close();
  	}
    save( fix.pdeName() + fix.getTimestamp() + ".png");
    stop();
  break;
}

}  
