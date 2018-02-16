// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);
/*
BOARD CONCEPT

- 8bit heart in the center

- heart sphere pattern behind

- Sun behind ( around the sphere heart )

- Grid?


*/
Boolean isFinal = true;
int alf = 42; //36;
float cX, cY;

// #524a52, #645c64, #6e656e, #988d98, #938b93, #918a91, #938793, #887f88, #978e96, #5e555d, #7a7279, #7c6f7a, #6e686d, #685d66, #867c84, #92848f, #8b8289, #756872, #3e363c, #6a6268, #8b8088, #4e434b, #867b83, #756771, #645a61, #786e75, #978a93, #8b7f87, #564d53, #665d63, #7b7077, #756a71, #6d6369, #6e676b, #4f444a, #42383d, #655b60, #61545a, #a39199, #5e5559, #94888d, #706266, #73676a, #78676b, #685559, #9f858a, #908587, #a3868b, #6e5c5f, #684f53, #765c5e, #988586, #887475, #c6aeaf, #977c7d, #937475, #fefdfd, #fbf8f8, #6e5a5a, #9e8787, #766e6e, #8a8181, #867777, #847c7c, #705857, #6a5251, #7c6867, #907c7b, #bda2a0, #ae9593, #8d7775, #79605d, #dfcfcd, #f4edec, #6f6867, #b29692, #987772, #8e7470, #8e6c65, #af958f, #8a6c65, #ceb6b0, #887c79, #5a5655, #9c7970, #9f7e74, #816b64, #544641, #755c52, #8e6e5f, #605a57, #89827d, #7f766f, #a49a91, #55504b, #685f56, #78726a, #625d55, #7b7568, #78766e, #716e5f, #416e24, #365a28, #c9d950, #4c6c30, #659443, #729741, #698338, #587e3a, #385529, #5b7f3b, #89b552, #87a347, #4c7036, #5b7436, #446735, #689048, #87a24c, #56763b, #688c46, #849948, #84ab55, #70964c, #638c49, #8a9b49, #5b733a, #5f7f42, #82a756, #759750, #7e924a, #476639, #8e9e50, #425e35, #405a33, #92b362, #b3cd6f, #4b653a, #c0d472, #819b57, #4f6d40, #65854f, #c8d878, #8ca15c, #899c59, #a5be6d, #8aa965, #768c54, #84a464, #7d9a5e, #5a7549, #718753, #5a7449, #a6ca7e, #57754b, #435637, #405336, #8ca66b, #707a4d, #526542, #95a76b, #3f4a30, #a8bb78, #89ae74, #6c8c5e, #31422d, #96b176, #6f895d, #2b3b29, #87a06c, #7d9466, #8aa673, #8baf7b, #75855d, #849d70, #555f43, #8b9e71, #46543d, #5c694d, #5a6e52, #95ae81, #879f77, #748463, #7b9271, #718468, #606450, #91a082, #5c604e, #40483b, #505647, #545c4d, #2d2831, #514f5e, #797d6b, #5e5869, #656a5b, #4e4f44, #6d6e5f, #736b7e, #879582, #545360, #53515d, #707a6c, #706d7d, #504853, #888093, #a8b19d, #443d46, #585460, #786e7e, #484852, #51525c, #716775, #7c707f, #7a7281, #979787, #504f59, #625d69, #6b6471, #939c8c, #5b6359, #645c68, #625e6a, #7b7280, #474149, #46424a, #59525c, #837f8e, #655c67, #938797, #706773, #615963, #85808e, #6b6671, #706772, #787480, #636960, #616a65, #746f7a, #a396a5, #625b64, #817e8a, #6d7067, #8c818d, #7a7781, #beb6c5, #827c86, #5d575e, #96909b, #8d848e, #676168, #86838c, #99959f, #6a656b, #d7d4de, #7c7b80, #4e4d4f
color[] palette = { 
  #EF0000,
  #EFEFEF,
  #000000
};

color[] boobColors = {
  #0B00B5, 
  #B000B5, 
  #2B00B5, 
  #B00B1E, 
  #B00B33, 
  #080085, 
  #800085, 
  #280085, 
  #80081E, 
  #800833
};


//  image action
PImage img = new PImage();
PImage img2 = new PImage();


// see: http://docs.oracle.com/javase/1.4.2/docs/api/java/util/ArrayList.html
ArrayList _colors = new ArrayList();
ArrayList _colors2 = new ArrayList();


