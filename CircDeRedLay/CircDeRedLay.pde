// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);


/////////////////////////////////////

Boolean isFinal = true;
int alf = 11;
float cX, cY, eX, eY, i;

void setup() {
    background(#000011);
    size(1024, 768);
  frameRate(303); 
  fix.alpha(alf);
    smooth();
    noFill();
    ellipseMode(CENTER);
    rectMode(CENTER);
    
    cX = width/2;
    cY = height/2;
} 

void draw() {  // this is run repeatedly.  


    eX = cX *cos(frameCount)*radians(cX); 
    eY = cY *sin(frameCount)*radians(cY);


    stroke(random(255), alf);
    fix.systems(eX, eY);
    stroke(random(11,42), alf);
    fix.systems(eY, eX);
    
    stroke(0,0,random(alf),alf);
    fix.systems(cX+i, cY+i);
    
    stroke(random(alf),0,0,alf);
    fix.systems(cX-i, cY-i);

    // move over a pixel
    if (i < width/2) {
        i+=1;
    } else {
        i = 0; 
    }
    

  if( frameCount > height+width )
    {
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

  textFont( createFont( "Silom", 42 ) );
  smooth();
  
  fill(#20EF75);
  text( " "+dailyMsg, width-420, this.height-10);
  
  fill(0);
  text( " "+dailyMsg, width-421, this.height-9);
  
  fill(#EFEFEF);
  text( " "+dailyMsg, width-422, this.height-8);
}

