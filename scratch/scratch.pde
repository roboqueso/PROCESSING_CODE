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


PVector Eval(float m, float n1, float n2, float n3, float phi )
{
   float r;
   float t1,t2;
   float a=1,b=1;
   float x=0, y=0;

   t1 = cos(m * phi / 4) / a;
   t1 = abs(t1);
   t1 = pow(t1,n2);

   t2 = sin(m * phi / 4) / b;
   t2 = abs(t2);
   t2 = pow(t2,n3);

   r = pow(t1+t2,1/n1);
   
   if (abs(r) == 0) {
      x = 0;
      y = 0;
   } else {
      r = (1 / r) * 10;
      x = r * cos(phi) * 10;
      y = r * sin(phi) * 10;
   }

   // make positive
   if(x<0) x = -x;
   if(y<0) y = -y;
   //if(r<0) r = -r;

  return new PVector( round(x), round(y), round(r) );
}