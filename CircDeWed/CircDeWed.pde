//	IMPORTS	////////////////////////////////////////////////////
import processing.opengl.*;

import fixlib.*;

//  https://github.com/ericfickes/FIXLIB
Fixlib fix = Fixlib.init(this);
// https://github.com/ericfickes/FIXLIB	
import fixlib.*;

Fixlib fix = Fixlib.init(this);
Boolean isFinal = true;
int alf = 42; //37;
float angle, radius = TWO_PI, x, y, cX, cY, strokeSz = 1;

color[] p3 = {  #111111, #000000, #111100, #001100, #333333, #444444, #555555, #222222, #555544, #333322, #222211, #444433, #334433, #445544, #223322, #223333, #445566, #777766, #444455, #667777, #554444, #445555, #667766, #221100, #001122, #557788, #887766, #332222, #223366, #AAAAAA, #664422, #556677, #888877, #443333, #777777, #888888, #666666, #7799AA, #998866, #7799CC, #AA9988, #221111, #113377, #DDDDDD, #774422, #112222, #99AAAA, #AAAA99, #886655, #667788, #888866, #888899, #99AA99, #775533, #446677, #9999AA, #997755, #556688, #999999, #887777, #889999, #999988, #666655, #778877, #998877, #445577, #334455, #777788, #668899, #333344, #778899, #88AABB, #EEEEEE, #EEEEDD, #996633, #88AACC, #AA9966, #335566, #AABBBB, #BBBBDD, #7799BB, #DDEEEE, #BB8855, #557799, #EEDDDD, #333366, #BBCCCC, #CCCCCC, #DDCCBB, #553322, #EEDDEE, #DDDDCC, #BBCCDD, #CCAA88, #665544, #668888, #778888, #776655, #666688, #887755, #776644, #886666, #446688, #665555, #997766, #556666, #554455, #5599CC, #775544, #99CCDD, #BB9977, #AA8877, #6677AA, #334444, #443322, #CCDDDD, #8899BB, #DDCCAA, #99BBCC, #776666, #334466, #CCDDCC, #CCBBAA, #664444, #556699, #886644, #8899AA, #997744, #553333, #998888, #554433, #444466, #775555, #664433, #779999, #88BBDD, #CCAA99, #442222, #BBCCBB, #6699BB, #CCBB99, #554422, #AA8888, #222233, #BBAA99, #99BBDD, #DDBB99, #BB9988, #223377, #AACCDD, #BBAAAA, #443344, #999977, #889988, #335555, #AABBCC, #555566, #AA8844, #885544, #EEDDCC, #774433, #CCCCBB, #223344, #112211, #555533, #666644, #556655, #665533, #446666, #554466, #557777, #665566, #554477, #665577, #777755, #663344, #773344, #556644, #222244, #224444, #555577, #553344, #224477, #4499AA, #449999, #554499, #7755AA, #333355, #6655AA, #663333, #336688, #55CCDD, #5599AA, #55AACC, #446655, #224455, #448899, #6699AA, #CCEEEE, #BBBBBB, #EEFFEE, #5555CC, #9966AA, #664477, #444499, #9977FF, #995566, #4488AA, #66CCBB, #447766, #44AACC, #66DDEE, #66CCDD, #447777, #223355, #44BBDD, #66CCEE, #335588, #55BBBB, #55BBDD, #66CCCC, #334422, #4499BB, #55CCEE, #224466, #44BBCC, #55CCBB, #AA9977, #558899, #BBAA77, #DDDDEE, #222288, #AA77FF, #AA77EE, #884444, #8877EE, #995588, #222266, #333377, #8866EE, #775577, #AA77DD, #664466, #EEDDBB, #4499CC, #66DDDD, #55BBCC, #55AAAA, #66BBAA, #337799, #335577, #55BBEE, #55AA99, #55BBAA, #3388BB, #559999, #225577, #448888, #55AA88, #336677, #55DDEE, #557766, #55CCCC, #447755, #AADDEE, #BBDDEE, #CCEEFF, #AA8855, #DDEEDD, #5577AA, #EEEECC, #886633, #552244, #BB2255, #BB2244, #552222, #7766EE, #885588, #664499, #6655CC, #AA88FF, #774444, #5555AA, #663355, #AA66BB, #7766DD, #AA77CC, #88BBCC, #446644, #3366AA, #444422, #3399BB, #3388AA, #3399DD, #559988, #3377AA, #224488, #445533, #99CCEE, #BB9966, #EECCAA, #AA8866, #7788AA, #CCCCDD, #332233, #772233, #885577, #4444AA, #9977DD, #9966EE, #774455, #8866DD, #9977EE, #9966DD, #8866AA, #337788, #558888, #33AADD, #66DDCC, #3388CC, #666677, #332244, #667799, #885555, #EECCBB, #DDBB88, #442233, #882244, #882233, #5555DD, #9966BB, #443355, #5544BB, #AA6699, #443366, #553355, #DDDDBB, #336666, #448877, #44AABB, #775566, #BBDDDD, #DDDDAA, #776699, #996644, #776633, #774466, #334488, #5544AA, #8877DD, #885599, #CCEEDD, #335544, #EEFFFF, #225588, #444488, #8855AA, #8877FF, #4488BB, #3377BB, #FFFFEE, #3344AA, #664455, #AA7744, #224433, #448855, #558855, #6699CC, #662244, #AA66AA, #6666DD, #995599, #2266AA, #226699, #558866, #7788BB, #DDCCCC, #5588BB, #6666EE, #222255, #558877, #559977, #8899CC, #CCFFEE, #333388, #5555BB, #4477AA, #DDCC99, #44AADD, #448866, #AA7733, #CC8855, #44BBEE, #CCDDEE, #FFEECC, #BB8844, #44AAEE, #DDEECC, #CCAA66, #777744, #888844, #887744, #666633, #6688AA, #447799, #AA7755, #447744, #336699, #444477, #77AABB, #552233, #662233, #BB8888, #EEDDAA, #DDAA66, #DDAA77, #337777, #CC9966, #44AAAA, #CC9955, #BBBBAA, #884422, #554488, #335533, #CCCCAA, #553366, #885533, #6655BB, #9966CC, #775588, #9977CC, #7755BB, #7766CC, #EEEEBB, #776688, #AA9999, #AADDDD, #AAAABB, #CCBBBB, #BB9999, #77AACC, #BBBBCC, #FFDDCC, #AACCCC, #663366, #CCDDBB, #7777EE, #8866BB, #443388, #4488CC, #887799, #CCAA77, #AA77BB, #775599, #998899, #CC8844, #774488, #7766BB, #225599, #99CCCC, #663322, #FFEEEE, #9988BB, #996688, #333399, #3344BB, #995577, #4455CC, #885566, #FFEEDD, #CCBBCC, #BB7744, #EECC99, #998855, #BBAABB, #99AABB, #5599BB, #FFFFFF, #AA88CC, #996699, #2244AA, #2244BB, #7755DD, #4444CC, #6655DD, #886688, #BB88CC, #AA66CC, #886699, #884466, #664488, #665588, #4477BB, #55AADD, #5577BB, #EEBB88, #AA2255, #AA2244, #BB8866, #BB7766, #774499, #8866CC, #4455DD, #AA5555, #AA7788, #FFFFDD, #AA8899, #CCAAAA, #CC9988, #4455AA, #FFCC99, #CC9999, #4444BB, #223399, #8855CC, #445588, #AA6666, #555599, #6666AA, #DDBBBB, #AA99AA, #9955AA, #776677, #2277BB, #66BB99, #DD9955, #334499, #774477, #AA6688, #BBBB99, #DDAA88, #334477, #CCBB88, #5588CC, #EECC88, #66AACC, #3344CC, #553377, #6666CC, #332266, #9977BB, #338899, #FFEEBB, #553388, #884455, #443399, #88CCDD, #CC9977, #DDFFEE, #EEFFDD, #996666, #777799, #88AADD, #665599, #222277, #BBAA88, #443377, #BBDDCC, #773333, #55AABB, #88AAAA, #99BBBB, #887788, #223388, #DD9966, #99AACC, #AABBAA, #2266BB, #775522, #6688BB, #226688, #772255, #EE2266, #DD2266, #CC2244, #442244, #BB2266, #882255, #CC2233, #3399CC, #5588AA, #AA2233, #EE2255, #662222, #992233, #AA2266, #992244, #CC2255, #44CCEE, #DD2244, #DD2255, #772244, #CC2266, #446633, #997777, #992266, #FF2266, #DD2277, #557755, #336655, #992255, #446699, #668877, #445522, #66BBBB, #55DDDD, #557744, #225566, #449988, #667755, #AA6622, #4466AA, #6666FF, #222299, #BBEEEE, #7766FF, #7766AA, #7744AA, #88BBBB, #7755CC, #DDBBAA, #995522, #335599, #FFDDAA, #FFDDBB, #BB7733, #AABBDD, #88CCEE, #8888AA, #996655, #224499, #AA5522, #99DDEE, #886677, #882266, #773322, #AA2222, #555588, #EE2244, #772222, #995555, #DDFFFF, #BB2233, #662255, #882222, #445599, #EE2233, #AAAA88, #9999BB, #BBCCAA, #442255, #885522, #FFFFCC, #BB8877, #AA7766, #447788, #DDEEFF, #BBEEFF, #AAAACC, #EEDD99, #CC8877, #3333AA, #DDCCDD, #7777AA, #CCCC99, #BB9955, #3355AA, #CCFFFF, #884433, #995533, #AA6644, #AA5544, #EEEEFF, #994433, #DDBB77, #995544, #AA6633 };
byte[] modz = { 2,3,4,5,6,7,8,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39 };
// byte[] modz = { 7,9,13,15,17,19,21,23,25,27,29, 30, 31, 32, 33, 34, 35, 36, 37 };

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);  //  P2D, P3D, OPENGL, PDF
  background(alf/PI);

  //  setup variables
  cX = width/2;
  cY = height/2;

  ellipseMode(CENTER);
  rectMode(CENTER);
  smooth();
  noFill();




