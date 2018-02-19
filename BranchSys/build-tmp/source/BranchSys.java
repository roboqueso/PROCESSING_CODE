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

public class BranchSys extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);

//  NO COLOR UNTIL SYSTEM IS FULLY BAKED
//  JUST BLACK POINTS !!!!!!!!!!!!!!!!!!
//  
//  http://en.wikipedia.org/wiki/Branch-decomposition
//  
Boolean isFinal = true;
public Branch br;


//////////////////////////////////////////////////////////////////////////
public void setup(){
  
  background( 0xffEFEFEF );
  br = new Branch( 999, 2);
  
}

//////////////////////////////////////////////////////////////////////////
public void draw(){
  
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

      textFont( createFont( "Georgia", random(PApplet.parseInt(br.BranchWidth), 42 ) ) );
      text(br.KIDS.size() + "/"+ br.BranchWidth, br.KIDS.size(), random(height) );
    }

    //  STOPPER when ANY kid hits < 0
    if( br.BranchWidth < 0.420f ){
      
  for( PVector thisPV : br.KIDS ) {
    line( thisPV.x, thisPV.y, thisPV.x, 0 );
  }      
      
      
      
      
      fill(0xffEF2012);
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
public void drawSys( PVector pv ) {
  
  switch( PApplet.parseInt( random(1) ) ) {
    case 0:{

      point( pv.x, pv.y ); 

    } 
    break;
  }
  
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
    this.BranchWidth = PApplet.parseInt( this.BranchWidth / this.SplitBy );

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
  public void settings() {  size(1024,768);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "BranchSys" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
