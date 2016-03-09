import processing.core.*; 
import processing.data.*; 
import processing.opengl.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class CenterSkinnyOuterFatty2 extends PApplet {

//
//  This is a PRocessing sketch
//
Boolean isFinal = true;
float alf = 11, varNum = 1;

int cX;
int cY;

//color[] palette = { #EF0000, #00EF00, #0000EF, #CECE00, #FA7680, #EF1975, #007007, #EFEF00, #FA9187, #007007, #109109 };
//ArrayList palette = new ArrayList();//{ #EF0000, #00EF00, #0000EF, #CECE00, #FA7680, #EF1975, #007007, #EFEF00, #FA9187, #007007, #109109 };


FixLib fix = new FixLib();

////////////////////////////////////////////////////
//
public void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(0xff110000);

  //  setup variables
  cX = width/2;
  cY = height/2;
  noFill();
  rectMode(CENTER);
  ellipseMode(CENTER);
}





////////////////////////////////////////////////////
//
public void draw()
{
  if( mousePressed ) {
    smooth();

    varNum = constrain( (mouseX-mouseY)*noise(frameCount), 5, 300 );
    strokeWeight( varNum );

//debug
//println(varNum);

    if( varNum > 150 )
      stroke( random(255), random(255), random(37), alf );
    else
      stroke( random(37), random(75), random(255) );
      
    fill( varNum<cX ? 0 : 255 );
    line( pmouseX, pmouseY, mouseX, mouseY ); 

    fill( varNum<cX ? 255 : 0 , alf);
    stroke( varNum<cX ? 0 : 255, alf);
    rect( pmouseX, pmouseY, varNum, varNum );

stroke(random(37),0,0);
strokeWeight(1);
line( pmouseX, pmouseY, mouseX, mouseY ); 

stroke(255,alf);
strokeWeight(.37f);
line( 0, pmouseY, width, mouseY );


  }

  if( frameCount > width+height ) {
    exit();
  }
}



///////////////////////////////////////////////////////////
//  End handler, saves png
public void exit() 
{

  artDaily("ERICFICKES.COM" );

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  }

  noLoop();
  System.gc();
  super.stop();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
public void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 18 ) );
  smooth();

  fill(0xffEFEFEF);
  text( " "+dailyMsg, this.width-430, this.height-14);
}


