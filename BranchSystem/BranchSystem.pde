//  SEE:   https://ello.co/ericfickes/post/nyrup3m_qwdsfiphjla4fw
//  GOTO:  https://github.com/ericfickes/FIXLIB

import fixlib.*;
Fixlib fix = Fixlib.init(this);

//  NO COLOR UNTIL SYSTEM IS FULLY BAKED
//  JUST BLACK POINTS !!!!!!!!!!!!!!!!!!
//  
//  http://en.wikipedia.org/wiki/Branch-decomposition
//  

public Boolean isFinal = true;
public Branch br;


void settings() {
  size(displayWidth, displayHeight);
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}

void setup() {
  frameRate(666);
  background(#EF2020);
  br = new Branch( 1024, 3);
  smooth();
  noFill();
  ellipseMode(CENTER);
  rectMode(CENTER);
}


//////////////////////////////////////////////////////////////////////////
void draw() {

  //  draw all kids
  for ( PVector thisPV : br.KIDS ) {

    moveSys( thisPV );

    strokeWeight( br.BranchWidth );
    stroke( random(br.BranchWidth), 100);

    drawSys( thisPV );
  }

  //  random growing
  if ( frameCount % int(random(42, 227)) == 0 ) {
    br.Split();

    textFont( createFont( "Georgia", random(int(br.BranchWidth), 42 ) ) );
    text(br.KIDS.size() + "/"+ br.BranchWidth, br.KIDS.size(), random(height) );
  }

  //  STOPPER when ANY kid hits < 0
  if ( br.BranchWidth < 1 ) {

    for ( PVector thisPV : br.KIDS ) {
      stroke( random(255), 42 );
      line( thisPV.x, thisPV.y, thisPV.x, 0 );
    }      

    fill(#efefef);
    textFont(createFont("Silom", 11));
    text("ERICFICKES.COM", 11, height-11 );
    if (isFinal) {
      save( fix.pdeName() + fix.getTimestamp() + ".png" );  //  TIFS then PNGS
      save( fix.pdeName() + fix.getTimestamp() + ".tif" );  //  TIFS then PNGS
    }
    noLoop();
    exit();
  }
}


//////////////////////////////////////////////////////////////////////////
//  update the X and Y of supplied PVector
void moveSys( PVector pv ) {

  noiseDetail( frameCount/10);

  switch( int( random(1) ) ) {
  case 0:
    {
      //  GROW!      
      if ( pv.y > 0 ) {
        pv.y -= random( br.SplitBy-PI, br.SplitBy+PI);
        pv.x += random(-br.SplitBy-PI, br.SplitBy+PI);
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
  case 0:
    {

      strokeWeight( 1 );
      stroke(random(200, 255), 100);
      fill( br.BranchWidth*br.SplitBy, 100);
      ellipse( pv.x, pv.y, br.BranchWidth, br.BranchWidth );
      noFill();

      strokeWeight( br.BranchWidth );
      stroke( random(br.BranchWidth), 100);
      point( pv.x, pv.y );
    } 
    break;
  }
}

/***********************************************************************/

public class Branch {

  public int BranchWidth;
  public int SplitBy;
  public ArrayList<PVector> KIDS;
  private ArrayList<PVector> stepKIDS;

  ///////////////////////////////////////////////////////////  
  Branch( int bWidth, int splitBy) {

    this.BranchWidth = bWidth;
    this.SplitBy = splitBy;

    KIDS = new ArrayList<PVector>();
    KIDS.add( new PVector(0, 0) );
  }

  //  Use @SplitBy ///////////////////////////////////////////////////////////
  //  - Adjust BranchWidth
  //  - return new list of kids
  public void Split() {

    int oldSz = br.BranchWidth;

    // debug
    text( br.BranchWidth, random(width), height-42 );


    int pX, pY;  // parent X & Y , split point
    stepKIDS = new ArrayList<PVector>();  // growing and growing

    //  shrink width
    br.BranchWidth = int( br.BranchWidth / this.SplitBy );

    //  grow kids    
    //  LOOP THROUGH OLD KIDS
    for ( PVector pv : this.KIDS ) {

      //  TRANSITION FROM OLD SIZE TO NEW B4 THE NEW KIDS GET DRAWN
      strokeWeight( 1 );
      for ( int sz = oldSz; sz > br.BranchWidth; sz -= 2 ) {

        stroke(#DADDAD, 100);
        fill(br.BranchWidth, 100);
        ellipse(  pv.x + random( br.SplitBy ), 
          pv.y, 
          sz, sz );

        //        rect(  pv.x + random( br.SplitBy ), 
        //                  pv.y, 
        //                  sz, sz, random(br.BranchWidth) );
      }

      //  MAKE NEW KIDS OUT OF THE OLD KIDS
      for ( int ct = 0; ct < this.SplitBy; ct++) {

        stepKIDS.add( new PVector(  pv.x + random( br.BranchWidth ), 
          pv.y - br.SplitBy ) );
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
