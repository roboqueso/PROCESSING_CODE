//
//  
//

Boolean isFinal = true;
float alf = 37;
float shapeSize = alf;

int cX;
int cY;

/*
#6e5c5f, #684f53, #765c5e, #988586, #887475, #c6aeaf, #977c7d, #937475, #fefdfd, #fbf8f8, #6e5a5a, #9e8787, #766e6e, #8a8181, #867777, #847c7c, #705857, #6a5251, #7c6867, #907c7b, #bda2a0, #ae9593, #8d7775, #79605d, #dfcfcd, #f4edec, #6f6867, #b29692, #987772, #8e7470, #8e6c65, #af958f, #8a6c65, #ceb6b0, #887c79, #5a5655, #9c7970, #9f7e74, #816b64, #544641, #755c52, #8e6e5f, #605a57, #89827d, #7f766f, #a49a91, #55504b, #685f56
#78726a, #625d55, #7b7568, #78766e, #716e5f, #416e24, #365a28, #c9d950, #4c6c30, #659443, #729741, #698338, #587e3a, #385529, #5b7f3b, #89b552, #87a347, #4c7036, #5b7436, #446735, #689048, #87a24c, #56763b, #688c46, #849948, #84ab55, #70964c, #638c49, #8a9b49, #5b733a, #5f7f42, #82a756, #759750, #7e924a, #476639, #8e9e50, #425e35, #405a33, #92b362, #b3cd6f, #4b653a, #c0d472, #819b57, #4f6d40, #65854f, #c8d878, #8ca15c, #899c59, #a5be6d, #8aa965, #768c54, #84a464, #7d9a5e, #5a7549, #718753, #5a7449, #a6ca7e, #57754b, #435637, #405336
*/
color[] palette = { 
#8B5F1A,#CBA53A,#3F230E,#FBDC8B,#A4A590,#E96303,#86724A,#B1CEA0,#D4D6CE,#FEF3C1,#CCBF8E,#F62200,#882E02,#B1D6D3,#858B64,#D4F0D5,#80B1C2,#B1BABB,#FBDCC4,#D6F1F1,#5D6260,#D48421,#D7DDEE,#CDBABF,#8D827F,#F0DDEE,#A14232,#EFEEEA,#FFFFE8,#ECFFEC,#EEFFFF,#FFFFFF,
#6e5c5f, #684f53, #765c5e, #988586, #887475, #c6aeaf, #977c7d, #937475, #fefdfd, #fbf8f8, #6e5a5a, #9e8787, #766e6e, #8a8181, #867777, #847c7c, #705857, #6a5251, #7c6867, #907c7b, #bda2a0, #ae9593, #8d7775, #79605d, #dfcfcd, #f4edec, #6f6867, #b29692, #987772, #8e7470, #8e6c65, #af958f, #8a6c65, #ceb6b0, #887c79, #5a5655, #9c7970, #9f7e74, #816b64, #544641, #755c52, #8e6e5f, #605a57, #89827d, #7f766f, #a49a91, #55504b, #685f56,
#78726a, #625d55, #7b7568, #78766e, #716e5f, #416e24, #365a28, #c9d950, #4c6c30, #659443, #729741, #698338, #587e3a, #385529, #5b7f3b, #89b552, #87a347, #4c7036, #5b7436, #446735, #689048, #87a24c, #56763b, #688c46, #849948, #84ab55, #70964c, #638c49, #8a9b49, #5b733a, #5f7f42, #82a756, #759750, #7e924a, #476639, #8e9e50, #425e35, #405a33, #92b362, #b3cd6f, #4b653a, #c0d472, #819b57, #4f6d40, #65854f, #c8d878, #8ca15c, #899c59, #a5be6d, #8aa965, #768c54, #84a464, #7d9a5e, #5a7549, #718753, #5a7449, #a6ca7e, #57754b, #435637, #405336
};

