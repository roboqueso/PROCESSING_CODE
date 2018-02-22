import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import fixlib.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class SphereThing extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);

//
//  go smaller

Boolean isFinal = true;
int alf = 13;


float shapeSize = 10100;
float minShapeSize = 500;
float finalShapeSize = 50;


int cX;
int cY;

// #524a52, #645c64, #6e656e, #988d98, #938b93, #918a91, #938793, #887f88, #978e96, #5e555d, #7a7279, #7c6f7a, #6e686d, #685d66, #867c84, #92848f, #8b8289, #756872, #3e363c, #6a6268, #8b8088, #4e434b, #867b83, #756771, #645a61, #786e75, #978a93, #8b7f87, #564d53, #665d63, #7b7077, #756a71, #6d6369, #6e676b, #4f444a, #42383d, #655b60, #61545a, #a39199, #5e5559, #94888d, #706266, #73676a, #78676b, #685559, #9f858a, #908587, #a3868b, #6e5c5f, #684f53, #765c5e, #988586, #887475, #c6aeaf, #977c7d, #937475, #fefdfd, #fbf8f8, #6e5a5a, #9e8787, #766e6e, #8a8181, #867777, #847c7c, #705857, #6a5251, #7c6867, #907c7b, #bda2a0, #ae9593, #8d7775, #79605d, #dfcfcd, #f4edec, #6f6867, #b29692, #987772, #8e7470, #8e6c65, #af958f, #8a6c65, #ceb6b0, #887c79, #5a5655, #9c7970, #9f7e74, #816b64, #544641, #755c52, #8e6e5f, #605a57, #89827d, #7f766f, #a49a91, #55504b, #685f56, #78726a, #625d55, #7b7568, #78766e, #716e5f, #416e24, #365a28, #c9d950, #4c6c30, #659443, #729741, #698338, #587e3a, #385529, #5b7f3b, #89b552, #87a347, #4c7036, #5b7436, #446735, #689048, #87a24c, #56763b, #688c46, #849948, #84ab55, #70964c, #638c49, #8a9b49, #5b733a, #5f7f42, #82a756, #759750, #7e924a, #476639, #8e9e50, #425e35, #405a33, #92b362, #b3cd6f, #4b653a, #c0d472, #819b57, #4f6d40, #65854f, #c8d878, #8ca15c, #899c59, #a5be6d, #8aa965, #768c54, #84a464, #7d9a5e, #5a7549, #718753, #5a7449, #a6ca7e, #57754b, #435637, #405336, #8ca66b, #707a4d, #526542, #95a76b, #3f4a30, #a8bb78, #89ae74, #6c8c5e, #31422d, #96b176, #6f895d, #2b3b29, #87a06c, #7d9466, #8aa673, #8baf7b, #75855d, #849d70, #555f43, #8b9e71, #46543d, #5c694d, #5a6e52, #95ae81, #879f77, #748463, #7b9271, #718468, #606450, #91a082, #5c604e, #40483b, #505647, #545c4d, #2d2831, #514f5e, #797d6b, #5e5869, #656a5b, #4e4f44, #6d6e5f, #736b7e, #879582, #545360, #53515d, #707a6c, #706d7d, #504853, #888093, #a8b19d, #443d46, #585460, #786e7e, #484852, #51525c, #716775, #7c707f, #7a7281, #979787, #504f59, #625d69, #6b6471, #939c8c, #5b6359, #645c68, #625e6a, #7b7280, #474149, #46424a, #59525c, #837f8e, #655c67, #938797, #706773, #615963, #85808e, #6b6671, #706772, #787480, #636960, #616a65, #746f7a, #a396a5, #625b64, #817e8a, #6d7067, #8c818d, #7a7781, #beb6c5, #827c86, #5d575e, #96909b, #8d848e, #676168, #86838c, #99959f, #6a656b, #d7d4de, #7c7b80, #4e4d4f
int[] palette = { 
0xff000000,
0xffB00B13,
0xff1975EF
};

int[] boobColors = {
0xff0B00B5,
0xffB000B5,
0xff2B00B5,
0xffB00B1E,
0xffB00B33,

0xff080085,
0xff800085,
0xff280085,
0xff80081E,
0xff800833
};

int x = 0;
int y = 0;

int ct = 0;
float maxCt = 0;

////////////////////////////////////////////////////
//
public void setup() {
  // setup core sketch settings items
  
  frameRate(303);
  background(alf);
  fix.alpha(alf);
  noFill();
  strokeWeight(.5f);
  

// DEBUG
//drawSuns(); 
//exit();

}


