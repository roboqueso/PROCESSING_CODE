public int alf = 42;

Boolean isFinal = true;
int i = 0, sz = 75, cX, cY; 


FixLib fix = new FixLib();
 
void setup() {  // this is run once.   
 
    background(#EF0000);
    size(1024,768);
    smooth();
    noFill();

    cX = width/2;
    cY = height/2;

} 
 
void draw() {
 
 
    stroke( random(255) );
    strokeWeight(1);
    ellipse(cX+ i*sin(frameCount), cY+ i*cos(frameCount)*sz, sz, sz);
    ellipse(cX+ i*sin(frameCount), cY+ i*cos(frameCount), sz, sz);
 
    stroke( random(255), 110-sz );
    strokeWeight(sz);
    point(cX-i*sin(frameCount),cY-i*cos(frameCount));
    point(cX-i*sin(frameCount),cY-i*cos(frameCount));
 
    if (i < width) {
        i++;
    } else {
        i = int( random(i) );
    }
 
    if (i > height ) {
        i = int( random(sqrt(i)) );
        sz-= TWO_PI;
    }
 

// if(mousePressed){
// 	saveFrame("TGA/output-####.tga");
// }


    if( sz < PI ){
        exit();
    }
}

///////////////////////////////////////////////////////////
//  End handler, saves png
void exit() 
{

  artDaily( "ERICFICKES.COM" );

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
void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 21, true ) );


  fill(0);
  text( " "+dailyMsg, 0, height-21 );
  
}