////////////////////
//  PASTE ZONE
////////////////////
public void  doit() { 
  stroke(random(255), alf); smooth();
line( pmouseX-232.0f, pmouseY-44.0f, cX+232.0f, cY+44.0f );
line( pmouseX-232.0f, pmouseY-44.0f, cX+232.0f, cY+44.0f );
line( pmouseX-232.0f, pmouseY-44.0f, cX+232.0f, cY+44.0f );
line( pmouseX-232.0f, pmouseY-44.0f, cX+232.0f, cY+44.0f );
line( pmouseX-232.0f, pmouseY-44.0f, cX+232.0f, cY+44.0f );
line( pmouseX-232.0f, pmouseY-44.0f, cX+232.0f, cY+44.0f );
line( pmouseX-232.0f, pmouseY-44.0f, cX+232.0f, cY+44.0f );
line( pmouseX-232.0f, pmouseY-44.0f, cX+232.0f, cY+44.0f );
line( pmouseX-232.0f, pmouseY-44.0f, cX+232.0f, cY+44.0f );
line( pmouseX-232.0f, pmouseY-44.0f, cX+232.0f, cY+44.0f );
line( pmouseX-232.0f, pmouseY-44.0f, cX+230.0f, cY+49.0f );
line( pmouseX-230.0f, pmouseY-49.0f, cX+228.0f, cY+52.0f );
line( pmouseX-228.0f, pmouseY-52.0f, cX+226.0f, cY+54.0f );
line( pmouseX-226.0f, pmouseY-54.0f, cX+222.0f, cY+59.0f );
line( pmouseX-222.0f, pmouseY-59.0f, cX+214.0f, cY+65.0f );
line( pmouseX-214.0f, pmouseY-65.0f, cX+211.0f, cY+68.0f );
line( pmouseX-211.0f, pmouseY-68.0f, cX+211.0f, cY+68.0f );
line( pmouseX-211.0f, pmouseY-68.0f, cX+208.0f, cY+73.0f );
line( pmouseX-208.0f, pmouseY-73.0f, cX+204.0f, cY+77.0f );
line( pmouseX-204.0f, pmouseY-77.0f, cX+194.0f, cY+84.0f );
line( pmouseX-194.0f, pmouseY-84.0f, cX+190.0f, cY+88.0f );
line( pmouseX-190.0f, pmouseY-88.0f, cX+183.0f, cY+97.0f );
line( pmouseX-183.0f, pmouseY-97.0f, cX+179.0f, cY+99.0f );
line( pmouseX-179.0f, pmouseY-99.0f, cX+175.0f, cY+102.0f );
line( pmouseX-175.0f, pmouseY-102.0f, cX+170.0f, cY+106.0f );
line( pmouseX-170.0f, pmouseY-106.0f, cX+167.0f, cY+109.0f );
line( pmouseX-167.0f, pmouseY-109.0f, cX+164.0f, cY+113.0f );
line( pmouseX-164.0f, pmouseY-113.0f, cX+159.0f, cY+119.0f );
line( pmouseX-159.0f, pmouseY-119.0f, cX+157.0f, cY+121.0f );
line( pmouseX-157.0f, pmouseY-121.0f, cX+155.0f, cY+124.0f );
line( pmouseX-155.0f, pmouseY-124.0f, cX+153.0f, cY+126.0f );
line( pmouseX-153.0f, pmouseY-126.0f, cX+151.0f, cY+129.0f );
line( pmouseX-151.0f, pmouseY-129.0f, cX+149.0f, cY+131.0f );
line( pmouseX-149.0f, pmouseY-131.0f, cX+147.0f, cY+133.0f );
line( pmouseX-147.0f, pmouseY-133.0f, cX+146.0f, cY+134.0f );
line( pmouseX-146.0f, pmouseY-134.0f, cX+144.0f, cY+136.0f );
line( pmouseX-144.0f, pmouseY-136.0f, cX+142.0f, cY+138.0f );
line( pmouseX-142.0f, pmouseY-138.0f, cX+141.0f, cY+140.0f );
line( pmouseX-141.0f, pmouseY-140.0f, cX+140.0f, cY+141.0f );
line( pmouseX-140.0f, pmouseY-141.0f, cX+139.0f, cY+142.0f );
line( pmouseX-139.0f, pmouseY-142.0f, cX+137.0f, cY+142.0f );
line( pmouseX-137.0f, pmouseY-142.0f, cX+137.0f, cY+143.0f );
line( pmouseX-137.0f, pmouseY-143.0f, cX+137.0f, cY+145.0f );
line( pmouseX-137.0f, pmouseY-145.0f, cX+137.0f, cY+145.0f );
line( pmouseX-137.0f, pmouseY-145.0f, cX+137.0f, cY+145.0f );
line( pmouseX-137.0f, pmouseY-145.0f, cX+137.0f, cY+145.0f );
line( pmouseX-137.0f, pmouseY-145.0f, cX+137.0f, cY+145.0f );
line( pmouseX-137.0f, pmouseY-145.0f, cX+137.0f, cY+145.0f );
line( pmouseX-137.0f, pmouseY-145.0f, cX+137.0f, cY+145.0f );
line( pmouseX-137.0f, pmouseY-145.0f, cX+137.0f, cY+145.0f );
line( pmouseX-137.0f, pmouseY-145.0f, cX+137.0f, cY+145.0f );
line( pmouseX-137.0f, pmouseY-145.0f, cX+137.0f, cY+145.0f );
line( pmouseX-137.0f, pmouseY-145.0f, cX+137.0f, cY+145.0f );
line( pmouseX-137.0f, pmouseY-145.0f, cX+137.0f, cY+145.0f );
line( pmouseX-137.0f, pmouseY-145.0f, cX+137.0f, cY+145.0f );
line( pmouseX-137.0f, pmouseY-145.0f, cX+137.0f, cY+145.0f );
line( pmouseX-137.0f, pmouseY-145.0f, cX+137.0f, cY+145.0f );
line( pmouseX-137.0f, pmouseY-145.0f, cX+137.0f, cY+145.0f );
line( pmouseX-137.0f, pmouseY-145.0f, cX+137.0f, cY+145.0f );
line( pmouseX-137.0f, pmouseY-145.0f, cX+137.0f, cY+145.0f );
line( pmouseX-137.0f, pmouseY-145.0f, cX+137.0f, cY+145.0f );
line( pmouseX-137.0f, pmouseY-145.0f, cX+137.0f, cY+145.0f );
line( pmouseX-137.0f, pmouseY-145.0f, cX+139.0f, cY+145.0f );
line( pmouseX-139.0f, pmouseY-145.0f, cX+143.0f, cY+146.0f );
line( pmouseX-143.0f, pmouseY-146.0f, cX+149.0f, cY+148.0f );
line( pmouseX-149.0f, pmouseY-148.0f, cX+154.0f, cY+150.0f );
line( pmouseX-154.0f, pmouseY-150.0f, cX+160.0f, cY+152.0f );
line( pmouseX-160.0f, pmouseY-152.0f, cX+170.0f, cY+156.0f );
line( pmouseX-170.0f, pmouseY-156.0f, cX+175.0f, cY+158.0f );
line( pmouseX-175.0f, pmouseY-158.0f, cX+192.0f, cY+163.0f );
line( pmouseX-192.0f, pmouseY-163.0f, cX+199.0f, cY+165.0f );
line( pmouseX-199.0f, pmouseY-165.0f, cX+204.0f, cY+166.0f );
line( pmouseX-204.0f, pmouseY-166.0f, cX+210.0f, cY+168.0f );
line( pmouseX-210.0f, pmouseY-168.0f, cX+216.0f, cY+169.0f );
line( pmouseX-216.0f, pmouseY-169.0f, cX+220.0f, cY+171.0f );
line( pmouseX-220.0f, pmouseY-171.0f, cX+224.0f, cY+173.0f );
line( pmouseX-224.0f, pmouseY-173.0f, cX+228.0f, cY+175.0f );
line( pmouseX-228.0f, pmouseY-175.0f, cX+231.0f, cY+176.0f );
line( pmouseX-231.0f, pmouseY-176.0f, cX+234.0f, cY+179.0f );
line( pmouseX-234.0f, pmouseY-179.0f, cX+238.0f, cY+180.0f );
line( pmouseX-238.0f, pmouseY-180.0f, cX+241.0f, cY+182.0f );
line( pmouseX-241.0f, pmouseY-182.0f, cX+244.0f, cY+183.0f );
line( pmouseX-244.0f, pmouseY-183.0f, cX+247.0f, cY+184.0f );
line( pmouseX-247.0f, pmouseY-184.0f, cX+252.0f, cY+187.0f );
line( pmouseX-252.0f, pmouseY-187.0f, cX+260.0f, cY+190.0f );
line( pmouseX-260.0f, pmouseY-190.0f, cX+264.0f, cY+192.0f );
line( pmouseX-264.0f, pmouseY-192.0f, cX+267.0f, cY+195.0f );
line( pmouseX-267.0f, pmouseY-195.0f, cX+270.0f, cY+196.0f );
line( pmouseX-270.0f, pmouseY-196.0f, cX+271.0f, cY+197.0f );
line( pmouseX-271.0f, pmouseY-197.0f, cX+271.0f, cY+197.0f );
line( pmouseX-271.0f, pmouseY-197.0f, cX+272.0f, cY+197.0f );
line( pmouseX-272.0f, pmouseY-197.0f, cX+273.0f, cY+197.0f );
line( pmouseX-273.0f, pmouseY-197.0f, cX+273.0f, cY+197.0f );
line( pmouseX-273.0f, pmouseY-197.0f, cX+273.0f, cY+197.0f );
line( pmouseX-273.0f, pmouseY-197.0f, cX+273.0f, cY+197.0f );
line( pmouseX-273.0f, pmouseY-197.0f, cX+274.0f, cY+197.0f );
line( pmouseX-274.0f, pmouseY-197.0f, cX+274.0f, cY+197.0f );
line( pmouseX-274.0f, pmouseY-197.0f, cX+275.0f, cY+197.0f );
line( pmouseX-275.0f, pmouseY-197.0f, cX+277.0f, cY+198.0f );
line( pmouseX-277.0f, pmouseY-198.0f, cX+277.0f, cY+198.0f );
line( pmouseX-277.0f, pmouseY-198.0f, cX+278.0f, cY+198.0f );
line( pmouseX-278.0f, pmouseY-198.0f, cX+278.0f, cY+198.0f );
line( pmouseX-278.0f, pmouseY-198.0f, cX+278.0f, cY+198.0f );
line( pmouseX-278.0f, pmouseY-198.0f, cX+278.0f, cY+198.0f );
line( pmouseX-278.0f, pmouseY-198.0f, cX+278.0f, cY+198.0f );
line( pmouseX-278.0f, pmouseY-198.0f, cX+278.0f, cY+198.0f );
line( pmouseX-278.0f, pmouseY-198.0f, cX+278.0f, cY+198.0f );
line( pmouseX-278.0f, pmouseY-198.0f, cX+278.0f, cY+198.0f );
line( pmouseX-278.0f, pmouseY-198.0f, cX+278.0f, cY+198.0f );
line( pmouseX-278.0f, pmouseY-198.0f, cX+278.0f, cY+198.0f );
line( pmouseX-278.0f, pmouseY-198.0f, cX+278.0f, cY+198.0f );
line( pmouseX-278.0f, pmouseY-198.0f, cX+278.0f, cY+198.0f );
line( pmouseX-278.0f, pmouseY-198.0f, cX+278.0f, cY+198.0f );
line( pmouseX-278.0f, pmouseY-198.0f, cX+278.0f, cY+198.0f );
line( pmouseX-278.0f, pmouseY-198.0f, cX+278.0f, cY+198.0f );
line( pmouseX-278.0f, pmouseY-198.0f, cX+278.0f, cY+198.0f );
line( pmouseX-278.0f, pmouseY-198.0f, cX+278.0f, cY+198.0f );
line( pmouseX-278.0f, pmouseY-198.0f, cX+278.0f, cY+198.0f );
line( pmouseX-278.0f, pmouseY-198.0f, cX+278.0f, cY+198.0f );
line( pmouseX-278.0f, pmouseY-198.0f, cX+278.0f, cY+198.0f );
line( pmouseX-278.0f, pmouseY-198.0f, cX+278.0f, cY+198.0f );
line( pmouseX-278.0f, pmouseY-198.0f, cX+278.0f, cY+198.0f );
line( pmouseX-278.0f, pmouseY-198.0f, cX+277.0f, cY+198.0f );
line( pmouseX-277.0f, pmouseY-198.0f, cX+274.0f, cY+201.0f );
line( pmouseX-274.0f, pmouseY-201.0f, cX+267.0f, cY+206.0f );
line( pmouseX-267.0f, pmouseY-206.0f, cX+264.0f, cY+210.0f );
line( pmouseX-264.0f, pmouseY-210.0f, cX+260.0f, cY+214.0f );
line( pmouseX-260.0f, pmouseY-214.0f, cX+256.0f, cY+217.0f );
line( pmouseX-256.0f, pmouseY-217.0f, cX+247.0f, cY+224.0f );
line( pmouseX-247.0f, pmouseY-224.0f, cX+242.0f, cY+228.0f );
line( pmouseX-242.0f, pmouseY-228.0f, cX+237.0f, cY+233.0f );
line( pmouseX-237.0f, pmouseY-233.0f, cX+230.0f, cY+237.0f );
line( pmouseX-230.0f, pmouseY-237.0f, cX+225.0f, cY+242.0f );
line( pmouseX-225.0f, pmouseY-242.0f, cX+220.0f, cY+246.0f );
line( pmouseX-220.0f, pmouseY-246.0f, cX+213.0f, cY+251.0f );
line( pmouseX-213.0f, pmouseY-251.0f, cX+206.0f, cY+257.0f );
line( pmouseX-206.0f, pmouseY-257.0f, cX+199.0f, cY+263.0f );
line( pmouseX-199.0f, pmouseY-263.0f, cX+194.0f, cY+266.0f );
line( pmouseX-194.0f, pmouseY-266.0f, cX+182.0f, cY+275.0f );
line( pmouseX-182.0f, pmouseY-275.0f, cX+177.0f, cY+279.0f );
line( pmouseX-177.0f, pmouseY-279.0f, cX+172.0f, cY+283.0f );
line( pmouseX-172.0f, pmouseY-283.0f, cX+172.0f, cY+283.0f );
line( pmouseX-172.0f, pmouseY-283.0f, cX+168.0f, cY+287.0f );
line( pmouseX-168.0f, pmouseY-287.0f, cX+159.0f, cY+294.0f );
line( pmouseX-159.0f, pmouseY-294.0f, cX+155.0f, cY+300.0f );
line( pmouseX-155.0f, pmouseY-300.0f, cX+151.0f, cY+304.0f );
line( pmouseX-151.0f, pmouseY-304.0f, cX+142.0f, cY+312.0f );
line( pmouseX-142.0f, pmouseY-312.0f, cX+137.0f, cY+315.0f );
line( pmouseX-137.0f, pmouseY-315.0f, cX+135.0f, cY+318.0f );
line( pmouseX-135.0f, pmouseY-318.0f, cX+132.0f, cY+321.0f );
line( pmouseX-132.0f, pmouseY-321.0f, cX+131.0f, cY+321.0f );
line( pmouseX-131.0f, pmouseY-321.0f, cX+130.0f, cY+323.0f );
line( pmouseX-130.0f, pmouseY-323.0f, cX+128.0f, cY+324.0f );
line( pmouseX-128.0f, pmouseY-324.0f, cX+127.0f, cY+326.0f );
line( pmouseX-127.0f, pmouseY-326.0f, cX+126.0f, cY+327.0f );
line( pmouseX-126.0f, pmouseY-327.0f, cX+126.0f, cY+329.0f );
line( pmouseX-126.0f, pmouseY-329.0f, cX+126.0f, cY+329.0f );
line( pmouseX-126.0f, pmouseY-329.0f, cX+125.0f, cY+329.0f );
line( pmouseX-125.0f, pmouseY-329.0f, cX+125.0f, cY+329.0f );
line( pmouseX-125.0f, pmouseY-329.0f, cX+125.0f, cY+329.0f );
line( pmouseX-125.0f, pmouseY-329.0f, cX+125.0f, cY+329.0f );
line( pmouseX-125.0f, pmouseY-329.0f, cX+125.0f, cY+329.0f );
line( pmouseX-125.0f, pmouseY-329.0f, cX+125.0f, cY+329.0f );
line( pmouseX-125.0f, pmouseY-329.0f, cX+125.0f, cY+329.0f );
line( pmouseX-125.0f, pmouseY-329.0f, cX+125.0f, cY+329.0f );
line( pmouseX-125.0f, pmouseY-329.0f, cX+125.0f, cY+329.0f );
line( pmouseX-125.0f, pmouseY-329.0f, cX+125.0f, cY+329.0f );
line( pmouseX-125.0f, pmouseY-329.0f, cX+125.0f, cY+329.0f );
line( pmouseX-125.0f, pmouseY-329.0f, cX+125.0f, cY+329.0f );
line( pmouseX-125.0f, pmouseY-329.0f, cX+125.0f, cY+329.0f );
line( pmouseX-125.0f, pmouseY-329.0f, cX+125.0f, cY+329.0f );
line( pmouseX-125.0f, pmouseY-329.0f, cX+125.0f, cY+329.0f );
line( pmouseX-125.0f, pmouseY-329.0f, cX+125.0f, cY+329.0f );
line( pmouseX-125.0f, pmouseY-329.0f, cX+125.0f, cY+329.0f );
line( pmouseX-125.0f, pmouseY-329.0f, cX+125.0f, cY+329.0f );
line( pmouseX-125.0f, pmouseY-329.0f, cX+125.0f, cY+329.0f );
line( pmouseX-125.0f, pmouseY-329.0f, cX+125.0f, cY+329.0f );
line( pmouseX-125.0f, pmouseY-329.0f, cX+125.0f, cY+329.0f );
line( pmouseX-125.0f, pmouseY-329.0f, cX+125.0f, cY+329.0f );
line( pmouseX-125.0f, pmouseY-329.0f, cX+125.0f, cY+329.0f );
line( pmouseX-125.0f, pmouseY-329.0f, cX+131.0f, cY+331.0f );
line( pmouseX-131.0f, pmouseY-331.0f, cX+135.0f, cY+334.0f );
line( pmouseX-135.0f, pmouseY-334.0f, cX+140.0f, cY+337.0f );
line( pmouseX-140.0f, pmouseY-337.0f, cX+146.0f, cY+340.0f );
line( pmouseX-146.0f, pmouseY-340.0f, cX+152.0f, cY+343.0f );
line( pmouseX-152.0f, pmouseY-343.0f, cX+159.0f, cY+347.0f );
line( pmouseX-159.0f, pmouseY-347.0f, cX+164.0f, cY+350.0f );
line( pmouseX-164.0f, pmouseY-350.0f, cX+171.0f, cY+354.0f );
line( pmouseX-171.0f, pmouseY-354.0f, cX+180.0f, cY+361.0f );
line( pmouseX-180.0f, pmouseY-361.0f, cX+187.0f, cY+367.0f );
line( pmouseX-187.0f, pmouseY-367.0f, cX+206.0f, cY+379.0f );
line( pmouseX-206.0f, pmouseY-379.0f, cX+215.0f, cY+385.0f );
line( pmouseX-215.0f, pmouseY-385.0f, cX+223.0f, cY+391.0f );
line( pmouseX-223.0f, pmouseY-391.0f, cX+229.0f, cY+394.0f );
line( pmouseX-229.0f, pmouseY-394.0f, cX+237.0f, cY+398.0f );
line( pmouseX-237.0f, pmouseY-398.0f, cX+243.0f, cY+401.0f );
line( pmouseX-243.0f, pmouseY-401.0f, cX+251.0f, cY+404.0f );
line( pmouseX-251.0f, pmouseY-404.0f, cX+258.0f, cY+407.0f );
line( pmouseX-258.0f, pmouseY-407.0f, cX+263.0f, cY+410.0f );
line( pmouseX-263.0f, pmouseY-410.0f, cX+271.0f, cY+413.0f );
line( pmouseX-271.0f, pmouseY-413.0f, cX+284.0f, cY+421.0f );
line( pmouseX-284.0f, pmouseY-421.0f, cX+284.0f, cY+421.0f );
line( pmouseX-284.0f, pmouseY-421.0f, cX+297.0f, cY+430.0f );
line( pmouseX-297.0f, pmouseY-430.0f, cX+302.0f, cY+432.0f );
line( pmouseX-302.0f, pmouseY-432.0f, cX+307.0f, cY+434.0f );
line( pmouseX-307.0f, pmouseY-434.0f, cX+311.0f, cY+435.0f );
line( pmouseX-311.0f, pmouseY-435.0f, cX+313.0f, cY+437.0f );
line( pmouseX-313.0f, pmouseY-437.0f, cX+314.0f, cY+437.0f );
line( pmouseX-314.0f, pmouseY-437.0f, cX+315.0f, cY+437.0f );
line( pmouseX-315.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+437.0f );
line( pmouseX-316.0f, pmouseY-437.0f, cX+316.0f, cY+435.0f );
line( pmouseX-316.0f, pmouseY-435.0f, cX+316.0f, cY+427.0f );
line( pmouseX-316.0f, pmouseY-427.0f, cX+316.0f, cY+421.0f );
line( pmouseX-316.0f, pmouseY-421.0f, cX+314.0f, cY+414.0f );
line( pmouseX-314.0f, pmouseY-414.0f, cX+311.0f, cY+402.0f );
line( pmouseX-311.0f, pmouseY-402.0f, cX+309.0f, cY+394.0f );
line( pmouseX-309.0f, pmouseY-394.0f, cX+309.0f, cY+394.0f );
line( pmouseX-309.0f, pmouseY-394.0f, cX+302.0f, cY+370.0f );
line( pmouseX-302.0f, pmouseY-370.0f, cX+302.0f, cY+370.0f );
line( pmouseX-302.0f, pmouseY-370.0f, cX+296.0f, cY+337.0f );
line( pmouseX-296.0f, pmouseY-337.0f, cX+295.0f, cY+328.0f );
line( pmouseX-295.0f, pmouseY-328.0f, cX+293.0f, cY+322.0f );
line( pmouseX-293.0f, pmouseY-322.0f, cX+293.0f, cY+319.0f );
line( pmouseX-293.0f, pmouseY-319.0f, cX+291.0f, cY+316.0f );
line( pmouseX-291.0f, pmouseY-316.0f, cX+288.0f, cY+302.0f );
line( pmouseX-288.0f, pmouseY-302.0f, cX+285.0f, cY+289.0f );
line( pmouseX-285.0f, pmouseY-289.0f, cX+282.0f, cY+273.0f );
line( pmouseX-282.0f, pmouseY-273.0f, cX+282.0f, cY+271.0f );
line( pmouseX-282.0f, pmouseY-271.0f, cX+280.0f, cY+256.0f );
line( pmouseX-280.0f, pmouseY-256.0f, cX+277.0f, cY+247.0f );
line( pmouseX-277.0f, pmouseY-247.0f, cX+273.0f, cY+230.0f );
line( pmouseX-273.0f, pmouseY-230.0f, cX+270.0f, cY+218.0f );
line( pmouseX-270.0f, pmouseY-218.0f, cX+270.0f, cY+211.0f );
line( pmouseX-270.0f, pmouseY-211.0f, cX+269.0f, cY+202.0f );
line( pmouseX-269.0f, pmouseY-202.0f, cX+267.0f, cY+190.0f );
line( pmouseX-267.0f, pmouseY-190.0f, cX+265.0f, cY+183.0f );
line( pmouseX-265.0f, pmouseY-183.0f, cX+265.0f, cY+175.0f );
line( pmouseX-265.0f, pmouseY-175.0f, cX+263.0f, cY+168.0f );
line( pmouseX-263.0f, pmouseY-168.0f, cX+262.0f, cY+164.0f );
line( pmouseX-262.0f, pmouseY-164.0f, cX+261.0f, cY+155.0f );
line( pmouseX-261.0f, pmouseY-155.0f, cX+259.0f, cY+151.0f );
line( pmouseX-259.0f, pmouseY-151.0f, cX+259.0f, cY+145.0f );
line( pmouseX-259.0f, pmouseY-145.0f, cX+258.0f, cY+139.0f );
line( pmouseX-258.0f, pmouseY-139.0f, cX+257.0f, cY+134.0f );
line( pmouseX-257.0f, pmouseY-134.0f, cX+257.0f, cY+130.0f );
line( pmouseX-257.0f, pmouseY-130.0f, cX+257.0f, cY+126.0f );
line( pmouseX-257.0f, pmouseY-126.0f, cX+257.0f, cY+122.0f );
line( pmouseX-257.0f, pmouseY-122.0f, cX+255.0f, cY+115.0f );
line( pmouseX-255.0f, pmouseY-115.0f, cX+255.0f, cY+111.0f );
line( pmouseX-255.0f, pmouseY-111.0f, cX+255.0f, cY+111.0f );
line( pmouseX-255.0f, pmouseY-111.0f, cX+255.0f, cY+104.0f );
line( pmouseX-255.0f, pmouseY-104.0f, cX+255.0f, cY+100.0f );
line( pmouseX-255.0f, pmouseY-100.0f, cX+255.0f, cY+97.0f );
line( pmouseX-255.0f, pmouseY-97.0f, cX+254.0f, cY+94.0f );
line( pmouseX-254.0f, pmouseY-94.0f, cX+254.0f, cY+90.0f );
line( pmouseX-254.0f, pmouseY-90.0f, cX+253.0f, cY+90.0f );
line( pmouseX-253.0f, pmouseY-90.0f, cX+253.0f, cY+90.0f );
line( pmouseX-253.0f, pmouseY-90.0f, cX+253.0f, cY+90.0f );
line( pmouseX-253.0f, pmouseY-90.0f, cX+253.0f, cY+89.0f );
line( pmouseX-253.0f, pmouseY-89.0f, cX+253.0f, cY+89.0f );
line( pmouseX-253.0f, pmouseY-89.0f, cX+253.0f, cY+89.0f );
line( pmouseX-253.0f, pmouseY-89.0f, cX+253.0f, cY+89.0f );
line( pmouseX-253.0f, pmouseY-89.0f, cX+252.0f, cY+88.0f );
line( pmouseX-252.0f, pmouseY-88.0f, cX+252.0f, cY+86.0f );
line( pmouseX-252.0f, pmouseY-86.0f, cX+250.0f, cY+78.0f );
line( pmouseX-250.0f, pmouseY-78.0f, cX+246.0f, cY+63.0f );
line( pmouseX-246.0f, pmouseY-63.0f, cX+244.0f, cY+57.0f );
line( pmouseX-244.0f, pmouseY-57.0f, cX+243.0f, cY+54.0f );
line( pmouseX-243.0f, pmouseY-54.0f, cX+243.0f, cY+52.0f );
line( pmouseX-243.0f, pmouseY-52.0f, cX+243.0f, cY+49.0f );
line( pmouseX-243.0f, pmouseY-49.0f, cX+243.0f, cY+48.0f );
line( pmouseX-243.0f, pmouseY-48.0f, cX+243.0f, cY+48.0f );
line( pmouseX-243.0f, pmouseY-48.0f, cX+243.0f, cY+48.0f );
line( pmouseX-243.0f, pmouseY-48.0f, cX+243.0f, cY+47.0f );
line( pmouseX-243.0f, pmouseY-47.0f, cX+243.0f, cY+46.0f );
line( pmouseX-243.0f, pmouseY-46.0f, cX+243.0f, cY+45.0f );
line( pmouseX-243.0f, pmouseY-45.0f, cX+243.0f, cY+44.0f );
line( pmouseX-243.0f, pmouseY-44.0f, cX+242.0f, cY+44.0f );
line( pmouseX-242.0f, pmouseY-44.0f, cX+242.0f, cY+43.0f );
line( pmouseX-242.0f, pmouseY-43.0f, cX+242.0f, cY+43.0f );
line( pmouseX-242.0f, pmouseY-43.0f, cX+242.0f, cY+41.0f );
line( pmouseX-242.0f, pmouseY-41.0f, cX+239.0f, cY+35.0f );
line( pmouseX-239.0f, pmouseY-35.0f, cX+238.0f, cY+32.0f );
line( pmouseX-238.0f, pmouseY-32.0f, cX+238.0f, cY+32.0f );
line( pmouseX-238.0f, pmouseY-32.0f, cX+236.0f, cY+28.0f );
line( pmouseX-236.0f, pmouseY-28.0f, cX+236.0f, cY+28.0f );
line( pmouseX-236.0f, pmouseY-28.0f, cX+236.0f, cY+28.0f );
line( pmouseX-236.0f, pmouseY-28.0f, cX+236.0f, cY+28.0f );
line( pmouseX-236.0f, pmouseY-28.0f, cX+236.0f, cY+28.0f );
line( pmouseX-236.0f, pmouseY-28.0f, cX+236.0f, cY+28.0f );
line( pmouseX-236.0f, pmouseY-28.0f, cX+236.0f, cY+28.0f );
line( pmouseX-236.0f, pmouseY-28.0f, cX+236.0f, cY+28.0f );
line( pmouseX-236.0f, pmouseY-28.0f, cX+236.0f, cY+28.0f );
line( pmouseX-236.0f, pmouseY-28.0f, cX+236.0f, cY+28.0f );
line( pmouseX-236.0f, pmouseY-28.0f, cX+236.0f, cY+28.0f );
line( pmouseX-236.0f, pmouseY-28.0f, cX+236.0f, cY+29.0f );
line( pmouseX-236.0f, pmouseY-29.0f, cX+236.0f, cY+29.0f );
 }

