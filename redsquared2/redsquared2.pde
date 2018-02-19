// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);

float cX, cY;
float x, y;
float a,b;
float amp = 13;
Boolean isFinal = true;

//////////////////////////////////////////////////////////////////////////////
void setup() {  // this is run once.   
    
    background(#EFEFEF);
    size( 1024, 768); 
 
    smooth();
    noFill();
 
    cX = width/2;
    cY = height/2;
 
    smooth();
    strokeWeight(2);
    
    
} 
 
 
//////////////////////////////////////////////////////////////////////////////
void draw() {
 
 
 
    a = cX + random(amp) * (180/PI);
    b = cY + random(amp) * (180/PI);
 
    for( float t = 0; t <= 360; t ++ ) {

        x = cX - amp * sin(a * t * TWO_PI/180);
        y = cY - amp * sin(b * t * TWO_PI/180);

        stroke( random(255), 11, 11, amp/2 );
       
        point( x, y - 180 );
        point( x+360, y - 180 );
        point( x-360, y - 180 );
       
        stroke( 11,11,random(255), amp/2 );

        point( x, y + 180 );
        point( x+360, y + 180 );
        point( x-360, y + 180 );

    }
 
    if( frameCount % 30 == 0 )
    {
        amp *= 1.3;
    }
 
    if( frameCount > height/2.5 ) {
        textFont(createFont("Helvetica",11));
        fill(#676800);
        text("ERICFICKES.COM", 3, height-5);
 
       if(isFinal){
       
        save( fix.pdeName() + fix.getTimestamp() +".png" );
       
       }
 
        noLoop();
        exit();
    }
 
}