////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(255);
  fix.alpha(alf);
  cX = width * .5;
  cY = height * .5;



//  pull out DISTINCT colors for sketch
  img = loadImage( "apacheflex_fc.jpg");
  _colors = fix.getImgColors(img);    //  http://processing.org/reference/loadPixels_.html
  
  //  IMAGE TWO
  img2 = loadImage( "adobeFX4.jpg");
  _colors2 = fix.getImgColors(img2);    //  http://processing.org/reference/loadPixels_.html

}


////////////////////////////////////////////////////
//
void draw()
{

  drawSuns( cX+15, cY);

  fix.bitHeart( cX-220, cY-180, true );
  
/*  line( cX, 0, cX, height );
  line( cX+30, 0, cX+30, height );
  line( 0, cY, width, cY );*/

  doExit();
}

/////////////////////////////////////////////////////////////////
//  spit out an 8bit heart
void bitHeart( float x, float y, boolean grid ) {

  int blockSize = 36;
  float htSize = 360;
  strokeWeight(.5);
/*
  //  GRID
  if(grid) {
    stroke(#EFEFEF, 50);
  
    for( int xx = 0 ; xx <= 13; xx++ ) {
      
      line( x+(blockSize*xx), 0, x+(blockSize*xx), height );
      line( 0, y+(blockSize*xx), width, y+(blockSize*xx) );
      
    }
  }
//  GRID
*/
  

//  HEART
  stroke(#363636);

  //  white blocks
//  fill(255);
  imgColorFillFull( _colors );
  rect( x+(blockSize*2), y+blockSize, blockSize, blockSize );

  imgColorFillFull( _colors );
  rect( x+(blockSize), y+(blockSize*2), blockSize, blockSize );
  
  fill(0);
  rect( x+(blockSize*2), y, blockSize, blockSize );
  rect( x+(blockSize*3), y, blockSize, blockSize );
  rect( x+(blockSize*4), y, blockSize, blockSize );
  rect( x+(blockSize*8), y, blockSize, blockSize );
  rect( x+(blockSize*9), y, blockSize, blockSize );
  rect( x+(blockSize*10), y, blockSize, blockSize );
  rect( x+(blockSize), y+blockSize, blockSize, blockSize );

//  fill(#EF0000);
  imgColorFillFull( _colors );
  rect( x+(blockSize*3), y+blockSize, blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*4), y+blockSize, blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*2), y+(blockSize*2), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*3), y+(blockSize*2), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*4), y+(blockSize*2), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*5), y+(blockSize*2), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*7), y+(blockSize*2), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*8), y+(blockSize*2), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*9), y+(blockSize*2), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*10), y+(blockSize*2), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*11), y+(blockSize*2), blockSize, blockSize );

  imgColorFillFull( _colors );
  rect( x+(blockSize), y+(blockSize*3), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*2), y+(blockSize*3), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*3), y+(blockSize*3), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*4), y+(blockSize*3), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*5), y+(blockSize*3), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*6), y+(blockSize*3), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*7), y+(blockSize*3), blockSize, blockSize );

  imgColorFillFull( _colors );
  rect( x+(blockSize*8), y+(blockSize*3), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*9), y+(blockSize*3), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*10), y+(blockSize*3), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*11), y+(blockSize*3), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize), y+(blockSize*4), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*2), y+(blockSize*4), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*3), y+(blockSize*4), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*4), y+(blockSize*4), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*5), y+(blockSize*4), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*6), y+(blockSize*4), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*7), y+(blockSize*4), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*8), y+(blockSize*4), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*9), y+(blockSize*4), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*10), y+(blockSize*4), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*11), y+(blockSize*4), blockSize, blockSize );

  imgColorFillFull( _colors );
  rect( x+(blockSize*2), y+(blockSize*5), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*3), y+(blockSize*5), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*4), y+(blockSize*5), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*5), y+(blockSize*5), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*6), y+(blockSize*5), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*7), y+(blockSize*5), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*8), y+(blockSize*5), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*9), y+(blockSize*5), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*10), y+(blockSize*5), blockSize, blockSize );

  imgColorFillFull( _colors );
  rect( x+(blockSize*2), y+(blockSize*6), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*3), y+(blockSize*6), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*4), y+(blockSize*6), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*5), y+(blockSize*6), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*6), y+(blockSize*6), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*7), y+(blockSize*6), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*8), y+(blockSize*6), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*9), y+(blockSize*6), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*10), y+(blockSize*6), blockSize, blockSize );

  imgColorFillFull( _colors );
  rect( x+(blockSize*3), y+(blockSize*7), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*4), y+(blockSize*7), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*5), y+(blockSize*7), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*6), y+(blockSize*7), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*7), y+(blockSize*7), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*8), y+(blockSize*7), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*9), y+(blockSize*7), blockSize, blockSize );

  imgColorFillFull( _colors );
  rect( x+(blockSize*4), y+(blockSize*8), blockSize, blockSize );

  imgColorFillFull( _colors );
  rect( x+(blockSize*5), y+(blockSize*8), blockSize, blockSize );

  imgColorFillFull( _colors );
  rect( x+(blockSize*6), y+(blockSize*8), blockSize, blockSize );

  imgColorFillFull( _colors );
  rect( x+(blockSize*7), y+(blockSize*8), blockSize, blockSize );

  imgColorFillFull( _colors );
  rect( x+(blockSize*8), y+(blockSize*8), blockSize, blockSize );

  imgColorFillFull( _colors );
  rect( x+(blockSize*5), y+(blockSize*9), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*6), y+(blockSize*9), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*7), y+(blockSize*9), blockSize, blockSize );

  imgColorFillFull( _colors );
  rect( x+(blockSize*6), y+(blockSize*10), blockSize, blockSize );

  fill(0);
  rect( x+(blockSize*5), y+blockSize, blockSize, blockSize );
  rect( x+(blockSize*6), y+(blockSize*2), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize), blockSize, blockSize );


