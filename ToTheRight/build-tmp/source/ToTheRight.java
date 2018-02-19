import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import fixlib.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ToTheRight extends PApplet {

// https://github.com/ericfickes/FIXLIB 


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


//////////////////////////////////////////////////////////////////////////
public void setup(){
  
  background( 0xff000022 );
  br = new Branch( 666, 1);
  
  noFill();

}


//////////////////////////////////////////////////////////////////////////
public void draw(){
  
  //  draw all kids
  for( PVector thisPV : br.KIDS ) {
  
    moveSys( thisPV );

    strokeWeight( br.BranchWidth );
    stroke( random(22) );
    noFill();

    drawSys( thisPV );

  }
  
    //  random growing
    if( frameCount % 187 == 0 ) {
      br.Split();

      textFont( createFont( "Georgia", br.BranchWidth+br.SplitBy) );
      fill( 0xffABBA11 );
      text(br.KIDS.size() + "/"+ br.BranchWidth, br.KIDS.size(), random(height) );
    }

    //  STOPPER when ANY kid hits < 0
    if( br.BranchWidth < 1 ){

      PVector last = new PVector(0,0);
      int ct = 0;

      strokeWeight( br.BranchWidth );
      fill( 0xffABBA11 );
      
      
      for( PVector thisPV : br.KIDS ) {
      stroke(0xffEF1975,42);  //  216921  
        
        if( ct > 1 ) {
          line( last.x, last.y, thisPV.x, thisPV.y );
        } else { 
          line( thisPV.x, thisPV.y, thisPV.x, 0 );
        }
        
        
        rect(thisPV.x, thisPV.y, 11, 11, random(frameCount) );
        
        ct++;
        last = thisPV;
        
      }      

      fill(0xff0A77A0);
      textFont(createFont("Silom",11));
      text("ERICFICKES.COM", 11, height-11 );
      if(isFinal){
        save( fix.pdeName() + fix.getTimestamp() + ".png" );
      }
      noLoop();
      exit();
    }  
}


//////////////////////////////////////////////////////////////////////////
//  update the X and Y of supplied PVector
public void moveSys( PVector pv ) {

  
  switch( PApplet.parseInt( random(1) ) ) {
    case 0:
    {

//    vertical
//      if( pv.y > 0 ){
//        pv.y -= random( -11,11 );
//        pv.x += random( -3,3 );
//      } else {
//        pv.y = random(height);
//        pv.x = random(width);
//      }

//      horizontal
      if( pv.x < width ) {
        pv.x += 9;
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
public void drawSys( PVector pv ) {
  
  switch( PApplet.parseInt( random(2) ) ) {
    case 0:{
      
      rect( pv.x, pv.y, 11, 11, pv.x/pv.y );
    } 
    break;
//
//    case 1:{
//      point( pv.y, pv.x );
//      ellipse( pv.y, pv.x, br.SplitBy, br.SplitBy );
//      
//      strokeWeight(1);
//      rect( pv.y, pv.x, br.SplitBy, br.SplitBy, frameCount );
//
//    } 
//    break;
//
  }
  
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
    br.BranchWidth = PApplet.parseInt( br.BranchWidth / this.SplitBy );

    //  grow kids    
    //  LOOP THROUGH OLD KIDS
    for( PVector pv : this.KIDS ) {
      
      //  TRANSITION FROM OLD SIZE TO NEW B4 THE NEW KIDS GET DRAWN
      strokeWeight( 1 );
      for( int sz = oldSz; sz > br.BranchWidth; sz -= 2 ) {
        
        stroke(0xff216921, 100);
        fill(br.BranchWidth, 100);
        ellipse(  pv.x, 
                  pv.y + random( br.SplitBy ), 
                  sz, sz );
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
  public void settings() {  size(1024,768);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ToTheRight" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