//	is this app running in a browser?
/*
if(online) {  // of "if (online == true)"
	stroke(#00EF00);
	ellipse(50, 50, 60, 60);
} else {
	*/
	stroke(#EF0000);
	line(0, 0, 100, 100);
	line(100, 0, 0, 100);
//}


}



////////////////////////////////////////////////////
//
void draw()
{
    angle = frameCount;

  if( (int)frameRate % (int)modz[(int)random(modz.length)] == 0 ) {

      x = cX - int( cos(radians(angle)) * (radius+frameRate) );
      y = cY - int( sin(radians(angle)) * (radius+frameRate) );
      fix.ranPalStroke100(p3);


  strokeWeight(.75);

  beginShape(QUADS);

  //fix.evenOddStroke(#EFEFEF, 11);
  vertex( frameCount, frameCount );
  vertex( cY, frameCount);
  vertex( cX, frameCount);
fix.ranPalStroke(p3);
  vertex( frameCount, frameCount );
  vertex( frameCount, cY);
  vertex( frameCount, cX);

 // fix.evenOddStroke(#EFEFEF, 11);
  vertex( cY, frameCount );
  vertex( cY, cY);
  vertex( cY, cX);

  fix.ranPalStroke(p3);    
  vertex( frameCount, cY );
  vertex( cY, cY);
  vertex( cX, cY );

  //fix.evenOddStroke(#EFEFEF, 11);
  vertex( cX, frameCount );
  vertex( cX, cY);
  vertex( cX, cX);
  
  fix.ranPalStroke(p3);
  vertex( frameCount, cX );
  vertex( cY, cX);
  vertex( cX, cX);

  endShape();

    } else { 

      x = cX - int( cos(radians(angle)) * (radius+noise(angle)) );
      y = cY - int( sin(radians(angle)) * (radius+noise(angle)) );
      stroke( random(255) );
  }
 
    strokeWeight(random(TWO_PI) );

    point( x, y );


 if( angle % 360 == 0 ) {

  radius *= 1.21;

 }



      x = cX - int( cos(radians(angle)) * (radius+alf*sin(angle)) );
      y = cY - int( sin(radians(angle)) * (radius+alf*cos(angle)) );
      stroke( alf );
      point( x, y );
    
    
 
    if( frameCount > (width+height)*4.2 ) {

      doExit();
    }





}




///////////////////////////////////////////////////////////
//  End handler, saves png
void doExit() 
{


	// artDaily("ERICFICKES.COM" );
	artDaily( "ERICFICKES.COM" );

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  }

//	debug
// println("exit()");
java.awt.Toolkit.getDefaultToolkit().beep();


  noLoop();
  exit();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

textFont( createFont( "Silom", 18 ) );
smooth();

  fill(255);
  text( " "+dailyMsg, alf, height-alf );
}