/*
FixLib is your new utility library.  House all your helper code here,
and keep the main sketch.pde as light as possible ( setup, draw, exit, artDaily )
*/
class FixLib {


  FixLib(){}



  //////////////////////////////////////////////////////
  //  
  public void drawLissajous( float a, float b, float amp )
  {
    //  float amp = 33;
    float x, y;
    float sz = amp / PI;  //TWO_PI;
  
    for ( float t = 0; t <= 360; t += 1)
    {
      x = a - amp * sin(a * t * PI/180);
      y = b - amp * sin(b * t * PI/180);
      noFill();
      ellipse(x, y, sz, sz);
    }
  }



  //////////////////////////////////////////////////////
  //  Pass in a color, and this will fill even frames with 255,
  //  odd frames with clr
  public void evenOddFill( int clr ) {
    if ( frameCount % 2 == 0 ) {
      fill(255);
    } 
    else {
      fill( clr );
    }
  }
  //////////////////////////////////////////////////////
  //  Pass in a color, and this will fill even frames with 255,
  //  odd frames with clr
  //  * INVERTED for evenOddFill() pleasure
  public void evenOddStroke( int clr ) {
    if ( frameCount % 2 == 0 ) {
      stroke(clr);
    } 
    else {
      stroke(0);
    }
  }
  
  
  
