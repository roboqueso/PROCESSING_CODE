import geomerative.*;

RShape curSVG;
ArrayList<MyShape> ShapeList;

ArrayList imgList;
RShape img1, img2, img3, img4, img5, img6;


boolean record = false;
boolean paused = false;

float x, y, z;

color[]palette = {
  #0095A8, #00616F, #333333, #666666, #999999, #CCCCCC
};

int numAssets = 55;
int startX = 50;
int startY = 50;
int Xspacing = 50;
int Yspacing = 50;
int gridCols = 5;

void setup() {
  RG.init(this);
  size(900, 900);
  background(#ECECEC);
  //smooth();
frameRate(420);

  ShapeList = new ArrayList<MyShape>();

  //  LOAD 6 assets into imgList
  int ct = 1;
  imgList = new ArrayList();


  //  MANUAL FILLER UP

  imgList.add( RG.loadShape( "squareThing.svg" ) );

  for (int i=0; i<numAssets; i++) {
    int row = i / gridCols;
    int col = i % gridCols;

    x = startX + (col * Xspacing);
    y = startY + (row * Yspacing);

    ShapeList.add( new MyShape( x, y ) );
  }
}

void draw() {

//  if (record) {
//    beginRecord(PDF, "filename-####.pdf");
//  }
//
//  background(#ECECEC);
  for (MyShape p : ShapeList) {
    p.display();
  }

  if (record) {
    endRecord();
    record = false;
  }


  //  STOPPER
  if ( frameCount > 1975 ) {

    textFont( createFont( "American Typewriter", 111 ) );
    fill(#1975EF);
    text( "ERICFICKES.COM", 3, height-Yspacing );

    save( split( this.toString(), "[")[0] + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );

    noLoop();
  }
}





