//  Grow horizontally ( L to R )
//  OnSplit - use fibonacci sequence for SplitBy
//
//  1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377
//  http://en.wikipedia.org/wiki/Branch-decomposition
//  

public Boolean isFinal = true;
public Branch br;


//////////////////////////////////////////////////////////////////////////
void setup(){
  size(1024,768);
  background( #000011 );
  br = new Branch( 420, 2 );
  smooth();
  noFill();
  ellipseMode(CENTER);
  rectMode(CENTER);
}


//////////////////////////////////////////////////////////////////////////
void draw(){
  
  //  draw all kids
  for( PVector thisPV : br.KIDS ) {
  
    moveSys( thisPV );

    strokeWeight( 1 );
    stroke( random(255), 100 );
    noFill();

    drawSys( thisPV );

  }
  
    //  random growing
    if( frameCount % 222 == 0 ) {
      br.Split();

      textFont( createFont( "Georgia", br.BranchWidth+br.SplitBy) );
      fill( #42ABBA );
      text(br.KIDS.size() + "/"+ br.BranchWidth, br.KIDS.size(), random(height) );
      noFill();
    }

    //  STOPPER when ANY kid hits < 0
    PVector tmp = new PVector(-1,-1);
    if( br.BranchWidth < 1 ){
      for( PVector thisPV : br.KIDS ) {
        
        stroke(#2012EF,42);
        line( thisPV.x, thisPV.y, thisPV.x, height );
        
        if( tmp.x > -1 )
        {
        stroke(#110000);
        line( thisPV.x, thisPV.y, tmp.x, tmp.y );

          stroke(#000011, 42);
          curve( thisPV.y, thisPV.x, 
                 thisPV.x-width, thisPV.y-width,
                 tmp.x+height, tmp.y+height,
                tmp.y, tmp.x );
        }
        tmp = thisPV;
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

  
  switch( int( random(5) ) ) {
    case 0:
    case 1:
    case 2:
    {
//      horizontal
      if( pv.x < width ) {
        pv.x += 11+br.SplitBy;
      } else {
        pv.y += 11+br.SplitBy;
        pv.x = random(width);
      } 

    } 
    break;
    
    case 3:
    case 4:
    {
////      vertical
      if( pv.y > 0 ){
        pv.y -= random( -br.SplitBy, br.SplitBy);
        pv.x += random( -11,11 );
      } else {
        pv.y = random(br.BranchWidth);
        pv.x = random(width);
      }

    }
  }
  
}

//////////////////////////////////////////////////////////////////////////
//  draw stuff using supplied PVector
void drawSys( PVector pv ) {
  
  switch( int( random(2) ) ) {
    case 0:{
      
      stroke( random(255) );
      strokeWeight(random(11));
      point( pv.x, pv.y );
      
      stroke( random(255), 100 );
      strokeWeight(1);
      ellipse( pv.x, pv.y, br.BranchWidth, br.SplitBy );

    } 
    break;

    case 1:{
      
      point( pv.x, pv.y );
      ellipse( pv.x, pv.y, br.SplitBy, br.BranchWidth );
      
      strokeWeight(1);
      rect( pv.x, pv.y, br.SplitBy, br.SplitBy, (width+height)-frameCount );

    } 
    break;

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
        
        stroke(#FF1234, 100);
        fill(br.BranchWidth, 100);

        rect(  pv.x + 1, 
                  pv.y + random( br.SplitBy ), 
                  sz, sz, sz );
      }
      
      //  MAKE NEW KIDS OUT OF THE OLD KIDS
      for( int ct = 0; ct < this.SplitBy; ct++){
        
        bebeKIDS.add( new PVector(  pv.x + random( br.SplitBy ),
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
