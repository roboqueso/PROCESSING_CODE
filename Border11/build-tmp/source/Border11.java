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

public class Border11 extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);


Boolean isFinal = true;
int alf = 37;
float shapeSize = alf;

int cX;
int cY;

/*
#6e5c5f, #684f53, #765c5e, #988586, #887475, #c6aeaf, #977c7d, #937475, #fefdfd, #fbf8f8, #6e5a5a, #9e8787, #766e6e, #8a8181, #867777, #847c7c, #705857, #6a5251, #7c6867, #907c7b, #bda2a0, #ae9593, #8d7775, #79605d, #dfcfcd, #f4edec, #6f6867, #b29692, #987772, #8e7470, #8e6c65, #af958f, #8a6c65, #ceb6b0, #887c79, #5a5655, #9c7970, #9f7e74, #816b64, #544641, #755c52, #8e6e5f, #605a57, #89827d, #7f766f, #a49a91, #55504b, #685f56
#78726a, #625d55, #7b7568, #78766e, #716e5f, #416e24, #365a28, #c9d950, #4c6c30, #659443, #729741, #698338, #587e3a, #385529, #5b7f3b, #89b552, #87a347, #4c7036, #5b7436, #446735, #689048, #87a24c, #56763b, #688c46, #849948, #84ab55, #70964c, #638c49, #8a9b49, #5b733a, #5f7f42, #82a756, #759750, #7e924a, #476639, #8e9e50, #425e35, #405a33, #92b362, #b3cd6f, #4b653a, #c0d472, #819b57, #4f6d40, #65854f, #c8d878, #8ca15c, #899c59, #a5be6d, #8aa965, #768c54, #84a464, #7d9a5e, #5a7549, #718753, #5a7449, #a6ca7e, #57754b, #435637, #405336
*/
int[] palette = { 
0xff8B5F1A,0xffCBA53A,0xff3F230E,0xffFBDC8B,0xffA4A590,0xffE96303,0xff86724A,0xffB1CEA0,0xffD4D6CE,0xffFEF3C1,0xffCCBF8E,0xffF62200,0xff882E02,0xffB1D6D3,0xff858B64,0xffD4F0D5,0xff80B1C2,0xffB1BABB,0xffFBDCC4,0xffD6F1F1,0xff5D6260,0xffD48421,0xffD7DDEE,0xffCDBABF,0xff8D827F,0xffF0DDEE,0xffA14232,0xffEFEEEA,0xffFFFFE8,0xffECFFEC,0xffEEFFFF,0xffFFFFFF,
0xff6e5c5f, 0xff684f53, 0xff765c5e, 0xff988586, 0xff887475, 0xffc6aeaf, 0xff977c7d, 0xff937475, 0xfffefdfd, 0xfffbf8f8, 0xff6e5a5a, 0xff9e8787, 0xff766e6e, 0xff8a8181, 0xff867777, 0xff847c7c, 0xff705857, 0xff6a5251, 0xff7c6867, 0xff907c7b, 0xffbda2a0, 0xffae9593, 0xff8d7775, 0xff79605d, 0xffdfcfcd, 0xfff4edec, 0xff6f6867, 0xffb29692, 0xff987772, 0xff8e7470, 0xff8e6c65, 0xffaf958f, 0xff8a6c65, 0xffceb6b0, 0xff887c79, 0xff5a5655, 0xff9c7970, 0xff9f7e74, 0xff816b64, 0xff544641, 0xff755c52, 0xff8e6e5f, 0xff605a57, 0xff89827d, 0xff7f766f, 0xffa49a91, 0xff55504b, 0xff685f56,
0xff78726a, 0xff625d55, 0xff7b7568, 0xff78766e, 0xff716e5f, 0xff416e24, 0xff365a28, 0xffc9d950, 0xff4c6c30, 0xff659443, 0xff729741, 0xff698338, 0xff587e3a, 0xff385529, 0xff5b7f3b, 0xff89b552, 0xff87a347, 0xff4c7036, 0xff5b7436, 0xff446735, 0xff689048, 0xff87a24c, 0xff56763b, 0xff688c46, 0xff849948, 0xff84ab55, 0xff70964c, 0xff638c49, 0xff8a9b49, 0xff5b733a, 0xff5f7f42, 0xff82a756, 0xff759750, 0xff7e924a, 0xff476639, 0xff8e9e50, 0xff425e35, 0xff405a33, 0xff92b362, 0xffb3cd6f, 0xff4b653a, 0xffc0d472, 0xff819b57, 0xff4f6d40, 0xff65854f, 0xffc8d878, 0xff8ca15c, 0xff899c59, 0xffa5be6d, 0xff8aa965, 0xff768c54, 0xff84a464, 0xff7d9a5e, 0xff5a7549, 0xff718753, 0xff5a7449, 0xffa6ca7e, 0xff57754b, 0xff435637, 0xff405336
};

