//import processing.opengl.*;

Boolean isFinal = true;
int ct = 0;
float alf = 37.37;
float randCirc = 10;

float registerX = 0;
float registerY = 0;

//  art frame settings
int outerRectX;
int outerRectY;
int outerRectWidth = 212;
int outerRectHeight = 30;


/////////////////////////////////////////////////
void setup() {
  size( 1024, 768 );  //, OPENGL);
  background(37);
  
  fontGrid();
  
  smooth();
  noFill();


  
  registerX = ( this.width/2 ) - 100;
  registerY = ( this.height/2 ) + 100;  
}


/////////////////////////////////////////////////
void draw(){

  if (frameCount % 9 == 0) {

    strokeWeight( random(1) );

    pushMatrix();    
    translate( registerX, registerY );
    noTint();
    scale( random(frameCount * 2  % 90) );
    rotate(radians(frameCount * 2  % 360));
    alf = int(random(69));

    //  color adjuster
    if( ct <= 999 )
    {
      randCirc = random(37);
      
      stroke( 255, random(69), random(69), 75 );
    }
    else if( ct <= 1234 )
    {
      stroke( random(255), 255, random(69), alf/2 );
      strokeWeight( random( 0.75 ) );

      randCirc = random(45);
    }
    else
    {
      stroke( random(255), random(255), 255, alf );
      randCirc = random(360);
    }

    ellipse( randCirc,randCirc,randCirc,randCirc );
    
    stroke( random(69), random(69), 255, alf );
    rect( 20, 20, 80, 80 );
    
    popMatrix();
  }
  
  ct++;
  
  if( ct == 2012 )
  {
    exit();
  }
  
}


///////////////////////////////////////////////////////////
//  
//  Spits the installed list of fonts out in a grid
void fontGrid() 
{
  fill(255);
  stroke(255);
  String[] fontList = PFont.list();
  int x = 40;
  int y = 100;
  PFont font;

  for( ct = 0; ct <= fontList.length-1; ct++ ){   
  
    fill( random(255), 37);
  
    // load it & show it
    font = createFont( fontList[ct], 10);
    textFont( font );
    text(fontList[ct], x, y);

    if( ct % 55 == 0)
    {
      x += 169;
      y = 0;
    }
    else
    {
      y += 15;
    }
    
  }

}


///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void exit() 
{
  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
    save( split( this.toString(), "[")[0] + "-" + month()+day()+year()+hour()+minute()+second()+millis() + ".png" );
  }

  super.stop();
}

///////////////////////////////////////////////////////////
//  Helper to random(255) stroke
void randFill()    {  fill( random(255), random(255), random(255), random(100) );  }
void randStroke()  {  stroke( random(255), random(255), random(255), random(100) );  }

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  rotate(0);
  noFill();
  strokeWeight(2);
//  stroke(255, 100);

randStroke();
  rect( this.width-220, this.height-120, outerRectWidth, outerRectHeight );
  
randStroke();
  rect( this.width-217, this.height-117, outerRectWidth-6, outerRectHeight-6 );

randStroke();
//  fill(0,0,0, 100);
  rect( this.width-214, this.height-114, outerRectWidth-12, outerRectHeight-12 );

  fill(255, 100);
  
  PFont font = createFont("Silom", 10); // createFont( installedFontName )
  textFont(font);
  text( " "+dailyMsg, this.width-211, this.height-100, 100 );
}