  /////////////////////////////////////////////////////////////////
  //  spit out an 8bit heart
  public void bitHeart( float x, float y, boolean grid ) {
  
    int blockSize = 25;
    float htSize = 250;
    strokeWeight(.5f);
  
    //  GRID
    if (grid) {
      stroke(0xffEFEFEF);//, 50);
  
      for ( int xx = 0 ; xx <= 13; xx++ ) {
  
        line( x+(blockSize*xx), 0, x+(blockSize*xx), height );
        line( 0, y+(blockSize*xx), width, y+(blockSize*xx) );
      }
    }
    //  GRID
  
  
  
    //  HEART
    stroke(0xff333333);
  
    //  white blocks
    fill(255);
    rect( x+(blockSize*2), y+blockSize, blockSize, blockSize );
    rect( x+(blockSize), y+(blockSize*2), blockSize, blockSize );
  
    fill(0);
    // TODO: make this smarter
    rect( x+(blockSize*2), y, blockSize, blockSize );
    rect( x+(blockSize*3), y, blockSize, blockSize );
    rect( x+(blockSize*4), y, blockSize, blockSize );
  
    rect( x+(blockSize*8), y, blockSize, blockSize );
    rect( x+(blockSize*9), y, blockSize, blockSize );
    rect( x+(blockSize*10), y, blockSize, blockSize );
  
    rect( x+(blockSize), y+blockSize, blockSize, blockSize );
  
    fill(0xffEF0000);
    rect( x+(blockSize*3), y+blockSize, blockSize, blockSize );
    rect( x+(blockSize*4), y+blockSize, blockSize, blockSize );
    rect( x+(blockSize*2), y+(blockSize*2), blockSize, blockSize );
    rect( x+(blockSize*3), y+(blockSize*2), blockSize, blockSize );
    rect( x+(blockSize*4), y+(blockSize*2), blockSize, blockSize );
    rect( x+(blockSize*5), y+(blockSize*2), blockSize, blockSize );
    rect( x+(blockSize*7), y+(blockSize*2), blockSize, blockSize );
    rect( x+(blockSize*8), y+(blockSize*2), blockSize, blockSize );
    rect( x+(blockSize*9), y+(blockSize*2), blockSize, blockSize );
    rect( x+(blockSize*10), y+(blockSize*2), blockSize, blockSize );
    rect( x+(blockSize*11), y+(blockSize*2), blockSize, blockSize );
  
    rect( x+(blockSize), y+(blockSize*3), blockSize, blockSize );
    rect( x+(blockSize*2), y+(blockSize*3), blockSize, blockSize );
    rect( x+(blockSize*3), y+(blockSize*3), blockSize, blockSize );
    rect( x+(blockSize*4), y+(blockSize*3), blockSize, blockSize );
    rect( x+(blockSize*5), y+(blockSize*3), blockSize, blockSize );
    rect( x+(blockSize*6), y+(blockSize*3), blockSize, blockSize );
    rect( x+(blockSize*7), y+(blockSize*3), blockSize, blockSize );
    rect( x+(blockSize*8), y+(blockSize*3), blockSize, blockSize );
    rect( x+(blockSize*9), y+(blockSize*3), blockSize, blockSize );
    rect( x+(blockSize*10), y+(blockSize*3), blockSize, blockSize );
    rect( x+(blockSize*11), y+(blockSize*3), blockSize, blockSize );
  
    rect( x+(blockSize), y+(blockSize*4), blockSize, blockSize );
    rect( x+(blockSize*2), y+(blockSize*4), blockSize, blockSize );
    rect( x+(blockSize*3), y+(blockSize*4), blockSize, blockSize );
    rect( x+(blockSize*4), y+(blockSize*4), blockSize, blockSize );
    rect( x+(blockSize*5), y+(blockSize*4), blockSize, blockSize );
    rect( x+(blockSize*6), y+(blockSize*4), blockSize, blockSize );
    rect( x+(blockSize*7), y+(blockSize*4), blockSize, blockSize );
    rect( x+(blockSize*8), y+(blockSize*4), blockSize, blockSize );
    rect( x+(blockSize*9), y+(blockSize*4), blockSize, blockSize );
    rect( x+(blockSize*10), y+(blockSize*4), blockSize, blockSize );
    rect( x+(blockSize*11), y+(blockSize*4), blockSize, blockSize );
  
    rect( x+(blockSize*2), y+(blockSize*5), blockSize, blockSize );
    rect( x+(blockSize*3), y+(blockSize*5), blockSize, blockSize );
    rect( x+(blockSize*4), y+(blockSize*5), blockSize, blockSize );
    rect( x+(blockSize*5), y+(blockSize*5), blockSize, blockSize );
    rect( x+(blockSize*6), y+(blockSize*5), blockSize, blockSize );
    rect( x+(blockSize*7), y+(blockSize*5), blockSize, blockSize );
    rect( x+(blockSize*8), y+(blockSize*5), blockSize, blockSize );
    rect( x+(blockSize*9), y+(blockSize*5), blockSize, blockSize );
    rect( x+(blockSize*10), y+(blockSize*5), blockSize, blockSize );
  
    rect( x+(blockSize*2), y+(blockSize*6), blockSize, blockSize );
    rect( x+(blockSize*3), y+(blockSize*6), blockSize, blockSize );
    rect( x+(blockSize*4), y+(blockSize*6), blockSize, blockSize );
    rect( x+(blockSize*5), y+(blockSize*6), blockSize, blockSize );
    rect( x+(blockSize*6), y+(blockSize*6), blockSize, blockSize );
    rect( x+(blockSize*7), y+(blockSize*6), blockSize, blockSize );
    rect( x+(blockSize*8), y+(blockSize*6), blockSize, blockSize );
    rect( x+(blockSize*9), y+(blockSize*6), blockSize, blockSize );
    rect( x+(blockSize*10), y+(blockSize*6), blockSize, blockSize );
  
    rect( x+(blockSize*3), y+(blockSize*7), blockSize, blockSize );
    rect( x+(blockSize*4), y+(blockSize*7), blockSize, blockSize );
    rect( x+(blockSize*5), y+(blockSize*7), blockSize, blockSize );
    rect( x+(blockSize*6), y+(blockSize*7), blockSize, blockSize );
    rect( x+(blockSize*7), y+(blockSize*7), blockSize, blockSize );
    rect( x+(blockSize*8), y+(blockSize*7), blockSize, blockSize );
    rect( x+(blockSize*9), y+(blockSize*7), blockSize, blockSize );
  
    rect( x+(blockSize*4), y+(blockSize*8), blockSize, blockSize );
    rect( x+(blockSize*5), y+(blockSize*8), blockSize, blockSize );
    rect( x+(blockSize*6), y+(blockSize*8), blockSize, blockSize );
    rect( x+(blockSize*7), y+(blockSize*8), blockSize, blockSize );
    rect( x+(blockSize*8), y+(blockSize*8), blockSize, blockSize );
  
    rect( x+(blockSize*5), y+(blockSize*9), blockSize, blockSize );
    rect( x+(blockSize*6), y+(blockSize*9), blockSize, blockSize );
    rect( x+(blockSize*7), y+(blockSize*9), blockSize, blockSize );
  
    rect( x+(blockSize*6), y+(blockSize*10), blockSize, blockSize );
  
    fill(0);
  
  
  
  
    rect( x+(blockSize*5), y+blockSize, blockSize, blockSize );
    rect( x+(blockSize*6), y+(blockSize*2), blockSize, blockSize );
    rect( x+(blockSize*7), y+(blockSize), blockSize, blockSize );
  
  
    fill(0xffEF0000);  
    rect( x+(blockSize*4), y+blockSize, blockSize, blockSize );
    rect( x+(blockSize*8), y+blockSize, blockSize, blockSize );
    rect( x+(blockSize*9), y+blockSize, blockSize, blockSize );
    rect( x+(blockSize*10), y+blockSize, blockSize, blockSize );
    rect( x+blockSize, y+(blockSize*5), blockSize, blockSize );
    rect( x+(blockSize*2), y+(blockSize*7), blockSize, blockSize );
    rect( x+(blockSize*3), y+(blockSize*8), blockSize, blockSize );
    rect( x+(blockSize*4), y+(blockSize*9), blockSize, blockSize );
    rect( x+(blockSize*5), y+(blockSize*10), blockSize, blockSize );  
    rect( x+(blockSize*6), y+(blockSize*11), blockSize, blockSize );
    rect( x+(blockSize*7), y+(blockSize*10), blockSize, blockSize );
    rect( x+(blockSize*8), y+(blockSize*9), blockSize, blockSize );
    rect( x+(blockSize*9), y+(blockSize*8), blockSize, blockSize );
    rect( x+(blockSize*10), y+(blockSize*7), blockSize, blockSize );
    rect( x+(blockSize*11), y+(blockSize*5), blockSize, blockSize );
  
    fill(0);
    rect( x+(blockSize*11), y+blockSize, blockSize, blockSize );
    rect( x, y+(blockSize*2), blockSize, blockSize );
    rect( x, y+(blockSize*3), blockSize, blockSize );
    rect( x, y+(blockSize*4), blockSize, blockSize );
    rect( x, y+(blockSize*5), blockSize, blockSize );
    rect( x+blockSize, y+(blockSize*6), blockSize, blockSize );
    rect( x+blockSize, y+(blockSize*7), blockSize, blockSize );
    rect( x+(blockSize*2), y+(blockSize*8), blockSize, blockSize );
    rect( x+(blockSize*3), y+(blockSize*9), blockSize, blockSize );
    rect( x+(blockSize*4), y+(blockSize*10), blockSize, blockSize );
    rect( x+(blockSize*5), y+(blockSize*11), blockSize, blockSize );
    rect( x+(blockSize*6), y+(blockSize*12), blockSize, blockSize );
    rect( x+(blockSize*7), y+(blockSize*11), blockSize, blockSize );
    rect( x+(blockSize*8), y+(blockSize*10), blockSize, blockSize );
    rect( x+(blockSize*9), y+(blockSize*9), blockSize, blockSize );
    rect( x+(blockSize*10), y+(blockSize*8), blockSize, blockSize );
    rect( x+(blockSize*11), y+(blockSize*7), blockSize, blockSize );
    rect( x+(blockSize*11), y+(blockSize*6), blockSize, blockSize );
  
    rect( x+(blockSize*12), y+(blockSize*5), blockSize, blockSize );
    rect( x+(blockSize*12), y+(blockSize*4), blockSize, blockSize );
    rect( x+(blockSize*12), y+(blockSize*3), blockSize, blockSize );
    rect( x+(blockSize*12), y+(blockSize*2), blockSize, blockSize );
  }
  
  


  
  ///////////////////////////////////////////////////////////
  //  draw a star
  public void star(int n, float cx, float cy, float w, float h, float startAngle, float proportion)
  {
    if (n > 2)
    {
      float angle = TWO_PI/ (2 *n);  // twice as many sides
      float dw; // draw width
      float dh; // draw height
  
      w = w / 2.0f;
      h = h / 2.0f;
  
      beginShape();
      for (int i = 0; i < 2 * n; i++)
      {
        dw = w;
        dh = h;
        if (i % 2 == 1) // for odd vertices, use short radius
        {
          dw = w * proportion;
          dh = h * proportion;
        }
        vertex(cx + dw * cos(startAngle + angle * i), 
        cy + dh * sin(startAngle + angle * i));
      }
      endShape(CLOSE);
    }
  }
  
  
  
  
  
