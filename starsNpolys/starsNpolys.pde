public Boolean isFinal = true;
int dWidth, dHeight, r,g,b,opacity,nSides,cx,cy;
float xx, yy;

boolean isPolygon = true;
float proportion;

void setup()
{
  dWidth = 1024;
  dHeight = 768;

  size(1024, 768);
  background(42);

  smooth();
  rectMode(CENTER);


  cx = dWidth/2;
  cy = dHeight/2;
}




void draw()
{
  nSides = int(random(5, 55));

  proportion = random(0.2, 0.8) * cos(PI / frameCount);

  if(proportion<=0.21) {
    strokeWeight(PI);
    stroke(11);
  } else {
    strokeWeight(proportion);
    stroke(random(111), random(111), nSides+proportion, 100);
  }
  noFill();
  star(5, cx, cy, 11*cos(frameCount)*radians(-frameCount), proportion );
//  text(proportion, random(dWidth), random(dHeight) );
  //  }
  
  if( xx < dWidth ){
    xx += 11;
  } else {
    xx = 0;
    yy += 20*cos(frameCount)*radians(frameCount);
  }
  
  //  safety checker
  if( yy > height ){
    yy = random(yy);
  }
  
  
  if(frameCount>dWidth+dHeight){
  
  
      fill(11);
      textFont(createFont("Silom",23));
      
      //    TOP RIGHT CORNER-ISH ( between the time and the battery )
      text("ERICFICKES.COM", (dWidth/2)*1.2, 25 );  // 28

//      Bottom left corner
//      text("ERICFICKES.COM", -2, height-2 );

      if(isFinal){
        save( pdeName() + getTimestamp() + ".png" );
      }
      noLoop();
  }
}








//long getTimestamp() {
//  return new Date().getTime()/1000;
//}

String getTimestamp() {
  return month()+""+day()+""+year()+""+hour()+""+second()+""+millis();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?
String pdeName() {
  return split( this.toString(), "[")[0];
}


void polygon(int n, float cx, float cy, float r)
{
  float angle = 360.0 / n;

  beginShape();
  for (int i = 0; i < n; i++)
  {
    vertex(cx + r * cos(radians(angle * i)), 
    cy + r * sin(radians(angle * i)));
  }
  endShape(CLOSE);
}


void star(int n, float cx, float cy, float r, float proportion)
{
  star(n, cx, cy, 2.0 * r, 2.0 * r, 0.0, proportion);
}

void star(int n, float cx, float cy, float w, float h, 
float startAngle, float proportion)
{
  if (n > 2)
  {
    float angle = TWO_PI/ (2 *n);  // twice as many sides
    float dw; // draw width
    float dh; // draw height

    w = w / 2.0;
    h = h / 2.0;

//fill( random(255), n*r*proportion );

    beginShape();
    for (int i = 0; i < 2 * n; i++)
    {
      dw = w;
      dh = h;
      if (i % 2 == 1) // for odd vertices, use short radius
      {
        dw = w * proportion;
        dh = h * proportion;
      }
      vertex(cx + dw * cos(startAngle + angle * i), 
      cy + dh * sin(startAngle + angle * i));
    }
    endShape(CLOSE);
  }
}

