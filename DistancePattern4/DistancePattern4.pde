//
//  Rotate the circles so the crown looking opening points up

Boolean isFinal = true;
int alf = 37;

/*
float shapeSize = 333;
float minShapeSize = 500;
float finalShapeSize = 50;
*/
float cX, cY;

// #524a52, #645c64, #6e656e, #988d98, #938b93, #918a91, #938793, #887f88, #978e96, #5e555d, #7a7279, #7c6f7a, #6e686d, #685d66, #867c84, #92848f, #8b8289, #756872, #3e363c, #6a6268, #8b8088, #4e434b, #867b83, #756771, #645a61, #786e75, #978a93, #8b7f87, #564d53, #665d63, #7b7077, #756a71, #6d6369, #6e676b, #4f444a, #42383d, #655b60, #61545a, #a39199, #5e5559, #94888d, #706266, #73676a, #78676b, #685559, #9f858a, #908587, #a3868b, #6e5c5f, #684f53, #765c5e, #988586, #887475, #c6aeaf, #977c7d, #937475, #fefdfd, #fbf8f8, #6e5a5a, #9e8787, #766e6e, #8a8181, #867777, #847c7c, #705857, #6a5251, #7c6867, #907c7b, #bda2a0, #ae9593, #8d7775, #79605d, #dfcfcd, #f4edec, #6f6867, #b29692, #987772, #8e7470, #8e6c65, #af958f, #8a6c65, #ceb6b0, #887c79, #5a5655, #9c7970, #9f7e74, #816b64, #544641, #755c52, #8e6e5f, #605a57, #89827d, #7f766f, #a49a91, #55504b, #685f56, #78726a, #625d55, #7b7568, #78766e, #716e5f, #416e24, #365a28, #c9d950, #4c6c30, #659443, #729741, #698338, #587e3a, #385529, #5b7f3b, #89b552, #87a347, #4c7036, #5b7436, #446735, #689048, #87a24c, #56763b, #688c46, #849948, #84ab55, #70964c, #638c49, #8a9b49, #5b733a, #5f7f42, #82a756, #759750, #7e924a, #476639, #8e9e50, #425e35, #405a33, #92b362, #b3cd6f, #4b653a, #c0d472, #819b57, #4f6d40, #65854f, #c8d878, #8ca15c, #899c59, #a5be6d, #8aa965, #768c54, #84a464, #7d9a5e, #5a7549, #718753, #5a7449, #a6ca7e, #57754b, #435637, #405336, #8ca66b, #707a4d, #526542, #95a76b, #3f4a30, #a8bb78, #89ae74, #6c8c5e, #31422d, #96b176, #6f895d, #2b3b29, #87a06c, #7d9466, #8aa673, #8baf7b, #75855d, #849d70, #555f43, #8b9e71, #46543d, #5c694d, #5a6e52, #95ae81, #879f77, #748463, #7b9271, #718468, #606450, #91a082, #5c604e, #40483b, #505647, #545c4d, #2d2831, #514f5e, #797d6b, #5e5869, #656a5b, #4e4f44, #6d6e5f, #736b7e, #879582, #545360, #53515d, #707a6c, #706d7d, #504853, #888093, #a8b19d, #443d46, #585460, #786e7e, #484852, #51525c, #716775, #7c707f, #7a7281, #979787, #504f59, #625d69, #6b6471, #939c8c, #5b6359, #645c68, #625e6a, #7b7280, #474149, #46424a, #59525c, #837f8e, #655c67, #938797, #706773, #615963, #85808e, #6b6671, #706772, #787480, #636960, #616a65, #746f7a, #a396a5, #625b64, #817e8a, #6d7067, #8c818d, #7a7781, #beb6c5, #827c86, #5d575e, #96909b, #8d848e, #676168, #86838c, #99959f, #6a656b, #d7d4de, #7c7b80, #4e4d4f
//    #0B00B5, #B000B5, #2B00B5, #B00B1E, #B00B33, #080085, #800085, #280085, #80081E, #800833

color[] palette = { 
  #EF0000, #000000, 
  #585458, #716b6e, #837f81, #7f777a, #72696a, #8b8081, #141212, #151515, #a29a99, #7b7472, #9e9491, #9c928e, #a39995, #978881, #9f9894, #8b837e, #6e6a66, #56534d, #413a2a, #37301f, #615f5a, #3c372a, #3e3a2f, #444138, #383322, #312c19, #332e1b, #302d1b, #10100f, #131312, #b9b6bd
    , #DD570D, #D4190D, #9D0D0D, #65A90A, #660D0C, #D8930C, #DFDD0E, #595C0B
};