  //////////////////////////
  int f0 = 0;
  int f1 = 1;
  //int f2 = 1;
  
  public int nextFib( int f2)
  {
    int result = f2;
    f0 = f1;
    f1 = f2;
    f2 = f0 + f1;
    return result;
  }
  
  //////////////////////////
  //  Calculate max loop count
  public float getMax( float shapeSize ) {
    return ( ( width * height ) / shapeSize );
  }
  
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //  pull colors out of image and return color[]
  //  http://forum.processing.org/topic/extract-colors-from-images
  public ArrayList getImgColors( PImage img ) 
  {
    ArrayList alColors = new ArrayList();
  
    img.loadPixels();
  
    int color1, color2;
    // TODO: what's a good way to pull DISTINCT colors with a color[]?
    for ( int c = 0; c < img.pixels.length; c++ ) 
    {
      if ( alColors.size() == 0 ) { 
        alColors.add( (int)img.pixels[ c ] );
      } 
      else 
      {
  
        if ( ! alColors.contains( (int)img.pixels[ c ] ) ) 
        {
          color1 = (Integer) alColors.get( alColors.size()-1 );
          color2 = img.pixels[c];
          // double distinct filtering
          if ( color1 > color2 )
          {
  
            alColors.add( (int)img.pixels[ c ] );
          }
        }
      }
    }
  
    return alColors;
  }
  
  
  
