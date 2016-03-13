
public Boolean isFinal = true;
public Branch br;

int cX, cY;

//////////////////////////////////////////////////////////////////////////
void setup(){
  size(1024,768);
  background( #42ABBA );
  frameRate(303);
  br = new Branch( 420, 1);
  smooth();
  noFill();
//  ellipseMode(CENTER);
  ellipseMode(RADIUS);
  rectMode(CENTER);
  
  cX = width/2;
  cY = height/2;
}


//////////////////////////////////////////////////////////////////////////
void draw(){
  
  //  draw all kids
  for( PVector thisPV : br.KIDS ) {
  
    moveSys( thisPV );

    strokeWeight( br.BranchWidth );
    stroke( random(185, 255) );
    noFill();

    drawSys( thisPV );
    
  }

    //  random growing
    if( frameCount % 180 == 0 ) {
      br.Split();

      textFont( createFont( "Georgia", br.BranchWidth+br.SplitBy) );
      fill( #ABBA00 );
      text(br.KIDS.size() + "/"+ br.BranchWidth, br.KIDS.size(), random(height) );
    }

    //  STOPPER when ANY kid hits < 0
    if( br.BranchWidth < 2 ){
      for( PVector thisPV : br.KIDS ) {
        stroke(#69ABBA, 100);
        line( thisPV.x, thisPV.y, thisPV.x, 0 );
      }      

      fill(#0A77A0);
      textFont(createFont("Silom",11));
      text("ERICFICKES.COM", 11, height-11 );
      if(isFinal){
        save( pdeName() + getTimestamp() + ".png" );
      }
      noLoop();
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
  
  switch( int( random(3) ) ) {
    
    case 0:{
      
      point( pv.x, pv.y );
      rect( pv.x, pv.y, br.BranchWidth, br.BranchWidth, random(-42, 42) );

    } 
    break;

    case 1:{
      noFill();
      
      point( pv.y, pv.x );
      ellipse( pv.y, pv.x, br.SplitBy, br.SplitBy );
      
      strokeWeight(1);
      rect( pv.y, pv.x, br.SplitBy, br.SplitBy, frameCount );

    } 
    break;
    
    case 2:{
    
        strokeWeight(2);
        noFill();
        
        if( frameCount % 2 == 0 )
          stroke(#EF1975);
        else
          stroke(#EFEFEF);
      
        ellipse( pv.x, pv.y, br.BranchWidth, br.BranchWidth );
        ellipse( pv.y, pv.x, br.SplitBy, br.SplitBy );
        line( pv.x, cY*1.04, cX-pv.x, pv.y);
        line( pv.y, cY*1.04, cX-pv.y, pv.x);
      
      
      stroke(random(255), 11, 11);
      line( cX, cY, pv.x, pv.y );
      line( cX, cY, pv.y, pv.x );

    
    } break;
  
  }
  
}






String getTimestamp() {
  return ""+month()+day()+year()+hour()+second()+millis();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?
String pdeName() {
  return split( this.toString(), "[")[0];
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
        
        stroke(#00A11A, 100);
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
