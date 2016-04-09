//  
//  TFC = Team Fickes Collaboration ( Eric & Fletch )
//  EC2 sketch using scanned marker drawings
//  
public String[] imgList = { "green.png", "greenDark.png", "orange.png", "pink.png", "pinkhot.png", "purple.png", "purpleBlue.png", "purpleDark.png", "red.png", "teal.png" };
public PImage pImg = new PImage();
public float  rowHeight, colWidth;
public String msg = "Processing", img;
public Boolean isFinal = true;
public int cX, cY;

void setup(){
  size( 1024,768 );  //  scanned 5x7 cards, scaled down
  background(255);
  cX = int(width/2);
  cY = int(height/2);

  strokeWeight(1);
  stroke(0);
  for( int yy = 0; yy <= height; yy += TWO_PI){
    line( 0, yy, width, yy );
  }

}

void draw(){

  

ec2Stamp( cX-90, cY+66 );


//  strokeWeight(1);
//  stroke(255);
//  for( int yy = 0; yy <= height; yy += 11 ){
//    line( 0, yy, width, yy );
//  }


//  if( frameCount > 42 ){
  
  if(isFinal){
    save("ec2stampMask.png");
  }
  noLoop();
//  }
}



///////////////////////////////////////////////////////////
//
//  e][c stamp
void ec2Stamp( int x, int y ) {

  
  //  EC2 ROCK STAMP
  
  //  OCRAStd
  //  test stamp
  //AmericanTypewriter-Bold
  //  RosewoodStd-Regular
  // AmericanTypewriter  Monaco  AmericanTypewriter-Bold "Silom"
  smooth();

  textFont( createFont( "MesquiteStd", 200 ) );
  fill(0);
  text( "e", x-4, y   );//  text( "e", cX-4, cY );


  fill(0);
  textFont( createFont( "MesquiteStd", 300 ) );
  text( "]", x+32, y+48   );//text( "]", cX+32, cY+46 );
  text( "[", x+80, y+48   );//text( "[", cX+80, cY+46 );

  fill(0);
  textFont( createFont( "MesquiteStd", 200 ) );
  text( "c", x+127, y   );//text( "c", cX+127, cY );

}