  ///////////////////////////////////////////////////////
  //  Make grid of shapes filled with each color in supplied
  //  color[]
  public void paletteGrid( ArrayList pall ) {
  
    float xx = 0;
    float yy = 0;  
    float sz = 30;
  
    // debug
    //text( pall.size() + " colors ", sz, sz );
    int tmp;
    for ( int cc = 0; cc < pall.size(); cc++ ) {
  
      noStroke();
      tmp = (Integer)pall.get(cc);
      fill( tmp, alf*4 );
      rect( xx, yy, sz, sz );
  
      if ( xx < width ) {
        xx += (sz *1.25f);
      } 
      else {
        xx = 0;
        yy += (sz *1.25f);
      }
    }
  
  
  
  
    textFont( createFont( "HiraMaruProN-W4", 222 ) );
    fill(random(alf));
    text( pall.size(), random( alf, width/3 ), random(height) );
  }
  
  
  
  
  
  
  
  //////////////////////////////////////////////////////////////////////////
  //  Draw manual circle
  //  ellipse(x, y, width, height)
  public void circle( float startX, float startY, float w, float h ) {
  
    float angle = 0;
    float x, y;
  
    while ( angle < 360 ) {
  
      // make circle draw faster by skipping angles
      if ( angle % 10 == 0 ) {
  
        x = startX - PApplet.parseInt( cos(radians(angle)) * w );
        y = startY - PApplet.parseInt( sin(radians(angle)) * w );
  
        smooth();
        ellipse( x, y, w, h );
      }
      angle++;
    }
  }
  
