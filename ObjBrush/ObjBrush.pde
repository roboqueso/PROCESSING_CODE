//  SEE:   https://ello.co/ericfickes/post/bfnhjav8pa05nes5sf5jjq
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);

PShape oBrush;
String BRUSH_OBJ = "brush.obj";
Boolean isFinal = true;
int alf = 11, varNum = 1;

int cX;
int cY;

color[] palette = { #EF0000, #00EF00, #0000EF, #CECE00, #FA7680, #EF1975, #007007, #EFEF00, #FA9187, #007007, #109109 };
//ArrayList palette = new ArrayList();//{ #EF0000, #00EF00, #0000EF, #CECE00, #FA7680, #EF1975, #007007, #EFEF00, #FA9187, #007007, #109109 };


void settings(){
  size(displayWidth, displayHeight, P3D);
  smooth(8);
  pixelDensity(displayDensity());

}

////////////////////////////////////////////////////
//
void setup() {
 
  background(-1);

  shapeMode(CENTER);

  //  setup variables
  cX = width/2;
  cY = height/2;


  
  oBrush = loadShape( BRUSH_OBJ );
  if(oBrush==null)exit();

  oBrush.disableStyle();

}





////////////////////////////////////////////////////
//
void draw()
{
  if( mousePressed ) {
    


    strokeWeight(HALF_PI);
    
    // fill(#EF2019);
    fill( palette[(int)random(palette.length)]);
    stroke(random(255));
    
    translate(mouseX, mouseY, 3 );


// TODO: record brush strokes as GROUP?  
//  export as OBJ

      shape(oBrush);

      rotateX(90);
      shape(oBrush);

      rotateY(90);
      shape(oBrush);

      rotateZ(90);
      shape(oBrush);

  }




  if( frameCount > width*height ) {
    doExit();
  }
}

void keyPressed(){


  doExit();


}


///////////////////////////////////////////////////////////
//  End handler, saves png
void doExit() 
{

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

  textFont( createFont( "Silom", 18 ) );
  smooth();

  fill(#EFEFEF);
  text( " "+dailyMsg, this.width-430, this.height-14);
}