//  fill(#EF0000);  
  imgColorFillFull( _colors );
  rect( x+(blockSize*4), y+blockSize, blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*8), y+blockSize, blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*9), y+blockSize, blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*10), y+blockSize, blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+blockSize, y+(blockSize*5), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*2), y+(blockSize*7), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*3), y+(blockSize*8), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*4), y+(blockSize*9), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*5), y+(blockSize*10), blockSize, blockSize );  
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*6), y+(blockSize*11), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*7), y+(blockSize*10), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*8), y+(blockSize*9), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*9), y+(blockSize*8), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*10), y+(blockSize*7), blockSize, blockSize );
  
  imgColorFillFull( _colors );
  rect( x+(blockSize*11), y+(blockSize*5), blockSize, blockSize );

  fill(0);
  rect( x+(blockSize*11), y+blockSize, blockSize, blockSize );
  rect( x, y+(blockSize*2), blockSize, blockSize );
  rect( x, y+(blockSize*3), blockSize, blockSize );
  rect( x, y+(blockSize*4), blockSize, blockSize );
  rect( x, y+(blockSize*5), blockSize, blockSize );
  rect( x+blockSize, y+(blockSize*6), blockSize, blockSize );
  rect( x+blockSize, y+(blockSize*7), blockSize, blockSize );
  rect( x+(blockSize*2), y+(blockSize*8), blockSize, blockSize );
  rect( x+(blockSize*3), y+(blockSize*9), blockSize, blockSize );
  rect( x+(blockSize*4), y+(blockSize*10), blockSize, blockSize );
  rect( x+(blockSize*5), y+(blockSize*11), blockSize, blockSize );
  rect( x+(blockSize*6), y+(blockSize*12), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize*11), blockSize, blockSize );
  rect( x+(blockSize*8), y+(blockSize*10), blockSize, blockSize );
  rect( x+(blockSize*9), y+(blockSize*9), blockSize, blockSize );
  rect( x+(blockSize*10), y+(blockSize*8), blockSize, blockSize );
  rect( x+(blockSize*11), y+(blockSize*7), blockSize, blockSize );
  rect( x+(blockSize*11), y+(blockSize*6), blockSize, blockSize );

  rect( x+(blockSize*12), y+(blockSize*5), blockSize, blockSize );
  rect( x+(blockSize*12), y+(blockSize*4), blockSize, blockSize );
  rect( x+(blockSize*12), y+(blockSize*3), blockSize, blockSize );
  rect( x+(blockSize*12), y+(blockSize*2), blockSize, blockSize );
}


//  TODO: convert these image color functions to follow the ranPalStroke() 
//  methodology