////////////////////////////////////////////////////
//

public void draw()
{



    //  re-init loop vars
    x = y = ct = (int)-alf;
    maxCt = fix.getMax( shapeSize );
    
    
    
    //  GRID LOOP  
    while( ct < maxCt ) {
    
      smooth();  

      if( shapeSize >= minShapeSize ) {

        strokeWeight( random(shapeSize*.85f) );
        
        stroke( random(alf), alf );  // stroke( 0, alf );

        ellipse( x+alf, y, shapeSize, shapeSize );
       


      } else {
        strokeWeight( random(3.33f) );
        fix.ranPalStroke(palette);

        //fix.circle( x, y, shapeSize, shapeSize );
        fix.hexagon( x, y, shapeSize );
        
        fix.ranPalStroke(palette);
        rect( x, y, shapeSize, shapeSize );
        ellipse( x, y, shapeSize, shapeSize );
        
      }

      if( x >= width ) {
        x = (int)-alf;
        y += shapeSize; 
      } else {
        x += shapeSize;
      }
      
      ct++;

    if( shapeSize <= finalShapeSize ) 
    {
      // shrink the shape
      shapeSize = shapeSize * .9f ;
    }
  }


drawSuns();

//stroke( #EF1975, alf );
//fix.drawFrame();

  doExit();
}






///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
public void doExit() 
{

  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
save( fix.pdeName() + fix.getTimestamp()+".png" );
  }
  
  noLoop();
  exit();
}


///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
public void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 18 ) );
  smooth();

  fill(0xffEFEFEF);
  text( " "+dailyMsg, this.width*.45f, this.height-18);
}



///////////////////////////////
//  draw a center line core
//  draw the wirey outer shine
public void drawSuns() {
 
float radius1, radius2, radius3, radius4;
float xx1, yy1, xx2, yy2, xx3, yy3, xx4, yy4;
float angle1, angle2, angle3, angle4;
float startX1, startY1, startX2, startY2, startX3, startY3, startX4, startY4;

// init 
radius1 = 50;  //75;
radius2 = 130;  //200;

radius3 = 175;
radius4 = 300;

startX1 = startX2 = startX3 = startX4 = (width/2);
startY1 = startY2 = startY3 = startY4 = (height/2);
angle1 = angle2 = 0;

angle3 = 103;
angle4 = 110;

// draw circles
  while ( angle1 < 1080 ) {
    
    smooth();
    
    xx1 = startX1 - PApplet.parseInt( cos(radians(angle1)) * radius1 );
    yy1 = startY1 - PApplet.parseInt( sin(radians(angle1)) * radius1 );

    xx2 = startX2 - PApplet.parseInt( cos(radians(angle2)) * radius2 );
    yy2 = startY2 - PApplet.parseInt( sin(radians(angle2)) * radius2 );

    xx3 = startX3 - PApplet.parseInt( cos(radians(angle3)) * radius3 );
    yy3 = startY3 - PApplet.parseInt( sin(radians(angle3)) * radius3 );

    xx4 = startX4 - PApplet.parseInt( cos(radians(angle4)) * radius4 );
    yy4 = startY4 - PApplet.parseInt( sin(radians(angle4)) * radius4 );


    // inner
    




fix.ranPalStroke(palette);
//    stroke( #ACE511, alf*4);  // 19EF75  EFAA36
    strokeWeight( random(1.5f) );
    line( xx1, yy1, xx2, lerp(yy1, yy2, random(.88f) ) );

    if( xx1 % 2 == 0 ) {
//      strokeCap(SQUARE);
      stroke( 0xffEFEF36, (alf*4));  // random(111)
    } else {
//      strokeCap(PROJECT);
      stroke( 0xffEF1111, (alf*2));  // random(111)
    }
    
    strokeWeight( random(4.99f) );
    line( xx1, yy1, xx2, yy2);
    
    stroke( 0xffEFEF36, alf*4);  // random(111)
    strokeWeight( random(alf/1.5f) );
    point( xx1, yy1 );


    // outer
    stroke( 0xffACE511, alf*3);  //  #EFEFEF  #ACE511
//  #ACE511
    strokeWeight( random(1.9f) );
    line( xx3, yy3, xx4, yy4 );

    angle1 += 6;
    angle2 += 6;

    angle3 += 2;//8;
    angle4 += 12;
  }
 
  
}




  public void settings() {  size(1024, 768);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "SphereThing" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
