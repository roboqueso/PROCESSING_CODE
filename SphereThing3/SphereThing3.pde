//
//  go smaller

Boolean isFinal = true;
float alf = 13;


float shapeSize = 20000;
float minShapeSize = 500;
float finalShapeSize = 50;


int cX;
int cY;

// #524a52, #645c64, #6e656e, #988d98, #938b93, #918a91, #938793, #887f88, #978e96, #5e555d, #7a7279, #7c6f7a, #6e686d, #685d66, #867c84, #92848f, #8b8289, #756872, #3e363c, #6a6268, #8b8088, #4e434b, #867b83, #756771, #645a61, #786e75, #978a93, #8b7f87, #564d53, #665d63, #7b7077, #756a71, #6d6369, #6e676b, #4f444a, #42383d, #655b60, #61545a, #a39199, #5e5559, #94888d, #706266, #73676a, #78676b, #685559, #9f858a, #908587, #a3868b, #6e5c5f, #684f53, #765c5e, #988586, #887475, #c6aeaf, #977c7d, #937475, #fefdfd, #fbf8f8, #6e5a5a, #9e8787, #766e6e, #8a8181, #867777, #847c7c, #705857, #6a5251, #7c6867, #907c7b, #bda2a0, #ae9593, #8d7775, #79605d, #dfcfcd, #f4edec, #6f6867, #b29692, #987772, #8e7470, #8e6c65, #af958f, #8a6c65, #ceb6b0, #887c79, #5a5655, #9c7970, #9f7e74, #816b64, #544641, #755c52, #8e6e5f, #605a57, #89827d, #7f766f, #a49a91, #55504b, #685f56, #78726a, #625d55, #7b7568, #78766e, #716e5f, #416e24, #365a28, #c9d950, #4c6c30, #659443, #729741, #698338, #587e3a, #385529, #5b7f3b, #89b552, #87a347, #4c7036, #5b7436, #446735, #689048, #87a24c, #56763b, #688c46, #849948, #84ab55, #70964c, #638c49, #8a9b49, #5b733a, #5f7f42, #82a756, #759750, #7e924a, #476639, #8e9e50, #425e35, #405a33, #92b362, #b3cd6f, #4b653a, #c0d472, #819b57, #4f6d40, #65854f, #c8d878, #8ca15c, #899c59, #a5be6d, #8aa965, #768c54, #84a464, #7d9a5e, #5a7549, #718753, #5a7449, #a6ca7e, #57754b, #435637, #405336, #8ca66b, #707a4d, #526542, #95a76b, #3f4a30, #a8bb78, #89ae74, #6c8c5e, #31422d, #96b176, #6f895d, #2b3b29, #87a06c, #7d9466, #8aa673, #8baf7b, #75855d, #849d70, #555f43, #8b9e71, #46543d, #5c694d, #5a6e52, #95ae81, #879f77, #748463, #7b9271, #718468, #606450, #91a082, #5c604e, #40483b, #505647, #545c4d, #2d2831, #514f5e, #797d6b, #5e5869, #656a5b, #4e4f44, #6d6e5f, #736b7e, #879582, #545360, #53515d, #707a6c, #706d7d, #504853, #888093, #a8b19d, #443d46, #585460, #786e7e, #484852, #51525c, #716775, #7c707f, #7a7281, #979787, #504f59, #625d69, #6b6471, #939c8c, #5b6359, #645c68, #625e6a, #7b7280, #474149, #46424a, #59525c, #837f8e, #655c67, #938797, #706773, #615963, #85808e, #6b6671, #706772, #787480, #636960, #616a65, #746f7a, #a396a5, #625b64, #817e8a, #6d7067, #8c818d, #7a7781, #beb6c5, #827c86, #5d575e, #96909b, #8d848e, #676168, #86838c, #99959f, #6a656b, #d7d4de, #7c7b80, #4e4d4f
color[] palette = { 
#000000,
#B00B13,
#1975EF
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

int x = 0;
int y = 0;

int ct = 0;
float maxCt = 0;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(alf);

  noFill();
  strokeWeight(.5);
  smooth();

// DEBUG
//  drawSuns(); 
//  exit();

}


