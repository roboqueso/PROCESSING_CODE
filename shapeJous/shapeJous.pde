int cX;
int cY;

float x,y, t;

//color[] p1 = { #FEFEFC,#89776E,#ECE9E8,#AA9991,#322D2B,#DBD7D8,#D2C7BA,#B2A699,#CAC7C7,#D8CDC9,#BAB6B7,#C9BDB9,#918678,#E9DED9,#EEE7DD,#AAA6A7,#B8ACA8,#999596,#DFDC6A,#888584,#787574,#6A6456,#665854,#4D4337,#686564,#575453,#978B87,#F7EFEA,#474443,#DCD6CC,#423833,#766A65,#C8B5AE,#F8F7F3,#554946,#BBB6AA,#C6B192,#E8D6CF,#787368,#9A9489,#A98A79,#CEA070,#565348,#F8F785,#DDDEE1,#D2CB92,#BBBDC1,#B4AE73,#CDCED2,#100B0B,#E7D0B5,#ABADB1,#9B9CA0,#EEEFF1,#C7BDC6,#EFEEB6,#8F8754,#BDC6CB,#DEE7EA,#B3AE52,#8B8C8F,#C7ACA6,#9BA5AA,#A79C9E,#CED6DB,#D7CED6,#7A7B7E,#29211F,#7A8589,#D4BBAB,#B6ADB6,#D7BDB7,#595A5D,#ADB5BA,#958C95,#6A6B6E,#867B7D,#211715,#C49789,#EFF7F8,#494A4D,#8B9499,#645A63,#E7DEE7,#7F8474,#746B74,#E9B48E,#5A6467,#596357,#E8CDC7,#443942,#6A7476,#E4D897,#534A52,#6A7369,#8F5544,#37363A,#F8DBC9,#BF785E,#EABDA7,#C4C6B0,#4A5248,#394245,#A2A03F,#A2985A,#4A5355,#E0E7D3,#A4A59A,#8B948A,#F7EFF7,#ACB5A8,#414239,#FBE2DA,#211821,#CED6CA,#7E3827,#D9AB9D,#EFF7EE,#212223,#C26642,#C7C468,#CAABBA,#18181B,#D0CA4A,#E39E80,#182117,#E6E588,#A2A075 };
float angle = 0;
float xx, yy, startX, startY;
float w = 33;


void keyPressed(){

  if( keyCode == ESC ){
  
    save(this+".png");
    noLoop();
    super.exit();
  }
}


//////////////////////////////////////////////////////
//  TODO: optimize this
void drawLissajous( float a, float b, float amp )
{
  float x, y;
 
  for ( float t = 0; t <= 360; t+=.2)  //t+=.2 )
  {
    x = a - amp * sin(a * t * PI/180);
    y = b - amp * sin(b * t * PI/180);

    point(x, y);

  }

}


//////////////////////////////////////////////////////
//  Lissajous PShape maker
PShape shapeJous( float a, float b, float amp )
{
  
  PShape shp = createShape();
  shp.beginShape();

  float x, y;


//  TODO: build a P5 GIF maker that runs this shapeJous and increments the T+ value by .5
//  record frames and animate, include spitting out of T value so you know 
  for ( float t = 0; t <= 360; t+=12)
  {
    x = a - amp * sin(a * t * PI/180);
    y = b - amp * sin(b * t * PI/180);

    shp.vertex(x, y);
  }
  shp.endShape();
  return shp;
}




  float orbitRadius;
  float ypos;
  float xpos;
  float zpos;


////////////////////////////////////////////////////////////
void setup() {

    size(666,666,P3D);
    noFill(); 
    smooth();
    
    //  setup variables
    cX = width/2;
    cY = height/2;
    startX = cX;
    startY = cY;
    xx = yy = -(w/2);
}



void draw() {



  translate(xx, yy, 11);
  shape( shapeJous( xx, yy, 21 ) );
   
  if( yy > height ) {
    exit();
  }
  
  t++;

  if( xx > width ) {
    xx = -(w/2);
    yy += w;
  } else {
    xx += w; 
  }

  
  
  
  
}