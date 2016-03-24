float x, y, alf = 18;
float a, b, x2, y2;
Boolean isFinal = true;
///////////////////////////////////////////////////////////////////////////////
void setup() {  // this is run once.   
    background(alf);
    size(1024,768);
    frameRate(666);
    rectMode(CENTER);
    ellipseMode(CENTER);
} 
 
///////////////////////////////////////////////////////////////////////////////
void draw() {
    noFill();
    smooth();
    strokeWeight(3);
    stroke(random(222), random(37), random(37));
    ellipse( y, x, alf+noise(alf), alf+noise(alf) );
 
    stroke(random(37), random(111), random(37), alf/PI );
    ellipse( x, y, alf, alf );
 
    strokeWeight( random(noise(frameCount)) + alf );
    rect( x, y, alf*PI, alf*PI );
    rect( y, x, alf*1.5, alf*1.5 );
 
    if( x > (width+alf) ) {
        alf += noise(alf) + noise(frameCount);
        y += alf + cos( noise(frameCount) ) + sin( noise(TWO_PI+y) );
        x = -alf;
    } else {
        x += noise(frameCount) + random(alf) + cos( noise(frameCount) ) + sin( noise(TWO_PI+y) );
    }
 
    //    draw squiggly before stamping    
    strokeWeight(PI);
    //    init points to lower left corner
    a = b = x2 = y2 = frameCount+PI;
 
    a += a * sin(a * noise(frameCount) * TWO_PI/360);
    b += b * cos(b * noise(frameCount) * TWO_PI/360);
 
    x2 -= x2 * sin(x2 * noise(frameCount) * TWO_PI/360);
    y2 -= y2 * cos(y2 * noise(frameCount) * TWO_PI/360);
 
stroke(#c1c1c1);
ellipse( a, b, alf, alf );
 
stroke(#EFEFEF);
ellipse( x2, y2, alf, alf );
 
stroke(#1975EF);
    point( a, b );
    point( b, a );
 
stroke(random(37), random(37), random(250) );
    point( x2, y2 );
    point( y2, x2 );
 
stroke(random(37), random(250), random(37));
    point( a, y2 );
    point( b, x2 );
 
stroke(#EF1975);
    point( y2, a );
    point( x2, b );
 
    //    STOP
    if( frameCount > width*PI ) {
 
        fill(#802A2A);
        textFont( createFont( "monospace", alf ) );
        text( "ERICFICKES.COM", 0, height-15 );

  if ( isFinal )
  {
save( split( this.toString(), "[")[0] + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
  }

  super.stop();

    }
}