ArrayList _pvectors = new ArrayList();
int ct = 0;
int maxCt = 0;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(0);

  //  setup variables
  cX = width/2;
  cY = height/2;

  // RED  - stroke( #B00B13, alf*3 );
  // GREEN
  stroke( #20EF12, alf*2 );

noFill();
  
  maxCt = int(360*4);
  drawFrame();
//  ellipseMode(CENTER);
  
      //  scan lines
    stroke(#000000, alf );
    for ( int ll = 0; ll <= width; ll += 2 ) 
    {  
      strokeWeight( random(alf) );
  
      line( 0, ll, width, ll );
      line( ll, 0, ll, height );
    }
  
}


////////////////////////////////////////////////////
//

float _x = 135;
float _y = 135;
PVector thisPt,lastPt, pv1, pv2, pv3, pv4 = new PVector();

void draw()
{
  smooth();
  noFill();
  randStrokeUser();
  
  _x = lerp( 200, random(width*1.7), .5 );
  _y = lerp( 404, random(height), .69 );

  // store this point
  _pvectors.add( new PVector( _x, _y ) );

  if( _pvectors.size() > 1 )
  {

    //  connect this point ( _x, _y ) to the last
    lastPt = (PVector)_pvectors.get( _pvectors.size()-2 );
    strokeWeight( random( alf/10) );

/*
    if( frameCount % 2 == 0 )
      circle( lastPt.x, lastPt.y, shapeSize, shapeSize );
    else if( frameCount % 3 == 0 )  
      hexagon( lastPt.x, lastPt.y, shapeSize);
    else
      point( lastPt.x, lastPt.y );
*/

if( frameCount % 60 == 0 ) {
  stroke(#FF5E00, alf*1.5 );
  strokeWeight( random( shapeSize*alf) );
  ellipse( _x, _y, shapeSize*2, alf*2 ); 

  //  reset
  randStrokeUser();
  strokeWeight( random( alf) );
}


    //  drop a curve every 4th point
    if( _pvectors.size() % 4 == 0 ) {
      pv1 = (PVector)_pvectors.get( _pvectors.size()-1 );
      pv2 = (PVector)_pvectors.get( _pvectors.size()-2 );
      pv3 = (PVector)_pvectors.get( _pvectors.size()-3 );
      pv4 = (PVector)_pvectors.get( _pvectors.size()-4 );

      randStrokeUser();
      strokeWeight(2.5);
      curve( pv1.x, pv1.y, pv2.x, pv2.y, pv3.x, pv3.y, pv4.x, pv4.y );


      strokeWeight( random(2.5) );
      point( pv1.x, pv1.y );
      point( pv2.x, pv2.y );
      point( pv3.x, pv3.y);
      point( pv4.x, pv4.y );
      
     
    } else {

      strokeWeight( random( 9.9) );
      randStrokeUser();
      
//      line( lastPt.x, lastPt.y, _x, _y );

      point( lastPt.x, lastPt.y );
    }


  randStrokeUser();
  strokeWeight( random(alf) );  // 2
  point( _x, _y );
  
  strokeWeight( random(alf) );  // .9
  stroke(#00000E, alf);  //  000000
  hexagon( _x, _y, shapeSize );

       
  }
  

  if( ct >= maxCt ) {


        
    exit();
  }
  
  ct++;
}

///////
//  draw frame
void drawFrame() {

  noFill();  
  rectMode(CORNER);
  
  strokeWeight( 100 );
  rect( 0,0, width, height);
  
  strokeWeight( 5 );
  rect( 64,65, width-128, height-129 );

  strokeWeight( 15 );
  rect( 84,85, width-168, height-168 );

  //  dashed line
  strokeWeight(6);
  int x = 110;
  int y = 110;

  strokeCap(PROJECT);

  for( int pp = 0; pp <= (width*height); pp++ ) { 

    if( x <= (width-110) ) {
      // top row    
      point( x, y );
      //  bottom row
      point( x, 790 );

      x += 10;

    } else if ( y <= 780 ) {
      
      // left row    
      point( (width-110), y );
      //  right row
      point( 110, y );
      y += 10;
    }
    
  }

  strokeWeight( 5 );
  rect( 122,122, width-245, height-245 );

  }

//////////////////////////////////////////////////////////////////////////
//  Draw manual circle
//  ellipse(x, y, width, height)

float radius = 18, xx, yy;

void circle( float startX, float startY, float w, float h ) {

  float angle = 0;

  while( angle < 360 ) {
    xx = startX - int( cos(radians(angle)) * radius );
    yy = startY - int( sin(radians(angle)) * radius );


    ellipse( xx, yy, w, h );
 
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
  stroke( palette[ int(random( palette.length-1 )) ] , alf*.5 );
}
void randFillUser()
{
  fill( palette[ int(random( palette.length-1 )) ] , alf*.5 );
}


String getTimestamp() {
  return ""+month()+day()+year()+hour()+minute()+millis();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {
  
  PFont font = createFont( "Silom", 18 );

  smooth();
  textFont( font );

  text( " "+dailyMsg, this.width*.45, this.height-18);

}