color[] palette2 = {
  #0B00B5, #B000B5, #2B00B5, #B00B1E, #B00B13, #B00B13, #B00B33, #080085, #800085, #280085, #80081E, #800833
}; 

color[] palette3 = {
  #524a52, #645c64, #6e656e, #988d98, #938b93, #918a91, #938793, #887f88, #978e96, #5e555d, #7a7279, #7c6f7a, #6e686d, #685d66, #867c84, #92848f, #8b8289, #756872, #3e363c, #6a6268, #8b8088, #4e434b, #867b83, #756771, #645a61, #786e75, #978a93, #8b7f87, #564d53, #665d63, #7b7077, #756a71, #6d6369, #6e676b, #4f444a, #42383d, #655b60, #61545a, #a39199, #5e5559, #94888d, #706266, #73676a, #78676b, #685559, #9f858a, #908587, #a3868b, #6e5c5f, #684f53, #765c5e, #988586, #887475, #c6aeaf, #977c7d, #937475, #fefdfd, #fbf8f8, #6e5a5a, #9e8787, #766e6e, #8a8181, #867777, #847c7c, #705857, #6a5251, #7c6867, #907c7b, #bda2a0, #ae9593, #8d7775, #79605d, #dfcfcd, #f4edec, #6f6867, #b29692, #987772, #8e7470, #8e6c65, #af958f, #8a6c65, #ceb6b0, #887c79, #5a5655, #9c7970, #9f7e74, #816b64, #544641, #755c52, #8e6e5f, #605a57, #89827d, #7f766f, #a49a91, #55504b, #685f56, #78726a, #625d55, #7b7568, #78766e, #716e5f, #416e24, #365a28, #c9d950, #4c6c30, #659443, #729741, #698338, #587e3a, #385529, #5b7f3b, #89b552, #87a347, #4c7036, #5b7436, #446735, #689048, #87a24c, #56763b, #688c46, #849948, #84ab55, #70964c, #638c49, #8a9b49, #5b733a, #5f7f42, #82a756, #759750, #7e924a, #476639, #8e9e50, #425e35, #405a33, #92b362, #b3cd6f, #4b653a, #c0d472, #819b57, #4f6d40, #65854f, #c8d878, #8ca15c, #899c59, #a5be6d, #8aa965, #768c54, #84a464, #7d9a5e, #5a7549, #718753, #5a7449, #a6ca7e, #57754b, #435637, #405336, #8ca66b, #707a4d, #526542, #95a76b, #3f4a30, #a8bb78, #89ae74, #6c8c5e, #31422d, #96b176, #6f895d, #2b3b29, #87a06c, #7d9466, #8aa673, #8baf7b, #75855d, #849d70, #555f43, #8b9e71, #46543d, #5c694d, #5a6e52, #95ae81, #879f77, #748463, #7b9271, #718468, #606450, #91a082, #5c604e, #40483b, #505647, #545c4d, #2d2831, #514f5e, #797d6b, #5e5869, #656a5b, #4e4f44, #6d6e5f, #736b7e, #879582, #545360, #53515d, #707a6c, #706d7d, #504853, #888093, #a8b19d, #443d46, #585460, #786e7e, #484852, #51525c, #716775, #7c707f, #7a7281, #979787, #504f59, #625d69, #6b6471, #939c8c, #5b6359, #645c68, #625e6a, #7b7280, #474149, #46424a, #59525c, #837f8e, #655c67, #938797, #706773, #615963, #85808e, #6b6671, #706772, #787480, #636960, #616a65, #746f7a, #a396a5, #625b64, #817e8a, #6d7067, #8c818d, #7a7781, #beb6c5, #827c86, #5d575e, #96909b, #8d848e, #676168, #86838c, #99959f, #6a656b, #d7d4de, #7c7b80, #4e4d4f
};
int x = 0;
int y = 0;

int ct = 0;
float maxCt = 0;

//  vars for draw()
float xx1, yy1, xx2, yy2, xx3, yy3, xx4, yy4, xx5, yy5;
//float angle1, angle2, angle3, angle4, angle5;
//float startX1, startY1, startX2, startY2, startX3, startY3, startX4, startY4, startX5, startY5;


  // init 
float radius1;
float radius2;  //200;

float radius3;
float radius4;

float startX1;
float startX2;
float startX3;
float startX4;

float startY1;
float startY2;
float startY3;
float startY4;

float angle1;
float angle2;

float angle3;
float angle4;

float radius5;
float startX5;
float startY5;
float angle5;

float dx, dy;

//  vars for draw()


////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(3);

  cX = width/2;
  cY = height/2;

  noFill();
  strokeWeight(.5);
  smooth();

  //  init
radius1 = 100;  //75;
radius2 = 150;  //130;
radius3 = 250;  //175;
radius4 = 333;  //222;
radius5 = 666;  //333;