  ///////////////////////////////////////////////////////////////////////////
  //  draw a circle of circles
  public void circle( float startX, float startY, float w, float h, float modAngle ) {
  
    float angle = 0;
    float x, y;
  
    while ( angle < 360 ) {
  
      // make circle draw faster by skipping angles
      if ( angle % modAngle == 0 ) {
  
        x = startX - PApplet.parseInt( cos(radians(angle)) * w );
        y = startY - PApplet.parseInt( sin(radians(angle)) * w );
  
        smooth();
        ellipse( x, y, w, h );
      }
      angle++;
    }
  }
  
  //////////////////////////////////////////////////////////////////////////
  //  HEXAGON inspired by http://www.rdwarf.com/lerickson/hex/index.html
  public void hexagon( float startX, float startY, float shapeSize ) {
  
    line( startX, startY+(shapeSize*.5f), startX+(shapeSize*.25f), startY );
    line( startX+(shapeSize*.25f), startY, startX+(shapeSize*.75f), startY );
    line( startX+(shapeSize*.75f), startY, startX+(shapeSize), startY+(shapeSize*.5f) );
  
    line( startX+(shapeSize), startY+(shapeSize*.5f), startX+(shapeSize*.75f), startY+shapeSize );
    line( startX+(shapeSize*.75f), startY+shapeSize, startX+(shapeSize*.25f), startY+shapeSize );
    line( startX+(shapeSize*.25f), startY+shapeSize, startX, startY+(shapeSize*.5f) );
  }
  