////////////////////////////////////////////////////
//

void draw()
{

  while( shapeSize >= finalShapeSize ) 
  {

    //  re-init loop vars
    x = y = ct = (int)-alf;
    maxCt = getMax( shapeSize );
    
    
    
    //  GRID LOOP  
    while( ct < maxCt ) {
    
      smooth();  

      if( shapeSize >= minShapeSize ) {

        strokeWeight( random(shapeSize*.85) );
        
        stroke( random(alf), alf );  // stroke( 0, alf );

        ellipse( x+alf, y, shapeSize, shapeSize );
       


      } else {
        strokeWeight( random(3.33) );
        randStrokeUser();

        //circle( x, y, shapeSize, shapeSize );
        hexagon( x, y, shapeSize );
        
        randStrokeUser();
        rect( x, y, shapeSize, shapeSize );
        ellipse( x, y, shapeSize, shapeSize );
        
      }

      if( x >= width ) {
        x = (int)-alf;
        y += shapeSize; 
      } else {
        x += shapeSize;
      }
      
      ct++;

    }

    // shrink the shape
    shapeSize = shapeSize * .9 ;

  }


drawSuns();

//stroke( #EF1975, alf );
//drawFrame();

  exit();
}
///////////////////////////////
//  draw a center line core
//  draw the wirey outer shine
void drawSuns() {
 
float radius1, radius2, radius3, radius4;
float xx1, yy1, xx2, yy2, xx3, yy3, xx4, yy4;
float angle1, angle2, angle3, angle4;
float startX1, startY1, startX2, startY2, startX3, startY3, startX4, startY4;

// init 
radius1 = 75;
radius2 = 130;  //200;

radius3 = 175;
radius4 = 300;

startX1 = startX2 = startX3 = startX4 = (width/2);
startY1 = startY2 = startY3 = startY4 = (height/2);
angle1 = angle2 = 0;

angle3 = 103;
angle4 = 110;

// draw circles
  while ( angle1 < 2160 ) {
    
    smooth();
    
    if( angle1 % 360 == 0 ) {
      angle1  += 12;
      radius1 -= 12;
    }
    
    xx1 = startX1 - int( cos(radians(angle1)) * radius1 );
    yy1 = startY1 - int( sin(radians(angle1)) * radius1 );

    xx2 = startX2 - int( cos(radians(angle2)) * radius2 );
    yy2 = startY2 - int( sin(radians(angle2)) * radius2 );

    xx3 = startX3 - int( cos(radians(angle3)) * radius3 );
    yy3 = startY3 - int( sin(radians(angle3)) * radius3 );

    xx4 = startX4 - int( cos(radians(angle4)) * radius4 );
    yy4 = startY4 - int( sin(radians(angle4)) * radius4 );


    // inner
    

    stroke( #EFEFEF, alf);  // 19EF75  EFAA36
    strokeWeight( random(1.5) );
    line( xx1, yy1, xx2, lerp(yy1, yy2, random(.88) ) );

    if( xx1 % 2 == 0 ) {
//      strokeCap(SQUARE);
//      stroke( #1975ef, (alf*4));  // random(111)
    } else {
//      strokeCap(PROJECT);
//      stroke( #EFEF36, (alf*2));  // random(111)
    }
    
    strokeWeight( random(1.99) );
    line( xx1, yy1, xx2, yy2);
    
    stroke( #B00B13, pow(alf,3) );  // EF1936  random(111)
    strokeWeight( random(4.2) );
    point( xx1, yy1 );


    // outer
    stroke( #ACE511, alf*3);  //  #EFEFEF  #ACE511
//  #ACE511
    strokeWeight( random(1.9) );
    line( xx3, yy3, xx4, yy4 );

    angle1 += 3;
    angle2 += 3;

    angle3 += 2;//8;
    angle4 += 12;
  }
 
  
}




//////////////////////////
int f0 = 0;
int f1 = 1;
//int f2 = 1;

int nextFib( int f2)
{
   int result = f2;
   f0 = f1;
   f1 = f2;
   f2 = f0 + f1;
   return result;
}

//////////////////////////
//  Calculate max loop count
float getMax( float shapeSize ) {
  return ( ( width * height ) / shapeSize );
}

void textLines() {


  textFont( createFont( "Helvetica", 300 ) );

  fill(10, pow(alf, 1.5) );//, (alf*4) );
  // MAKE TEXT BIG
  fill(#210000, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.3 );
  fill(#000021, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.3 );
  //  & curve
  fill(#210000, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.49 );
  fill(#000021, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.49 );
  //  & quad
  fill(#210000, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.65 );
  fill(#000021, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.65 );

  //  & triangle
  fill(#210000, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.85 );
  fill(#000021, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.85 );
}



/*
void mousePressed() {
  println("mousePressed()");
}


void keyPressed() {
  println("keyPressed()");
}
*/


///////
//  draw frame
void drawFrame() {

  rectMode(CORNER);

  strokeWeight( 100 );
  rect( 0, 0, width, height);

  strokeWeight( 5 );
  rect( 64, 65, width-128, height-129 );

  strokeWeight( 15 );
  rect( 84, 85, width-168, height-168 );

  //  dashed line
  strokeWeight(6);
  int x = 110;
  int y = 110;

  strokeCap(PROJECT);

  for ( int pp = 0; pp <= (width*height); pp++ ) { 

    if ( x <= (width-110) ) {
      // top row    
      point( x, y );
      //  bottom row
      point( x, 790 );

      x += 10;
    } 
    else if ( y <= 780 ) {

      // left row    
      point( (width-110), y );
      //  right row
      point( 110, y );
      y += 10;
    }
  }

  strokeWeight( 5 );
  rect( 122, 122, width-245, height-245 );
}

//////////////////////////////////////////////////////////////////////////
//  Draw manual circle
//  ellipse(x, y, width, height)

float radius2 = 18, xx, yy;

void circle( float startX, float startY, float w, float h ) {

  float angle = 0;
  radius2 = w;

  while ( angle < 360 ) {

// make circle draw faster by skipping angles
if( angle % 3 == 0 ) {
    
    xx = startX - int( cos(radians(angle)) * radius2 );
    yy = startY - int( sin(radians(angle)) * radius2 );


    ellipse( xx, yy, w, h );
}
    angle++;
  }
}

//////////////////////////////////////////////////////////////////////////
//  HEXAGON inspired by http://www.rdwarf.com/lerickson/hex/index.html
void hexagon( float startX, float startY, float shapeSize ) {

  line( startX, startY+(shapeSize*.5), startX+(shapeSize*.25), startY );
  line( startX+(shapeSize*.25), startY, startX+(shapeSize*.75), startY );
  line( startX+(shapeSize*.75), startY, startX+(shapeSize), startY+(shapeSize*.5) );

  line( startX+(shapeSize), startY+(shapeSize*.5), startX+(shapeSize*.75), startY+shapeSize );
  line( startX+(shapeSize*.75), startY+shapeSize, startX+(shapeSize*.25), startY+shapeSize );
  line( startX+(shapeSize*.25), startY+shapeSize, startX, startY+(shapeSize*.5) );
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
save( split( this.toString(), "[")[0] + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
  }
  
  noLoop();
  System.gc();
  super.stop();
}

///////////////////////////////////////////////////////////
//  Helper to random(255) stroke
void randFill() {  
  fill( random(255), random(255), random(255), alf );
}
void randStroke() {  
  stroke( random(255), random(255), random(255), alf );
}
void randStroke100() {  
  stroke( random(255), random(255), random(255), 100 );
}

////////////////////////////////////////////////////
//  Randomly stroke using image from color list
void randStrokeUser()
{
  // pallete
  stroke( palette[ int(random( palette.length-1 )) ], alf*.75 );
}
void randFillUser()
{
  fill( palette[ int(random( palette.length-1 )) ], alf*.75 );
}





/////////////
//  TODO: Is there a better way to get the current sketch name?
String pdeName(){
    return split( this.toString(), "[")[0];
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

