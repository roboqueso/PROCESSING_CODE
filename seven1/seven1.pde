int xx = 1, yy = 1, sz = 7;
/*
2D Primitives
arc()
ellipse()
line()    
point()
quad()
rect()
triangle()
*/
//////////////////////////////////////////////////////////////
void setup()
{
  size( 777, 777 );
  background( #777777 );
  stroke(#123100);
  noFill();
}

//////////////////////////////////////////////////////////////
void draw(){

  
  stroke(random(7,245));
  
  ellipse( xx, yy, sz, sz );

  // TODO: rect(a, b, c, d, tl, tr, br, bl)
  rect(yy, xx, sz, sz);
  
  //line(xx, sz, yy, sz );
  
  point(xx, yy);
  
  if(frameCount % 7 == 0 ){
    //  quad(x1, y1, x2, y2, x3, y3, x4, y4)
    //quad(xx, yy, sz, yy, xx, sz, yy, sz);

    arc(xx, yy, yy-sz, xx-sz , random(PI, TWO_PI), TWO_PI+QUARTER_PI, CHORD);
    
    strokeWeight(.7);
    triangle(random(xx), random(yy), (width/2)*noise(frameCount), (height/2)*noise(frameCount), yy*7, xx*7);
  }
 
  
  xx+=sz;
  if( xx >= width){
    xx = 0;
    // rando Y when X wraps
    yy += sz*random(1,7) % height;
    
    strokeWeight(random(HALF_PI, TWO_PI));
  }
  
  //  stopper
  if(frameCount>=width*7)
  {
    save(this+".png");
    exit();
  }
}