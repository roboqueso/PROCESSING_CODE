// Daniel Shiffman
// Kinect Point Cloud example

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

import toxi.geom.*;
import toxi.geom.mesh.*;
import java.io.FileOutputStream;

// Kinect Library object
Kinect kinect;
//  KINECT : 640, 480

// Angle for rotation
float a = 1;

int minDepth = 200;
int maxDepth = 800;
// Scale up by 200
float factor = 999;
          
Vec3D pos1, a1, b1;
TriangleMesh mesh=new TriangleMesh("KinectScan");
// We'll use a lookup table so that we don't have to repeat the math over and over
float[] depthLookUp = new float[2048];
int rawDepth;
boolean bRecording = false;
int recordMax = 5;

void setup() {
  // Rendering in P3D
  //size(800, 600, P3D);
  size( 2100, 1500, P3D );  //  matching bg image size

//size( 1280, 960, P3D ); 


  //background( loadImage("DIVIDED13.png") );
    
    
  kinect = new Kinect(this);
  kinect.initDepth();

  // Lookup table for all possible depth values (0 - 2047)
  for (int i = 0; i < depthLookUp.length; i++) {
    depthLookUp[i] = rawDepthToMeters(i);
  }
  
  //  DEBUG
  println("KINECT : " + kinect.width + ", " + kinect.height );

strokeWeight(PI);

}

void draw() {

  //background(0);
  
  // Get the raw depth as array of integers
  int[] depth = kinect.getRawDepth();

  // We're just going to calculate and draw every 4th pixel (equivalent of 160x120)
  int skip = 4;

  // Translate and rotate
  translate(width/2, height/2, -50);
//  rotate(a);

  for (int x = 0; x < kinect.width; x += skip) {
    for (int y = 0; y < kinect.height; y += skip) {
      int offset = x + y*kinect.width;

      // Convert kinect data to world xyz coordinate
      rawDepth = depth[offset];
//  TODO: get creative with rawDepth MOD parsing to record "slices"
  
      if( rawDepth > minDepth && rawDepth < maxDepth )//&& (rawDepth % 2 == 0 ) )
      {
            
          PVector v = depthToWorld(x, y, rawDepth);


          //  NOTE: use a different mesh to get less triangular OBJs?
          //  TODO: figure out better formula to record points to mesh
          if(bRecording){
            // save to mesh
            Vec3D pos=new Vec3D(v.x*factor, v.y*factor, v.z*factor );  //  factor-v.z*factor );
            a1 = pos.add(v.x*factor+TWO_PI, v.y*factor+TWO_PI, v.z*factor+TWO_PI);
            b1 = pos.add(v.x*factor-TWO_PI, v.y*factor-TWO_PI, v.z*factor-TWO_PI);
            mesh.addFace( pos, a1, b1 );
            
            stroke(0,255,0);
          } else {
            stroke(frameCount%256);
          }

          
          pushMatrix();
          
            translate(v.x*factor, v.y*factor, factor-v.z*factor);

            // Draw a point
            point(0, 0);
          
          popMatrix();
      }
    }
  }

  // Rotate
  a += .0044f;  //0.015f;
  
  //  NOTE : testing a WRITE TO MESH ONCE mentality
  if(bRecording)
  {
    if(recordMax>0)
      recordMax--;
    else
      dumpIt();
  }
}

// These functions come from: http://graphics.stanford.edu/~mdfisher/Kinect.html
float rawDepthToMeters(int depthValue) {
  if (depthValue < 2047) {
    return (float)(1.0 / ((double)(depthValue) * -0.0030711016 + 3.3309495161));
  }
  return 0.0f;
}

PVector depthToWorld(int x, int y, int depthValue) {

  final double fx_d = 1.0 / 5.9421434211923247e+02;
  final double fy_d = 1.0 / 5.9104053696870778e+02;
  final double cx_d = 3.3930780975300314e+02;
  final double cy_d = 2.4273913761751615e+02;

  PVector result = new PVector();
  double depth =  depthLookUp[depthValue];//rawDepthToMeters(depthValue);
  result.x = (float)((x - cx_d) * depth * fx_d);
  result.y = (float)((y - cy_d) * depth * fy_d);
  result.z = (float)(depth);
  return result;
}

void dumpIt(){

      //  save PNG
      save(sketchPath("KINECTScan"+this+millis()+".png"));

      bRecording = false;
      println("SAVE OBJ!!!!");
      
      //  save OBJ
      mesh.saveAsOBJ(sketchPath("KINECTScan"+this+millis()+".obj"));
      println("MESH CLEARED!!!!");
      
      //  buh bye
      mesh.clear();
      exit();
}



////////////////////////////////////////////////////////////////////////
void keyPressed() {
  switch(key)
  {
    case 'R':
    case 'r':
    {
      bRecording = !bRecording;
    }
    break;
    
    case 'S':
    case 's':
    {
      dumpIt();
    }
    break;
  }
}