ArrayList _pvectors = new ArrayList();
int ct = 0;
int maxCt = 0;

////////////////////////////////////////////////////
//
public void setup() {
  // setup core sketch settings items
  
  frameRate(303);
  background(0);
  fix.alpha(alf);
  //  setup variables
  cX = width/2;
  cY = height/2;

  // RED  - stroke( #B00B13, alf*3 );
  // GREEN
  stroke( 0xff20EF12, alf*2 );

noFill();
  
  maxCt = PApplet.parseInt(360*4);
  fix.drawFrame();
//  ellipseMode(CENTER);
  
      //  scan lines
    stroke(0xff000000, alf );
    for ( int ll = 0; ll <= width; ll += 2 ) 
    {  
      strokeWeight( random(alf) );
  
      line( 0, ll, width, ll );
      line( ll, 0, ll, height );
    }
  
}


////////////////////////////////////////////////////
//

float _x = 135;
float _y = 135;
PVector thisPt,lastPt, pv1, pv2, pv3, pv4 = new PVector();

public void draw()
{
  smooth();
  noFill();
  fix.randStroke();
  
  _x = lerp( 200, random(width*1.7f), .5f );
  _y = lerp( 404, random(height), .69f );

  // store this point
  _pvectors.add( new PVector( _x, _y ) );

  if( _pvectors.size() > 1 )
  {

    //  connect this point ( _x, _y ) to the last
    lastPt = (PVector)_pvectors.get( _pvectors.size()-2 );
    strokeWeight( random( alf/10) );

/*
    if( frameCount % 2 == 0 )
      circle( lastPt.x, lastPt.y, shapeSize, shapeSize );
    else if( frameCount % 3 == 0 )  
      hexagon( lastPt.x, lastPt.y, shapeSize);
    else
      point( lastPt.x, lastPt.y );
*/

if( frameCount % 60 == 0 ) {
  stroke(0xffFF5E00, alf*1.5f );
  strokeWeight( random( shapeSize*alf) );
  ellipse( _x, _y, shapeSize*2, alf*2 ); 

  //  reset
  fix.randStroke();
  strokeWeight( random( alf) );
}


    //  drop a curve every 4th point
    if( _pvectors.size() % 4 == 0 ) {
      pv1 = (PVector)_pvectors.get( _pvectors.size()-1 );
      pv2 = (PVector)_pvectors.get( _pvectors.size()-2 );
      pv3 = (PVector)_pvectors.get( _pvectors.size()-3 );
      pv4 = (PVector)_pvectors.get( _pvectors.size()-4 );

      fix.randStroke();
      strokeWeight(2.5f);
      curve( pv1.x, pv1.y, pv2.x, pv2.y, pv3.x, pv3.y, pv4.x, pv4.y );


      strokeWeight( random(2.5f) );
      point( pv1.x, pv1.y );
      point( pv2.x, pv2.y );
      point( pv3.x, pv3.y);
      point( pv4.x, pv4.y );
      
     
    } else {

      strokeWeight( random( 9.9f) );
      fix.randStroke();
      
//      line( lastPt.x, lastPt.y, _x, _y );

      point( lastPt.x, lastPt.y );
    }


  fix.randStroke();
  strokeWeight( random(alf) );  // 2
  point( _x, _y );
  
  strokeWeight( random(alf) );  // .9
  stroke(0xff00000E, alf);  //  000000
  fix.hexagon( _x, _y, shapeSize );

       
  }
  

  if( ct >= maxCt ) {


        
    doExit();
  }
  
  ct++;
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
    save( fix.pdeName()+".png" );
  }

  noLoop();
  exit();
}


///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
public void artDaily( String dailyMsg ) {
  
  PFont font = createFont( "Silom", 18 );

  smooth();
  textFont( font );

  text( " "+dailyMsg, this.width*.45f, this.height-18);

}

  public void settings() {  size(1024, 768); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Border11" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
