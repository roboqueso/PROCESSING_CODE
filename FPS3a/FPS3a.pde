// https://github.com/ericfickes/FIXLIB	
import fixlib.*;

Fixlib fix = Fixlib.init(this);
Boolean isFinal = true;
int alf = 11;
int shapeSize = 15;
float strokeSize = 20;

int cX;
int cY;

int cc = 0;
int maxCC = 797;//  1400;


color[] palette = { 
#524a52, #645c64, #6e656e, #988d98, #938b93, #918a91, #938793, #887f88, #978e96, #5e555d, #7a7279, #7c6f7a, #6e686d, #685d66, #867c84, #92848f, #8b8289, #756872, #3e363c, #6a6268, #8b8088, #4e434b, #867b83, #756771, #645a61, #786e75, #978a93, #8b7f87, #564d53, #665d63, #7b7077, #756a71, #6d6369, #6e676b, #4f444a, #42383d, #655b60, #61545a, #a39199, #5e5559, #94888d, #706266, #73676a, #78676b, #685559, #9f858a, #908587, #a3868b, #6e5c5f, #684f53, #765c5e, #988586, #887475, #c6aeaf, #977c7d, #937475, #fefdfd, #fbf8f8, #6e5a5a, #9e8787, #766e6e, #8a8181, #867777, #847c7c, #705857, #6a5251, #7c6867, #907c7b, #bda2a0, #ae9593, #8d7775, #79605d, #dfcfcd, #f4edec, #6f6867, #b29692, #987772, #8e7470, #8e6c65, #af958f, #8a6c65, #ceb6b0, #887c79, #5a5655, #9c7970, #9f7e74, #816b64, #544641, #755c52, #8e6e5f, #605a57, #89827d, #7f766f, #a49a91, #55504b, #685f56, #78726a, #625d55, #7b7568, #78766e, #716e5f, #416e24, #365a28, #c9d950, #4c6c30, #659443, #729741, #698338, #587e3a, #385529, #5b7f3b, #89b552, #87a347, #4c7036, #5b7436, #446735, #689048, #87a24c, #56763b, #688c46, #849948, #84ab55, #70964c, #638c49, #8a9b49, #5b733a, #5f7f42, #82a756, #759750, #7e924a, #476639, #8e9e50, #425e35, #405a33, #92b362, #b3cd6f, #4b653a, #c0d472, #819b57, #4f6d40, #65854f, #c8d878, #8ca15c, #899c59, #a5be6d, #8aa965, #768c54, #84a464, #7d9a5e, #5a7549, #718753, #5a7449, #a6ca7e, #57754b, #435637, #405336, #8ca66b, #707a4d, #526542, #95a76b, #3f4a30, #a8bb78, #89ae74, #6c8c5e, #31422d, #96b176, #6f895d, #2b3b29, #87a06c, #7d9466, #8aa673, #8baf7b, #75855d, #849d70, #555f43, #8b9e71, #46543d, #5c694d, #5a6e52, #95ae81, #879f77, #748463, #7b9271, #718468, #606450, #91a082, #5c604e, #40483b, #505647, #545c4d, #2d2831, #514f5e, #797d6b, #5e5869, #656a5b, #4e4f44, #6d6e5f, #736b7e, #879582, #545360, #53515d, #707a6c, #706d7d, #504853, #888093, #a8b19d, #443d46, #585460, #786e7e, #484852, #51525c, #716775, #7c707f, #7a7281, #979787, #504f59, #625d69, #6b6471, #939c8c, #5b6359, #645c68, #625e6a, #7b7280, #474149, #46424a, #59525c, #837f8e, #655c67, #938797, #706773, #615963, #85808e, #6b6671, #706772, #787480, #636960, #616a65, #746f7a, #a396a5, #625b64, #817e8a, #6d7067, #8c818d, #7a7781, #beb6c5, #827c86, #5d575e, #96909b, #8d848e, #676168, #86838c, #99959f, #6a656b, #d7d4de, #7c7b80, #4e4d4f, #8B5F1A,#CBA53A,#3F230E,#FBDC8B,#A4A590,#E96303,#86724A,#B1CEA0,#D4D6CE,#FEF3C1,#CCBF8E,#F62200,#882E02,#B1D6D3,#858B64,#D4F0D5,#80B1C2,#B1BABB,#FBDCC4,#D6F1F1,#5D6260,#D48421,#D7DDEE,#CDBABF,#8D827F,#F0DDEE,#A14232,#EFEEEA,#FFFFE8,#ECFFEC,#EEFFFF,#FFFFFF, #A59DA1,#D96D55,#F36613,#A9ABEA,#D23301,#F6FAFD,#AB6E9C,#D6F9FF,#F8751E,#768A00,#F05510,#FFEE51,#FFB02A,#D7D5FA, #DD570D,#D4190D,#9D0D0D,#65A90A,#660D0C,#D8930C,#DFDD0E,#595C0B,#A7700C,#190D09,#DDAC0B,#AF8B0C,#8ACF11,#77C00E,#DE7D0D,#C8B556,#E8AB0E,#BA9E4B,#C48919,#D4A826,#916D32,#D9D439,#74532A,#E0BF13,#493608,#E39519,#B4D11F,#523523,#5B860B,#BC772A,#371F11,#7D410B
  };

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(18);

  //  setup variables
  cX = width/2;
  cY = height/2;

    smooth();
    noFill();
    strokeWeight( strokeSize );
}