//  stroke a random color out of loaded image
//  HONORS alf
void imgColorStroke( ArrayList cArray ) {
  float pixCt = cArray.size();
  int randColor = int( random( pixCt ) );
  color tmpColor = (color)(Integer) cArray.get(randColor);
  stroke( red( tmpColor ), green( tmpColor ), blue( tmpColor ), alf );
}
//  stroke a random color out of loaded image
//  IGNORES alf
void imgColorStrokeFull( ArrayList cArray ) {
  float pixCt = cArray.size();
  int randColor = int( random( pixCt ) );
  color tmpColor = (color)(Integer) cArray.get(randColor);
  stroke( red( tmpColor ), green( tmpColor ), blue( tmpColor ), alf );
}



//  HONORS alf
void imgColorFill( ArrayList cArray ) {
  float pixCt = cArray.size();
  int randColor = int( random( pixCt ) );
  color tmpColor = (color)(Integer) cArray.get(randColor);
  fill( red( tmpColor ), green( tmpColor ), blue( tmpColor ), alf );
}
//  stroke a random color out of loaded image
//  IGNORES alf
void imgColorFillFull( ArrayList cArray ) {
  float pixCt = cArray.size();
  int randColor = int( random( pixCt ) );
  color tmpColor = (color)(Integer) cArray.get(randColor);
  fill( red( tmpColor ), green( tmpColor ), blue( tmpColor ) );
}
//  TODO: convert these image color functions to follow the ranPalStroke() 
//  methodology



///////////////////////////////
//  draw a center line core
//  draw the wirey outer shine
void drawSuns( float x, float y ) {
 
float radius1, radius2, radius3, radius4, radius5;
float xx1, yy1, xx2, yy2, xx3, yy3, xx4, yy4, xx5, yy5;
float angle1, angle2, angle3, angle4, angle5;
float startX1, startY1, startX2, startY2, startX3, startY3, startX4, startY4, startX5, startY5;
float maxCt = 360 * 4;

  // init 
  radius1 = 10;
  radius2 = 200;
  
  radius3 = 350;
  radius4 = 400;
  radius5 = 1000;
  
  startX1 = startX2 = startX3 = startX4 = startX5 = x;
  startY1 = startY2 = startY3 = startY4 = startY5 = y;

  angle1 = angle5 = 0;  //50;
  angle2 = 15;  //100;
  angle3 = 45;  //150;
  angle4 = 90;  //200;
  

// draw circles
  while ( angle1 < maxCt ) {
    
    smooth();
    
    xx1 = startX1 - int( cos(radians(angle1)) * radius1 );
    yy1 = startY1 - int( sin(radians(angle1)) * radius1 );

    xx2 = startX2 - int( cos(radians(angle2)) * radius2 );
    yy2 = startY2 - int( sin(radians(angle2)) * radius2 );

    xx3 = startX3 - int( cos(radians(angle3)) * radius3 );
    yy3 = startY3 - int( sin(radians(angle3)) * radius3 );

    xx4 = startX4 - int( cos(radians(angle4)) * radius4 );
    yy4 = startY4 - int( sin(radians(angle4)) * radius4 );
    
    xx5 = startX1 - int( cos(radians(angle5)) * radius5 );
    yy5 = startY1 - int( sin(radians(angle5)) * radius5 );


  strokeWeight( .36 );

  imgColorStroke( _colors2 );  //  stroke(#363636, alf );
  line( xx1, yy3, xx5, yy5 );
  
  imgColorStroke( _colors2 );  //  stroke(#363636, alf );
  line( xx3, yy1, xx5, yy5 );

  imgColorStroke( _colors2 );  //  stroke(#363636, alf );
  line( xx5, yy4, xx3, yy2 );  

    angle1 += 4;
    angle5 += 4;

    angle2 += 4;

    angle3 += 6;
    angle4 += 6;
    

  }
 
  
}



///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
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

//  fill(#676800);
//  text( " "+dailyMsg, this.width-430, this.height-14);
  PImage pimg = new PImage();
  pimg = loadImage( "apacheflex_fc.jpg");
int iHeight  = int(pimg.height*.36);
int iWidth   = int(pimg.width*.36);

  pimg.resize( iWidth, iHeight );
  image( pimg, width- pimg.width, height - pimg.height );



/*
float yy = 0;
while( yy <= height ) {

  fill(#EFEFEF, yy*.15);
 text( " "+dailyMsg, 5, yy);
 yy += 18; 
}
*/

}

