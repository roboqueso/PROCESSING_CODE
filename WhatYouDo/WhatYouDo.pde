// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;
int alf = 13;
float x,y, t;
float angle = 0;
float xx, yy, startX, startY;
float w = 13;


// image
PImage img;
ArrayList p3;

int i = 0, cX, cY, rad = 13; 
Boolean on = true;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size( 1024, 768);
  background(9);
  fix.alpha(alf);
  noFill();
  smooth();
  ellipseMode(CENTER);
  //  setup variables
  cX = floor(width*.42);
  cY = height/2;


  img = loadImage("THEDIFFERENCEBETWEENWHO.JPG");  //  

p3 = fix.getImgColors( img );
    
  // right justify stump
  image(img, (width-672), 0 );

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

    stroke(#EF1975, alf);
    bezier( xx, yy, yy, xx, xx, yy, xx, yy );
    stroke(#1975EF, alf);
    bezier( yy, xx, xx, yy, yy, xx, yy, xx );

    strokeWeight(1);  
    stroke( #370000,100 );
    curve( xx, yy, rad, frameCount, alf, frameCount, yy, xx );
    curve( yy, xx, rad, frameCount, alf, frameCount, xx, yy );

    strokeWeight(HALF_PI);  
    stroke(0, 99);
    fix.systems( yy, xx );

    fix.systems( rad, frameCount );
    fix.systems( frameCount, rad );
    
    strokeWeight( random(TWO_PI) );
    stroke(random(25,75) );
    fix.systems( xx, yy );
    
    strokeWeight(QUARTER_PI);
    stroke( #003700,100 );
    fix.systems( xx, yy ); 
    fix.systems( yy, xx );
    fix.systems( rad, frameCount );
    fix.systems( frameCount, rad );
    
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
    fix.systems( x+rad, y+rad );//, rad, rad );
    stroke( random(rad), random(rad), random(alf), alf*PI );
    fix.systems( y-rad, x-rad);//, rad, rad );


 
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



  if( yy > height ) {
    doExit();
  }

}


///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{

//  artDaily("The difference between who you are and who you want to be is WHAT YOU DO");
artDaily("ERICFICKES.COM");
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

  textFont( createFont( "Silom", 21 ) );
  smooth();
  
  fill(#20EF75);
  text( " "+dailyMsg, width-222, this.height-10);
  
  fill(0);
  text( " "+dailyMsg, width-222, this.height-9);
  
  fill(#EFEFEF);
  text( " "+dailyMsg, width-222, this.height-8);
}

