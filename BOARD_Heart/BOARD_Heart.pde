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
int alf = 10;
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

}


////////////////////////////////////////////////////
//
void draw()
{

//  drawSuns( cX+15, cY);

  fix.bitHeart( cX-180, cY-180, true );
  
/*  line( cX, 0, cX, height );
  line( cX+30, 0, cX+30, height );
  line( 0, cY, width, cY );*/

  doExit();
}


///////////////////////////////
//  draw a center line core
//  draw the wirey outer shine
void drawSuns( float x, float y ) {
 
float radius1, radius2, radius3, radius4, radius5;
float xx1, yy1, xx2, yy2, xx3, yy3, xx4, yy4, xx5, yy5;
float angle1, angle2, angle3, angle4, angle5;
float startX1, startY1, startX2, startY2, startX3, startY3, startX4, startY4, startX5, startY5;

  // init 
  radius1 = 50;
  radius2 = 150;
  
  radius3 = 300;
  radius4 = 350;
  radius5 = 1000;
  
  startX1 = startX2 = startX3 = startX4 = startX5 = x;
  startY1 = startY2 = startY3 = startY4 = startY5 = y;

  angle1 = angle5 = 0;  //50;
  angle2 = 15;  //100;
  angle3 = 45;  //150;
  angle4 = 90;  //200;
  

// draw circles
  while ( angle1 < 1080 ) {
    
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

//    randStrokeUser();
    stroke(0, alf);
    strokeWeight( .5 );
//    curve( xx1, yy1, xx2, yy2, xx3, yy3, xx4, yy4 );


if( angle1 % 6 == 0 ) {
  stroke( #EF0000, alf*2 );
  strokeWeight(1);
  curve( xx1, yy1, xx2, yy2, xx3, yy3, xx4, yy4 );
  
  stroke( #00EF00, alf*2 );
  strokeWeight(1);
  curve( xx3, yy3, xx4, yy4,xx1, yy1, xx2, yy2 );
  
  stroke( #0000EF, alf*2 );
  strokeWeight(1);
  curve( xx1, yy2, xx3, yy4, xx1, yy2, xx3, yy4 );
  

} else {

  stroke(#363636, alf*3 );
  strokeWeight( .25 );

  line( xx1, yy3, xx5, yy5 );
  line( xx3, yy1, xx5, yy5 );

}
  

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

  artDaily( "ERICFICKES.COM" );

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

  //  stroke(#EFEFEF);
  //  fill(#EE0000);
  //fill(#00EE00);
  fill(0);
  text( " "+dailyMsg, this.width*.45, this.height-18);
}

