//  SEE:   https://ello.co/ericfickes/post/5zuleb2ggfyh-yf5qutr_q
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);


//
//  go smaller

Boolean isFinal = true;
int alf = 46;


int shapeSize = 10000;
float minShapeSize = 15;
//float maxShapeSize = 100;

int cX;
int cY;


color[] palette = { 
#A59DA1,#D96D55,#F36613,#A9ABEA,#D23301,#F6FAFD,#AB6E9C,#D6F9FF,#F8751E,#768A00,#F05510,#FFEE51,#FFB02A,#D7D5FA
};

int x = 0;
int y = 0;

int ct = 0;
float maxCt = 0;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(displayWidth, displayHeight);
  frameRate(303);
  background(3);
  fix.alpha(alf);
  cX = width / 2;
  cY = height / 2;

  noFill();
  smooth();


}


////////////////////////////////////////////////////
//

void draw()
{
  //  get small

  while( shapeSize >= minShapeSize ) 
  {
    //  re-init loop vars
    x = y = ct = (int)-alf;

    maxCt = fix.getMax( shapeSize );
          
    while( ct < maxCt ) {

      strokeWeight( random( alf ) );

      smooth();

      fix.ranPalStroke(palette);
      ellipse( x, y, shapeSize, shapeSize );
      
      fix.ranPalStroke(palette);
      ellipse( y, x, shapeSize, shapeSize );

/*
strokeWeight(.25);
stroke( random(21) );
line( x,y, y, x );
*/
      if( x >= width ) {
        x = (int)-alf;
        y += shapeSize; 
      } else {
        x += shapeSize;
      }
      
      ct++;
    }
    

    // shrink the shape
    shapeSize = int(shapeSize*.75);
  }

//  fix.drawFrame();
/*
  ct = 4;
  
  while( ct < width*2 ) {
    randStroke();
    
    circle( cX, cY, ct, ct );

    ct += nextFib(ct);

    alf++;
  }
  */
  doExit();
}




/*
void mousePressed() {
  println("mousePressed()");
}


void keyPressed() {
  println("keyPressed()");
}
*/




///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{

  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + fix.getTimestamp() + ".png" );
  }
  
  noLoop();
  exit();
}



///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 18 ) );
  smooth();

  //  stroke(#EFEFEF);
//  fill(#EE0000);
  //fill(#00EE00);
  fill(#EFEFEF);
  text( " "+dailyMsg, this.width*.45, this.height-18);
}
