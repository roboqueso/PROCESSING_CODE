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

public class Branched extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);

//
//  http://en.wikipedia.org/wiki/Branch-decomposition
//  

public Boolean isFinal = true;
public Branch br;
public Branch br2;


//////////////////////////////////////////////////////////////////////////
public void setup(){
  
  background( 0xffDADDAD );
  br = new Branch( 1024, 3);
  br2 = new Branch( 1024, 2);
  
  noFill();
  ellipseMode(CENTER);
  rectMode(CENTER);
}


//////////////////////////////////////////////////////////////////////////
public void draw(){
  
  //  draw all kids
  for( PVector thisPV : br.KIDS ) {
  
    moveSys( thisPV );

    strokeWeight( br.BranchWidth );
    stroke( random(br.BranchWidth), random(br.BranchWidth), random(br.BranchWidth), 42);
    
    drawSys( thisPV );

  }
  for( PVector thisPV2 : br2.KIDS ) {
  
    moveSys( thisPV2 );

    strokeWeight( br2.BranchWidth );
    stroke( random(br2.BranchWidth));
    
    drawSys( thisPV2 );

  }

  
  
  
    //  random growing
    if( frameCount % 111 == 0 ) {
      br.SplitBubble();
      br2.SplitBubble();

      text(br.KIDS.size() + "/"+ br.BranchWidth, br.KIDS.size(), random(height) );
      text(br2.KIDS.size() + "/"+ br2.BranchWidth, br2.KIDS.size(), random(height) );
    }


    noFill();

    //  STOPPER when ANY kid hits < 0
    if( br.BranchWidth < 1 )
    {
      for( PVector thisPV : br.KIDS ) {
        stroke( random(255), random(255), random(42), 42 );
        line( thisPV.x, thisPV.y, thisPV.x, 0 );
        line( thisPV.y, thisPV.x, thisPV.y, 0 );
      }
      
      for( PVector thisPV : br2.KIDS ) {
        stroke( random(255), random(42), random(255), 42 );
        line( thisPV.x, thisPV.y, thisPV.x, 0 );
        line( thisPV.y, thisPV.x, thisPV.y, 0 );
      }

      fill(0xffefefef);
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
  
  noiseDetail( frameCount/10);
  
  switch( PApplet.parseInt( random(1) ) ) {
    case 0:
    {
      //  GROW!      
      if( pv.y > 0 ){
        pv.y -= PI;
        pv.x += random(-9, 9);
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
public void drawSys( PVector pv ) {
  
  switch( PApplet.parseInt( random(1) ) ) {
    case 0:{
      
      strokeWeight( 1 );
      stroke( 0, 0, random(42) , 11);
      ellipse( pv.x, pv.y, pv.y, pv.y );
      noFill();

      strokeWeight( random(11, 42) );
      stroke( random(pv.y) );
      point( pv.x, pv.y ); 

    } 
    break;
    /*
    case 1:{
    } 
    break;
    */
  }
  
}



/***********************************************************************/ 
/***********************************************************************/ 
/***********************************************************************/ 
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
  //  - Bubble up at the end of each old KID
  //  - Replace old KIDS with new KIDS
  public void SplitBubble(){
    
    int oldSz = this.BranchWidth;
    PVector tmpVector = new PVector(0,0);

    // debug
    text( this.BranchWidth, random(width), height-42 );
    
    
    int pX, pY;  // parent X & Y , split point
    stepKIDS = new ArrayList<PVector>();  // growing and growing
    
    //  shrink width
    this.BranchWidth = PApplet.parseInt( this.BranchWidth / this.SplitBy );
    
    //  LOOP THROUGH OLD KIDS
    for( PVector pv : this.KIDS ) {
      
      //  TRANSITION FROM OLD SIZE TO NEW B4 THE NEW KIDS GET DRAWN
      strokeWeight( 1 );

      for( int sz = oldSz; sz > this.BranchWidth; sz -= 2 ) {
        //  TWO_PIck a new location for the next child
        tmpVector.x = random( pv.x+this.SplitBy, pv.x+this.BranchWidth/this.SplitBy );
        tmpVector.y = random( pv.y+this.SplitBy, pv.y+this.BranchWidth/this.SplitBy );

        stroke(0xffDADDAD, 100);
        fill(this.BranchWidth, 100);
        
        //  position filler in between the two points
        ellipse(  random( pv.x, tmpVector.x ), 
                  random( pv.y, tmpVector.y ), 
                  sz, sz );
      }
      
      //  MAKE NEW KIDS OUT OF THE OLD KIDS
      for( int ct = 0; ct < this.SplitBy; ct++){

        //  TWO_PIck a new location for the next child
        tmpVector.x = random( pv.x+this.SplitBy, pv.x+this.BranchWidth/this.SplitBy );
        tmpVector.y = random( pv.y+this.SplitBy, pv.y+this.BranchWidth/this.SplitBy );
        
        stepKIDS.add( new PVector(  tmpVector.x, 
                                    tmpVector.y ) );

      }
      //  END MAKE KIDS
    }
    //  END LOOP OLD KIDS
    
    //  YOU'VE GOT NEW KIDS!
    this.KIDS.clear();
    this.KIDS = stepKIDS;
    
    //  clean up some memory ?
//    stepKIDS.clear();
  }


}



/***********************************************************************/
/***********************************************************************/
/***********************************************************************/
/***********************************************************************/
  public void settings() {  size(1024,768);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Branched" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
