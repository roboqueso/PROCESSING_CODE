// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;
int alf = 13;
float x,y, t;
float angle = 0;
float xx, yy, startX, startY;
float w = 21;


// image
PImage img;
ArrayList p3;

int i = 0, cX, cY, rad = 37; 
Boolean on = false;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size( 1024, 768);
  background(0);
  frameRate(666);

  fix.alpha(alf);
  noFill();
  smooth();
  ellipseMode(CENTER);
  //  setup variables
  cX = floor(width*.42);
  cY = height/2;
  
  img = loadImage("emco2.png");

  //  MAKE TILED BACKGROUND
  for( int yy = 0; yy <= 768; yy += img.height ){

    for( int xx = 0; xx <= 1024; xx += img.width ){
      image( img, xx, yy );
    }
  }
    
  filter(GRAY);  //  INVERT);//
  
  p3 = fix.getImgColors( img );
    
  
   xx = yy = -(w/2); 

}


////////////////////////////////////////////////////
//
void draw()
{
    strokeWeight(1);  
    if( yy < height ) {
      fix.ranPalStroke( p3 );
      fix.drawLissajous( xx, yy, alf/HALF_PI );
    }
    
    if( xx < height ) {
      fix.ranPalStroke( p3 );
      fix.drawLissajous( yy, xx, alf/HALF_PI );
    }

//    stroke(#EF1975, alf);
    fix.ranPalStroke( p3 );
    bezier( xx, yy, yy, xx, xx, yy, xx, yy );
//    stroke(#1975EF, alf);
    fix.ranPalStroke( p3 );
    bezier( yy, xx, xx, yy, yy, xx, yy, xx );

    strokeWeight(1);  
    stroke( #370000,100 );
    curve( xx, yy, rad, frameCount, alf, frameCount, yy, xx );
    curve( yy, xx, rad, frameCount, alf, frameCount, xx, yy );

    strokeWeight(HALF_PI);  
    stroke(0, 99);
    systems( yy, xx );

    systems( rad, frameCount );
    systems( frameCount, rad );
    
    strokeWeight( random(TWO_PI) );
    stroke(random(25,75) );
    systems( xx, yy );
    
    strokeWeight(QUARTER_PI);
    stroke( #003700,100 );
    systems( xx, yy ); 
    systems( yy, xx );
    systems( rad, frameCount );
    systems( frameCount, rad );
    
  //  circles
  
 if( frameCount % alf == 0){
        on = !on;
    }
 
    //  bring the noise
    
    if(on){
//        stroke(random(255),100);
        x = floor( cX+cos(radians(frameCount))*rad );
        y = floor( cY+sin(radians(frameCount))*rad )+noise(frameCount)+noise(rad);
 
    } else {
//       stroke(random(111), 100);
        x = floor( cX+cos(radians(frameCount))*rad );
        y = floor( cY+sin(radians(frameCount))*rad );
    }

    fix.ranPalStroke(p3);
    strokeWeight(random(11));
    point( x, y );
    point( y, x );

    strokeWeight(random(TWO_PI));
    
    stroke( random(rad), random(rad), random(rad), alf*PI );
    systems( x+rad, y+rad );//, rad, rad );
    stroke( random(rad), random(rad), random(alf), alf*PI );
    systems( y-rad, x-rad);//, rad, rad );


 
    if( frameCount % 360 == 0){
        rad += 42;
        on = !on;
    }
  
  //  circles


  
  t++;

  if( xx > width ) {
    xx = -(w/2);
    yy += w;
  } else {
    xx += w; 
  }




  if( yy > width ) {
    doExit();
  }

}


///////////////////////////////////////////////////////////////////
//    Create a SWITCH based drawing system that accepts X, Y, and
//    randomly choose which movement system to fire
void systems( float x, float y )
{
    int pick = floor(random(0,3));
 
 fill(random(11,42));
 text( x + " " + y + " " + pick, 1024-x*cos(x), 768-y*sin(y) );
 noFill();
 
    switch( pick ){
        
        case 0:
        {
            x = floor( (width/2)+cos(radians(frameCount))*(x-y) );
            y = floor( (height/2)+sin(radians(frameCount))*(y-x) );
            point( x-PI, y+PI );
            point( y+PI, X-PI );
        }
        break;
        
        case 1:
        {
            ellipse( x*cos(frameCount)*radians(TWO_PI), y*sin(frameCount)*radians(TWO_PI), alf, alf );
            ellipse( y*cos(frameCount)*radians(TWO_PI), x*sin(frameCount)*radians(TWO_PI), alf, alf );
        }
        break;
        
        case 2:
        {
            strokeWeight(.75);
            rect( x, y, TWO_PI+x*noise(frameCount), TWO_PI+x*noise(frameCount) );
            rect( y, x, TWO_PI+y*noise(frameCount), TWO_PI+y*noise(frameCount) );
        }
        break;
        
        case 3:
        {
            point( x * cos(x)*frameCount, y*sin(y)*frameCount );
            point( y * cos(x)*frameCount, x*sin(y)*frameCount );
            
            ellipse( x * cos(x)*frameCount, y*sin(y)*frameCount, frameCount, frameCount );
            ellipse( y * cos(x)*frameCount, x*sin(y)*frameCount, frameCount, frameCount );
        }
        break;
        
    }
}





///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{

  //  artDaily("The difference between who you are and who you want to be is WHAT YOU DO");
  artDaily("ERICFICKES.COM");

  ec2Stamp(cX, cY);

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  }

  noLoop();
  exit();
}


///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont(createFont("Silom",11));
  smooth();
  
  fix.ranPalFill( p3 );
  text( " "+dailyMsg, width-222, this.height-10);
  
  fix.ranPalFill( p3 );
  text( " "+dailyMsg, width-222, this.height-9);
  
  fill(#EFEFEF);
  text( " "+dailyMsg, width-222, this.height-8);
}

///////////////////////////////////////////////////////////
//
//  e][c stamp
void ec2Stamp( int x, int y ){

//  OCRAStd
//  test stamp
//AmericanTypewriter-Bold
//  RosewoodStd-Regular
// AmericanTypewriter  Monaco  AmericanTypewriter-Bold "Silom"
  smooth();
  
  textFont( createFont( "MesquiteStd", 222 ) );
  fill(0);
  text( "e", x-4, y );//  text( "e", cX-4, cY );
  
  textFont( createFont( "MesquiteStd", 217 ) );
  fill(#EFEFEF);
  text( "e", x-4, y-2 );//  text( "e", cX-4, cY-2 );

  fill(0);
  textFont( createFont( "MesquiteStd", 345 ) );
  text( "]", x+32, y+46 );//text( "]", cX+32, cY+46 );
  text( "[", x+80, y+46 );//text( "[", cX+80, cY+46 );
  
  fill(#EFEFEF);
  textFont( createFont( "MesquiteStd", 340 ) );
  text( "]", x+32, y+44 );//text( "]", cX+32, cY+44 );
  text( "[", x+80, y+44 );//text( "[", cX+80, cY+44 );
  
  fill(0);
  textFont( createFont( "MesquiteStd", 222 ) );
  text( "c", x+127, y );//text( "c", cX+127, cY );
  
  textFont( createFont( "MesquiteStd", 217 ) );
  fill(#EFEFEF);
  text( "c", x+127, y-2 );//text( "c", cX+127, cY-2 );
}

