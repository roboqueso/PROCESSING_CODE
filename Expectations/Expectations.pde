//  SEE:   https://ello.co/ericfickes/post/oqtfsp18r3kwonwboy74gg
//  GOTO:  https://github.com/ericfickes/FIXLIB 

import fixlib.*;

Fixlib fix = Fixlib.init(this);
/*
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
*/
Boolean isFinal = true;
float a, b, x, y, sz, amp;
int angle;
////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(displayWidth, displayHeight, P3D);
  background(#2014EF);
  stroke(0);
  strokeWeight(2);
  smooth();
  
  amp = 2;
  sz = 42;
  a = b = sz;
}


////////////////////////////////////////////////////
//
void draw()
{
    amp = frameCount;

    for ( float t = 0; t <= amp%360; t += 3)  // angle WAS 360
    {
      x = a - amp * sin(a * t * PI/180);
      y = b - amp * cos(b * t * PI/180);
      
      // x = x%width;
      // y = y%height;
      
       if(amp%6==0){

        // fill(amp%3==0?0:255, amp%200);
        // stroke(amp%3==0?255:0);        

        fill(amp%255,amp%255);
        stroke(255);
        strokeWeight(PI);

         sphereDetail(
             (int) map(amp, 0, width, 3, 7),
             (int) map(t, 0, height, 3, 9)
           );

         pushMatrix();
           translate(x, y, amp);
           rotateZ(radians(amp));
           sphere(sz);
         popMatrix();

       } else {

        noFill();
        stroke(0);
        // stroke(x,y,amp);

        strokeWeight(2);
        // rect(x, y, 21, 21, -amp%42);
         pushMatrix();
           translate(x, y, t);
           rotateX(radians(amp));
           box(amp%sz);
         popMatrix();

       }

      point(x,y);
    }


    if(a<width){
      a += sz;
    } else {
      a = -sz;
      b += (sz*sz)%height;
    }

    if( b > height ){
      b = -sz;
    }


    if( frameCount > 420 ) {
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


  noLoop();
  exit();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

textFont( createFont( "Silom", 21 ) );
smooth();

  fill(255);
  text( " "+dailyMsg, 0, height-sz );
  fill(39);
  text( " "+dailyMsg, 0, height-sz );
}
