//  NO COLOR UNTIL SYSTEM IS FULLY BAKED
//  JUST BLACK POINTS !!!!!!!!!!!!!!!!!!
//  
//  http://en.wikipedia.org/wiki/Branch-decomposition
//  
Boolean isFinal = true;
public Branch br;


//////////////////////////////////////////////////////////////////////////
void setup(){
  size(1024,768);
  background( #EFEFEF );
  br = new Branch( 999, 2);
  smooth();
}

//////////////////////////////////////////////////////////////////////////
void draw(){
  
  //  draw all kids
  for( PVector thisPV : br.KIDS ) {
  
    moveSys( thisPV );
    
    strokeWeight( br.BranchWidth );

    drawSys( thisPV );

  }
  
    //  random growing
    if( frameCount % 187 == 0 ) {
      br.Split();
      
      stroke( random(255), random(255));

      textFont( createFont( "Georgia", random(int(br.BranchWidth), 42 ) ) );
      text(br.KIDS.size() + "/"+ br.BranchWidth, br.KIDS.size(), random(height) );
    }

    //  STOPPER when ANY kid hits < 0
    if( br.BranchWidth < 0.420 ){
      
  for( PVector thisPV : br.KIDS ) {
    line( thisPV.x, thisPV.y, thisPV.x, 0 );
  }      
      
      
      
      
      fill(#EF2012);
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
      //  GROW!      
      if( pv.y > 0 ){
        pv.y--;
        pv.x += random(-TWO_PI,TWO_PI);
      } else {
        pv.y = height;
        pv.x = random(width);
      } 

    } 
    break;
  }
  
}

//////////////////////////////////////////////////////////////////////////
//  draw stuff using supplied PVector
void drawSys( PVector pv ) {
  
  switch( int( random(1) ) ) {
    case 0:{

      point( pv.x, pv.y ); 

    } 
    break;
  }
  
}



///////////////////////////////////////////////////////////
String getTimestamp() {
  return ""+month()+day()+year()+hour()+minute()+millis();
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
  private ArrayList<PVector> stepKIDS;

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
    
// debug
text( br.BranchWidth, random(width), height-42 );
    
    
    int pX, pY;  // parent X & Y , split point
    stepKIDS = new ArrayList<PVector>();  // growing and growing
    
    //  shrink width
    this.BranchWidth = int( this.BranchWidth / this.SplitBy );

    //  grow kids    
    //  LOOP THROUGH OLD KIDS
    for( PVector pv : this.KIDS ) {
    
      //  MAKE NEW KIDS OUT OF THE OLD KIDS
      for( int ct = 0; ct < this.SplitBy; ct++){
        
        stepKIDS.add( new PVector(  pv.x + random(-PI, PI ), 
                                    pv.y - br.BranchWidth ) );

      }
      //  END MAKE KIDS
    }
    //  END LOOP OLD KIDS
    
    //  YOU'VE GOT NEW KIDS!
    this.KIDS.clear();
    this.KIDS = stepKIDS;
  }

}

/***********************************************************************/ 
