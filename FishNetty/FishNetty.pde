//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);



//  Grow horizontally ( L to R )
//  OnSplit - use fibonacci sequence for SplitBy
//
//  1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377
//  http://en.wikipedia.org/wiki/Branch-decomposition
//  

//  NOTE: this sketch takes advantage of public vars ( HACKERY )
//  don't delete these

public Boolean isFinal = true;
public Branch br;

//
int alf = 21;
float cX, cY;

float ct = 0;
float maxCt = 360;

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


float x, y;
float radius1, radius2, radius3, radius4, radius5;
float xx1, yy1, xx2, yy2, xx3, yy3, xx4, yy4, xx5, yy5;
float angle1, angle2, angle3, angle4, angle5;
float startX1, startY1, startX2, startY2, startX3, startY3, startX4, startY4, startX5, startY5;

//

//////////////////////////////////////////////////////////////////////////
void setup(){
  size(1024,768);
  background( #343434 );
  br = new Branch( 420, 1);
  smooth();
  noFill();
  ellipseMode(CENTER);
  rectMode(CENTER);
  fix.alpha(alf);

  cX = width * .5;
  cY = height * .5;

  x = cX;
  y = cY;
  
  // init 
  radius1 = 250;
  radius2 = 350;
  
  radius3 = 500;
  radius4 = 550;
  radius5 = 1200;
  
  startX1 = startX2 = startX3 = startX4 = startX5 = x;
  startY1 = startY2 = startY3 = startY4 = startY5 = y;

  angle1 = angle5 = 0;  //50;
  angle2 = 15;  //100;
  angle3 = 45;  //150;
  angle4 = 90;  //200;

  strokeWeight(1);
}


//////////////////////////////////////////////////////////////////////////
void draw(){
  
  //  draw all kids
  for( PVector thisPV : br.KIDS ) {
  
    moveSys( thisPV );

    stroke( br.KIDS.size(),  br.KIDS.size(),  br.KIDS.size(), alf);
    noFill();

    drawSys( thisPV );

  }
  
    //  random growing
    if( frameCount % 111 == 0 ) {
      br.Split();

      textFont( createFont( "Georgia", br.BranchWidth+br.SplitBy) );
      fill( #ABBA00 );
      text(br.KIDS.size() + "/"+ br.BranchWidth, br.KIDS.size(), random(height) );
    }

    //  STOPPER when ANY kid hits < 0
    if( br.BranchWidth < 4.20 ){
      strokeWeight( 1 );
      for( PVector thisPV : br.KIDS ) {
        stroke(#1975EF);
        line( thisPV.x, thisPV.y, thisPV.x, 0 );
      }      


      doExit();
    }  
}


//////////////////////////////////////////////////////////////////////////
//  update the X and Y of supplied PVector
void moveSys( PVector pv ) {

  
  switch( int( random(1) ) ) {
    case 0:
    {

//    vertical
      if( pv.y > 0 ){
        pv.y -= 1;
        pv.x += random( -11,11 );
      } else {
        pv.y = random(height);
        pv.x = random(width);
      }

//      horizontal
      if( pv.x < width ) {
        pv.x += TWO_PI;
        pv.y += random( -1,1 );
      } else {
        pv.y = random(height);
        pv.x = random(width);
      } 

    } 
    break;
  }
  
}

//////////////////////////////////////////////////////////////////////////
//  draw stuff using supplied PVector
void drawSys( PVector pv ) {
  
  switch( int( random(2) ) ) {
    case 0:{
      
//      point( pv.x, pv.y );
//      stroke(random(144, 233), 89);
      rect( pv.x, pv.y, br.BranchWidth, br.BranchWidth, random(-42, 42) );

    } 
    break;

    case 1:{

      
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
      
      
      triangle(  xx1, yy1, xx2, yy2, xx3, yy3 );
      triangle(  xx3, yy3, xx4, yy4, xx5, yy5 );
      
      point( xx1, yy1 );
      point( xx2, yy2 );
      point( xx3, yy3 );
      point( xx4, yy4 );
      point( xx5, yy5 );

      angle1 ++;
      angle5 ++;
  
      angle2 --;
  
      angle3 += 2;
      angle4 += 2;

    } 
    break;

  }
  
}



///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{

      fill(#0A77A0);
      textFont(createFont("Silom",11));
      text("ERICFICKES.COM", 11, height-11 );


  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  }

  noLoop();
  exit();
}








/***********************************************************************/ 

public class Branch{
  
  public int BranchWidth;
  public int SplitBy;
  public ArrayList<PVector> KIDS;

  private ArrayList<PVector> bebeKIDS;
  private int[] fibSplit = { 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233 };
  private int splitCt = 0;  

  ///////////////////////////////////////////////////////////  
  Branch( int bWidth, int splitBy){

    this.BranchWidth = bWidth;
    this.SplitBy = splitBy;
    
    KIDS = new ArrayList<PVector>();
    KIDS.add( new PVector(0,0) );
  }
  
  //  Use @SplitBy ///////////////////////////////////////////////////////////
  //  - Adjust BranchWidth
  //  - return new list of kids
  public void Split(){
    
    //  make sure we're not growing outside of the array
    if( splitCt == fibSplit.length ) {
      splitCt = 0;  //  reset 
    }
    
    //  UPDATE SplitBy to the next number in the fibonacci sequence
    br.SplitBy = fibSplit[ splitCt ];
    //  UPDATE Split counter
    splitCt++;
    
    int oldSz = br.BranchWidth;
    
    // debug
    text( br.BranchWidth, random(width), height-42 );
    
    
    int pX, pY;  // parent X & Y , split point
    bebeKIDS = new ArrayList<PVector>();  // growing and growing
    
    //  shrink width
    br.BranchWidth = int( br.BranchWidth / this.SplitBy );

    //  grow kids    
    //  LOOP THROUGH OLD KIDS
    for( PVector pv : this.KIDS ) {
      
      //  TRANSITION FROM OLD SIZE TO NEW B4 THE NEW KIDS GET DRAWN
      strokeWeight( 1 );
      for( int sz = oldSz; sz > br.BranchWidth; sz -= 2 ) {
        
        stroke(#ABBBBA, 100);
        fill(br.BranchWidth, 100);
        ellipse(  pv.x, 
                  pv.y + random( br.SplitBy ), 
                  sz, sz );
      }
      
      //  MAKE NEW KIDS OUT OF THE OLD KIDS
      for( int ct = 0; ct < this.SplitBy; ct++){
        
        bebeKIDS.add( new PVector(  pv.x + br.SplitBy,
                                    pv.y + random( br.BranchWidth ) ) );

      }
      //  END MAKE KIDS
    }
    //  END LOOP OLD KIDS
    
    //  YOU'VE GOT NEW KIDS!
    this.KIDS.clear();
    this.KIDS = bebeKIDS;
  }

}

/***********************************************************************/ 
