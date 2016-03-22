float cX, cY, xx, yy, xx2, yy2, rad,angle, angle2, sw = 12;


Boolean dec = false;

int decStop = 0, decAmt = 12;

void setup()
{
  size(1280, 960);//, P3D );
  background(255);

  smooth();
  frameRate(666);
  cX = width/2;
  cY = height/2;
  rad = 666;

  noFill();
}


void draw()
{
    textAlign(CENTER,CENTER);
    textFont( createFont("Slaytanic", 666 ));
    
    textSize(555);
    fill(0);
    text("LASERS", cX, cY );

    textSize(550);
    fill(100);
    text("LASERS", cX, cY );


    textSize(545);
    fill(150);
    text("LASERS", cX, cY );

    textSize(540);
    fill(0);
    text("LASERS", cX-1, cY-1 );

    fill(255);
    text("LASERS", cX, cY );

    save(this+".png");

    noLoop();
  
  noLoop();
}
