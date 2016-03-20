int ct = 0;
Boolean isFinal = true;
float alf = 100;

//  offset tile settings
PVector tileStart = new PVector( 2, 2 );
float offsetX = 0;
float offsetY = 0;
float padX = 0;
float padY = 0;

//  art frame settings
int outerRectX;
int outerRectY;
int outerRectWidth = 200;
int outerRectHeight = 30;


void setup() {
  size( 1024, 768 );
  stroke(#000000);
  background(37);
  
  outerRectX = this.width-139;
  outerRectY = this.height-84;
  
  // calculate offset
  offsetX = (tileStart.x / 162) * 162; //  vertex(162.0,  147.0);
  offsetY = (tileStart.y / 147) * 147; //  vertex(162.0,  147.0);
}

void draw() {
  
  /*
  vertex(714.0,122.0);
  vertex(618.0,180.0);
  vertex(717.0,203.0);
  vertex(629.0,262.0);
  vertex(731.0,297.0);
  vertex(763.0,118.0);
  vertex(820.0,121.0);
  vertex(758.0,159.0);
  vertex(806.0,203.0);
  vertex(749.0,200.0);
  */
  
  while( ct <= this.width )  
  {
    smooth();
    noFill();

    randStroke();
    
    beginShape();

    padX = offsetX * ct;
    padY = offsetY * ct;

    vertex(162.0 -padX, 147.0 -padY);
    vertex(18.0 -padX,   153.0 -padY);
    vertex(163.0 -padX,  183.0 -padY);
    vertex(26.0 -padX,   217.0 -padY);
    vertex(163.0 -padX,  228.0 -padY);
    vertex(220.0 -padX,  229.0 -padY);
    vertex(217.0 -padX,  141.0 -padY);
    vertex(260.0 -padX,  174.0 -padY);
    vertex(218.0 -padX,  152.0 -padY);
    vertex(218.0 -padX,  177.0 -padY);
    vertex(262.0 -padX,  201.0 -padY);
    vertex(219.0 -padX,  186.0 -padY);
  
    vertex(714.0 -padX,122.0);
    vertex(618.0 -padX,180.0);
    vertex(717.0 -padX,203.0);
    vertex(629.0 -padX,262.0);
    vertex(731.0 -padX,297.0);
    vertex(763.0 -padX,118.0);
    vertex(820.0 -padX,121.0);
    vertex(758.0 -padX,159.0);
    vertex(806.0 -padX,203.0);
    vertex(749.0 -padX,200.0);

vertex(143.0 -padX,26.0-padY);
vertex(33.0 -padX,19.0-padY);
vertex(31.0 -padX,160.0-padY);
vertex(150.0 -padX,145.0-padY);
vertex(148.0 -padX,123.0-padY);
vertex(62.0 -padX,137.0-padY);
vertex(60.0 -padX,85.0-padY);
vertex(115.0 -padX,85.0-padY);
vertex(115.0 -padX,57.0-padY);
vertex(58.0 -padX,56.0-padY);
vertex(55.0 -padX,39.0-padY);
vertex(139.0 -padX,44.0-padY);
vertex(141.0 -padX,28.0-padY);
vertex(140.0 -padX,43.0-padY);
vertex(163.0 -padX,43.0-padY);
vertex(178.0 -padX,182.0-padY);
vertex(123.0 -padX,195.0-padY);
vertex(117.0 -padX,149.0-padY);
  
    endShape(CLOSE);


    ct++;
  }
  //text("...this was drawn with ClickDotHitEnter", this.width-500, this.height-200);


exit();

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
void randFill()    {  fill( random(255), random(255), random(255), random(alf) );  }
void randStroke()  {  stroke( random(255), random(255), random(255), random(alf) );  }

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {
  
    //  FRAME THE MESSAGE
  noFill();
  stroke(255);
  strokeWeight(2);
  
  randStroke();
  rect( this.width-220, this.height-120, outerRectWidth, outerRectHeight );
  
  randStroke();
  rect( this.width-217, this.height-117, outerRectWidth-6, outerRectHeight-6 );

  randStroke();
  rect( this.width-214, this.height-114, outerRectWidth-12, outerRectHeight-12 );

    fill(#EFEFEF);
    text( dailyMsg, this.width-211, this.height-100 );
}
