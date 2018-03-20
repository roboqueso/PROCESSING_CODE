/*
inspiration from http://paulbourke.net/geometry/supershape/
*/

PShape can;
float angle;
PShader colorShader;

void setup() {
  
  size(1024, 768, P3D);
  rectMode(CENTER);
  
  strokeWeight(PI);
}

int numPts = 40;
int x, y;
float m, n1, n2, n3, phi;

PVector tmp;



void draw() {    
  
  beginShape();
    
    for (int i=0; i <= numPts; i++) {
        phi = i * TWO_PI / numPts;
        
        tmp = Eval( numPts, 2, 1.7, 1.7, phi );
        
        vertex( tmp.x, tmp.y, tmp.z );
        
println( tmp );
     }

  endShape();
  
  noLoop();
  
  /*
  pushMatrix();
    
    translate((width/2), (height/2), frameCount );
    rotate(frameCount);
    //fill(frameCount%255, 50);
    noFill();
    stroke(frameCount%255, 100);
    rect( 0,0, (frameCount%(width/2)) , (frameCount % ( height/2) ), -frameCount%-8 );
    
  popMatrix();
  */
}


PVector sf2d(n, a)
  
  u = [0:.001:2 * pi];
  
  raux = abs(1 / a(1) .* abs(cos(n(1) * u / 4))) .^ n(3) + abs(1 / a(2) .* abs(sin(n(1) * u / 4))) .^ n(4);
  
  r = abs(raux) .^ (- 1 / n(2));
  
  x = r .* cos(u);
  
  y = r .* sin(u);

  return new PVector(x, y);
end