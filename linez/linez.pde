int[] nz = new int[966];
boolean gotNoise = false;
boolean vert = true;
float xx=0,yy=0;
boolean isFinal = true;
 
void setup() {
    size(1024, 768);
    background(255);
    frameRate(303);
    smooth();
    noFill();
    rectMode(CENTER);
    strokeWeight(TWO_PI);
}
 
void draw() {
 
    if(frameCount< 966 )
    {
        nz[frameCount-1] =int(random(-6,6)*noise(frameCount));
    }
 
 
    if(yy<height){
        xx += nz[int(yy)];
        yy+=TWO_PI;
    } else {
        yy=0;
        xx += ( xx<width ) ? 4 : -xx+nz[int(yy)];
        stroke(random(222));
    }
 
    //  safety
    if( xx < 0 || xx > width ){
      xx = random(xx);
    }
 
   strokeWeight(random(13));
 
    point( xx, yy );
 

 
 
 
    if( frameCount>height+width*42)
    {
        stroke(#EF1975);
        fill(#EF2012);
        textFont( createFont( "Silom", 18 ));
        text( "ERICFICKES.COM", 115, 111 );
        rect( 111,111, 42, 41, frameCount);
        if(isFinal)
        {
          save( split( this.toString(), "[")[0] + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
        }
        noLoop();
    }
}
