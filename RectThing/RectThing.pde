//  RECT GRID playing with rounded rectangle radiuss

public Boolean isFinal = true;
//public Branch br;
public int cols = 5, rows = 4;
public float xx = 0, yy = 0, rowHeight, colWidth, rectSz, tmp, strokeSz;

//////////////////////////////////////////////////////////////////////////
void setup(){
  size(1024,768);
  background(0);

  smooth();
  noFill();
  
  ellipseMode(CENTER);
  rectMode(CENTER);


  
  colWidth = 1024/cols;
  rowHeight = 768/rows;

  rectSz = (colWidth+rowHeight);
  strokeSz = int(rectSz/cols);
}


//////////////////////////////////////////////////////////////////////////
void draw(){

    strokeWeight(strokeSz);
    

    rect( xx, yy, rectSz, rectSz, rectSz/xx-yy);
    
    if( frameCount%2==0)
      stroke( random(42,255) );
    else
      stroke(0);
      
//    rect( xx, yy, int(rectSz/rows), int(rectSz/rows), -rectSz);
//    rect( xx, yy, int(rectSz/rows), int(rectSz/rows), -yy);
//    rect( xx, yy, int(rectSz/rows), int(rectSz/rows), -xx);
rect( xx, yy, int(rectSz/rows), int(rectSz/rows), -strokeSz);

  //  move
  if( xx < 1024+colWidth ){
    xx += colWidth;
  } else {
    xx = 0;
    yy += rowHeight;    
  }
  
  if( xx >= 1024+colWidth && yy >= 768+rowHeight ) {
    xx = 0;
    yy = 0;
  
    rectSz -= cols;
    strokeSz -= noise(frameCount);
    
    if(strokeSz<1){
      strokeSz=1.5;
    }
  }


  if( rectSz < 0 ) {
  
      fill(#EF2012);
      textFont(createFont("Silom",42));
      text("ERICFICKES.COM", 0, height-2 );
      if(isFinal){
        save( pdeName() + getTimestamp() + ".png" );
      }
      noLoop();
  }
}


///////////////////////////////////////////////////////////////////////
void rectEye( float a, float b, float shapeSize ){

  int tmp = (int)shapeSize;
  
  while(  tmp >= 0 ) {

    strokeWeight(tmp/24);
    fill(0);
    stroke(255);

    rect( a, b, tmp, tmp, random(tmp) );
    
    tmp -= int(shapeSize/6);
  }

  
}


//////////////////////////////////////////////////////////////////////////
//  update the X and Y of supplied PVector
void moveSys( PVector pv ) {
 
//   if( br.SplitBy % 3 == 0 ){
   
     // horizontal
      if( pv.x < width ) {
          pv.x += 51;
      } else {
        
        if( pv.y < height )
          pv.y += 51;
        else
          pv.y = 0;
        
        
        pv.x = 0;
      }
      
//   } else {
//
//     // vertical
//      if( pv.y < height ) {
//          pv.y += rectSz+PI;
//      } else {
//        pv.y = 0;
//        pv.x += rectSz+PI;
//      }
//   
//   }


  if( pv.x >= width && pv.y >= height ){
    pv.x = 0;
    pv.y = 0;
    

    rectSz += 6;
    
  }

  
}

//////////////////////////////////////////////////////////////////////////
//  draw stuff using supplied PVector
void drawSys( PVector pv ) {
  
  noFill();
  strokeWeight(2);
  stroke(random(255) );

  ellipse( pv.x, pv.y, rectSz, rectSz );
  rect( pv.x, pv.y, 50, 50, rectSz );

//  switch( int( random(2) ) ) {
//    case 0:{
//
//      rect( pv.x, pv.y, br.BranchWidth, br.BranchWidth, random(-br.BranchWidth, br.BranchWidth) );
//
//    } 
//    break;
//
//    case 1:{100
//
//      stroke(random(br.SplitBy),random(br.SplitBy),random(br.SplitBy), 100);
//      rect( pv.y, pv.x, br.SplitBy, br.SplitBy, random(-br.SplitBy, br.SplitBy) );
//
//    } 
//    break;
//
//  }
  
}


///////////////////////////////////////////////////////////////////////
void bullsEye( float a, float b, float shapeSize ){

  int tmp = (int)shapeSize;
  
  while(  tmp >= 0 ) {

    strokeWeight(tmp/24);
    fill(0);
    stroke(255);

    ellipse( a, b, tmp, tmp);
    tmp -= int(shapeSize/6);
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
/***********************************************************************/
/***********************************************************************/
/***********************************************************************
public class Branch{
  
  public int BranchWidth;
  public int SplitBy;
  public ArrayList<PVector> KIDS;

  private ArrayList<PVector> bebeKIDS;
//  private int[] fibSplit = { 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233 };
  private int[] fibSplit = { 2, 3, 6, 7, 8, 9, 10, 11, 12, 13 };
  private int splitCt = 0, splitX;  

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
        
        stroke(#EF1975, 100);
        fill(br.BranchWidth, 100);
        rect(  pv.x, 
                  pv.y + br.SplitBy, 
                  sz, sz,
                  sz );
      }
      
      // position kids based on splitBy and parent X/Y
      splitX = br.BranchWidth/2;
      
      //  MAKE NEW KIDS OUT OF THE OLD KIDS
      for( int ct = 0; ct < br.SplitBy; ct++){
//        + (ct*br.SplitBy)
        bebeKIDS.add( new PVector(  pv.x - splitX - (ct*br.SplitBy)  ,
                                    pv.y + splitX + (ct*br.SplitBy) ) );

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