  ////////////////////////////////////////////////////
  //  Return a random color from supplied palette
  public int getRanColor(ArrayList palette)
  {
    return (Integer)palette.get( (int)random( palette.size()-1 ) );
  }
  
  
  ////////////////////////////////////////////////////
  //  Randomly stroke using image from color list
  public void ranPalStroke(int[] palette)
  {
    // pallete
    stroke( palette[ PApplet.parseInt(random( palette.length-1 )) ], alf );
  }
  public void ranPalStroke(ArrayList palette)
  {
    // pallete
    stroke( (Integer)palette.get( (int)random( palette.size()-1 ) ), alf );
  }
  public void ranPalStroke100(int[] palette)
  {
    // pallete
    stroke( palette[ PApplet.parseInt(random( palette.length-1 )) ], 100 );
  }
  public void ranPalStroke100(ArrayList palette)
  {
    // pallete
    stroke( (Integer)palette.get( (int)random( palette.size()-1 ) ), 100 );
  }
  public void ranPalFill(int[] palette)
  {
    fill( palette[ PApplet.parseInt(random( palette.length-1 )) ], alf );
  }
  public void ranPalFill(ArrayList palette)
  {
    // pallete
    fill( (Integer)palette.get( (int)random( palette.size()-1 ) ), alf );
  }
  public void ranPalFill100(int[] palette)
  {
    // pallete
    fill( palette[ PApplet.parseInt(random( palette.length-1 )) ], 100 );
  }
  public void ranPalFill100(ArrayList palette)
  {
    // pallete
    fill( (Integer)palette.get( (int)random( palette.size()-1 ) ), 100 );
  }
  
  ///////////////////////////////////////////////////////////
  //  Helper to random(255) stroke
  public void randFill() {  
    fill( random(255), random(255), random(255), alf );
  }
  public void randStroke() {  
    stroke( random(255), random(255), random(255), alf );
  }
  public void randStroke100() {  
    stroke( random(255), random(255), random(255), 100 );
  }
  
  ///////////////////////////////////////////////////////////
  //  get EPOCH timestamp
//  public long getTimestamp() {
//    return new Date().getTime()/1000;
//  }
  
  public String getTimestamp() {
    //  Calendar now = Calendar.getInstance();
    //  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM", now);
  
  
    return ""+month()+day()+year()+hour()+second()+millis();
  }
  
  
  /////////////
  //  TODO: Is there a better way to get the current sketch name?
  public String pdeName() {
    return split( this.toString(), "[")[0];
  }


}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "CenterSkinnyOuterFatty2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