startX1 = cX*1.5;
startX2 = cX*1.5;
startX3 = cX*1.5;
startX4 = cX*1.5;
startX5 = cX*1.5;

startY1 = cY;
startY2 = cY;
startY3 = cY;
startY4 = cY;
startY5 = cY;

angle1 = 90;
angle2 = 0;

angle3 = 103;
angle4 = 110;
angle5 = 100;

  // white scan lines
  stroke(111, alf ); // 255
  for ( int ll = 0; ll <= width; ll += 2 ) 
  {  
    strokeWeight( random(1.1) );

    line( 0, ll, random(width), ll );
    line( ll, 0, ll, random(height) );
  }
  

}



void draw()
{
    noFill();
    smooth();

    xx1 = startX1 - int( cos(radians(angle1)) * radius1 );
    yy1 = startY1 - int( sin(radians(angle1)) * radius1 );

    xx2 = startX2 - int( cos(radians(angle2)) * radius2 );
    yy2 = startY2 - int( sin(radians(angle2)) * radius2 );

    xx3 = startX3 - int( cos(radians(angle3)) * radius3 );
    yy3 = startY3 - int( sin(radians(angle3)) * radius3 );

    xx4 = startX4 - int( cos(radians(angle4)) * radius4 );
    yy4 = startY4 - int( sin(radians(angle4)) * radius4 );

    xx5 = startX5 - int( cos(radians(angle5)) * radius5 );
    yy5 = startY5 - int( sin(radians(angle5)) * radius5 );

/*
ranPalStroke(palette2);
ellipse( xx1, yy1, alf, alf );
ellipse( xx2, yy2, alf, alf );
ranPalStroke(palette);
*/
    angle1 += 6;
    angle2 += 9;

    if( radius3 >= radius4 ) {
      angle3 += 2;
    } else if ( radius3 >= radius5 ) {
      angle3 += 6;
    } else {
      angle3 += 8;
    }
    
    angle4 += 4;

    if( angle1 % 2 == 0 ) {
      angle5 += random(4, 8);
    } else {
      angle5 += random(8, 12);
    }



  //  drawing a dot or circle for every vertex
  //  and drawing an arc between two vertices if they are connected by an edge. 
  if( angle1 % 3 == 0 ) {
    strokeWeight( .36 );
    ranPalStroke( palette );
/*
    line( xx1, yy1, xx2, yy2 );
    ellipse( xx2, yy2, alf, alf );

    ranPalStroke( palette );
    line( xx4, yy4, xx5, yy5 );
*/
  }


  if( angle1 % 720 == 0 ) {
    radius3 += alf;
    ranPalStroke( palette );
  }




//  distance patterns
  dx  = dist( xx1, yy2, xx3, yy4 );
  dy  = dist( xx5, yy4, xx3, yy2 );
  
  ranPalStroke(palette);
  strokeWeight( 5 );
  point( dx, dy );
  point( dy, dx );
  strokeWeight(.5);




//  triangles
ranPalStroke( palette3 );
curve( xx1, yy1, xx2, yy2, xx3, yy3, xx4, yy4 );

ranPalStroke( palette3 );
//triangle( xx2, yy2, xx3, yy3, xx4, yy4 );

ranPalStroke( palette3 );
//triangle( xx5, yy5, xx4, yy4, xx2, yy2 );

point( sqrt(xx1*xx2+yy1*yy2)+3, cos(sqrt(xx3*xx4+yy3*yy4))+5 );

  
  if ( angle1 >= (width+height)*37 ) {
    exit();
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




//////////////////////////////////////////////////////////////////////////
//  Draw manual circle
//  ellipse(x, y, width, height)



void circle( float startX, float startY, float w, float h ) {

  float angle = 0;
  float xx, yy;

  while ( angle < 360 ) {

    // make circle draw faster by skipping angles
    //if( angle % 3 == 0 ) {

    xx = startX - int( cos(radians(angle)) * w );
    yy = startY - int( sin(radians(angle)) * w );


    ellipse( xx, yy, w, h );
    //}
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
void doExit() 
{

  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
save( fix.pdeName() + fix.getTimestamp()+".png" );
  }

  noLoop();
  exit();
}

////////////////////////////////////////////////////
//  Randomly stroke using image from color list
void ranPalStroke(color[] palette)
{
  // pallete
  stroke( palette[ int(random( palette.length-1 )) ], alf*.75 );
}
void ranPalFill(color[] palette)
{
  fill( palette[ int(random( palette.length-1 )) ], alf*.75 );
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





/////////////
//  TODO: Is there a better way to get the current sketch name?
String pdeName() {
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