float xx = 0;
float yy = alf;
////////////////////////////////////////////////////
//
void draw()
{
  if( cc <= maxCC ) {

    smooth();
    noFill();

    randStrokeUser();
    strokeWeight( random( 1.99 ) );
    ellipse( xx, yy, cX, cY-110 );

    if( frameCount % 5 == 0 ) {
      line( xx, yy, cX, cY-110 );
    }
    
    rect( xx, yy, cX, cY-110 );
    
    stroke(255,alf*4);
    strokeWeight( alf );
    point( xx, yy );
    
    if( xx >= (width-shapeSize) ) {
      xx = 0;
      yy += (shapeSize+strokeSize);
    } else { 
      xx += (shapeSize+strokeSize);
    }

cc++;

  } else {

    //  horizontal bar(s)
    hexBar( 40, 0, 50);
    hexBar( 30, 0, 40);
    hexBar( 10, 0, 20);
    hexBar( 1, #EFEF36, alf*3);

/*
    // vertical
    for( int ll = 0; ll <= width; ll += (shapeSize*2) ) {
      smooth();
      randStrokeUser();
      strokeWeight( (shapeSize*2) );
      line( ll, cY+180, ll, height );
    }
*/
    // horizontal
    for( int ll = (cY+180); ll <= height; ll++ ) {
      smooth();
      randStrokeUser();
      strokeWeight( .75 );
      
      line( 0, ll, width, ll );
    }
    
    exit();

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
    save( this + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
  }

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
  stroke( palette[ int(random( palette.length-1 )) ] , alf );
}
void randFillUser()
{
  fill( palette[ int(random( palette.length-1 )) ] , alf );
}



////////////////////////////////////////////////////////////////////////////
//  Draw a horizontal bar across the screen of hexagons
void hexBar( float strokeSz, int strokeColor, float strokeAlpha ) {
    strokeWeight( strokeSz );
    stroke( strokeColor, strokeAlpha );

    for( int bb = -200 ; bb <= width; bb += 50 ) {
      hexagon( bb, (cY+180), 250 ); 
    }
}




///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  PFont font = createFont( "Silom", 18 );

  smooth();
  textFont( font );
  strokeWeight(1);

//  fill( #000000 , 666 );
  fill(#EFEFEF, pow(alf,3) );
  text( " "+dailyMsg, this.width-225, this.height-15);
  
//  fill( #003600 , 666 );
  fill(#CADDAC, pow(alf,3) );
  text( " "+dailyMsg, this.width-226, this.height-16);
}

