//  see: https://ello.co/ericfickes/post/ryom47uk6ejh24drhn78ja

int[] nz;
boolean gotNoise = true;
boolean vert = true;
float xx=0,yy=0;
boolean isFinal = true;
 
void setup() {
    size(displayWidth, displayHeight);
    background(255);
    frameRate(420);
    smooth(8);
    noFill();
    rectMode(CENTER);
    strokeWeight(TWO_PI);
    
    nz = new int[displayWidth];
}
 
void draw() {
 
    if(frameCount < 966 )
    {
        nz[frameCount-1] =int(random(-6,6)*noise(frameCount));
    }
 
 
    if(yy<height){
        xx += nz[int(yy)];
        yy+=TWO_PI;
    } else {
        yy=0;
        xx += ( xx<width ) ? 4 : -xx+nz[int(yy)];
        stroke(random(240));
    }
 
    //  safety
    if( xx < 0 || xx > width ){
      xx = random(xx);
    }
 
   strokeWeight(random(13));

 point( xx, yy );
 

 
 
 
    if( frameCount>(height+width)*24)
    {
        stroke(#EF1975);
        fill(#EF2012);
        textFont( createFont( "Silom", 18 ));
        text( "ERICFICKES.COM", 46, displayHeight-24 );
        rect( 111,111, 42, 41, frameCount);
        if(isFinal)
        {
          save( this+".png" );
        }
        exit();
    }
}
