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

public class RadRectGrid extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);

//  RECT GRID playing with rounded rectangle radiuss

public Boolean isFinal = true;
public Branch br;
public int rectSz = 75;

//////////////////////////////////////////////////////////////////////////
public void setup(){
  
  background( 0xffEFEFEF );

  
  noFill();
  ellipseMode(CENTER);
  rectMode(CENTER);
  
  br = new Branch( 420, 2 );
}


//////////////////////////////////////////////////////////////////////////
public void draw(){
  
  //  draw all kids
  for( PVector thisPV : br.KIDS ) {
  
    moveSys( thisPV );

    drawSys( thisPV );

  }


    if( frameCount % 365 == 0 ){
      br.Split();
    }

    //  STOPPER when ANY kid hits < 0


    if( br.BranchWidth < 1 ){
      for( PVector thisPV : br.KIDS ) {
        strokeWeight(PI);
        point(thisPV.x, thisPV.y);
        
        strokeWeight(1);
        stroke(0xff2012EF);
        line( thisPV.x, thisPV.y, thisPV.x, height );
      }      
      textFont(createFont("Silom",37));
      
      fill(0xffEF2012);
      text("ERICFICKES.COM", 9, height-9 );
      
      fill(0xff131313);
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
 
//   if( br.SplitBy % 3 == 0 ){
   
     // horizontal
      if( pv.x < width ) {
          pv.x += rectSz;
      } else {
        pv.y += rectSz;
        pv.x = 0;
      }

  if( pv.x > width && pv.y > height ){
  
    pv.x = 0;
    pv.y = 0;
  
  }

  
}

//////////////////////////////////////////////////////////////////////////
//  draw stuff using supplied PVector
public void drawSys( PVector pv ) {
  
  noFill();
  strokeWeight(1);
  stroke(random(rectSz, br.BranchWidth) );

  rect( pv.x, pv.y, rectSz, rectSz, pv.y/rectSz );

}


/***********************************************************************/ 

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
    br.BranchWidth = PApplet.parseInt( br.BranchWidth / this.SplitBy );

    //  grow kids    
    //  LOOP THROUGH OLD KIDS
    for( PVector pv : this.KIDS ) {
      
      //  TRANSITION FROM OLD SIZE TO NEW B4 THE NEW KIDS GET DRAWN
      strokeWeight( 1 );
      for( int sz = oldSz; sz > br.BranchWidth; sz -= 2 ) {
        
        stroke(0xffEF1975, 100);
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
  public void settings() {  size(1024,768);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "RadRectGrid" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
