/*
original source from : https://www.reddit.com/r/processing/comments/5aep4x/autostereogram_generator_implementation_remember/

*/

float[][] heightMap;
PImage img;
boolean mode = true;
int r = 18;

void setup(){
  size( displayWidth, displayHeight, P2D );
  smooth();
  
  heightMap = new float[width][height];
  for(int i = 0; i < width; i++) for(int j = 0; j < height; j++) heightMap[i][j] = color(0);

img = loadImage("three.png");
heightMap = heightmap_from_image( img );

  /* cone heightmap */
  for(int i = 0; i < width; i++){
    for(int j = 0; j < height; j++){
      heightMap[i][j] = map( dist( i, j, 400, 300 ), 0, 500, 1, 0 );
    }
  }

}
void draw(){
  if( mode ){
    loadPixels();
    for(int i = 0; i < width; i++){
      for(int j = 0; j < height; j++){
        pixels[(width*j)+i] = color( heightMap[i][j] * 255.0 );
      }
    }
    updatePixels();
  }
  else{
    image( drawAutoStereogram( heightMap ), 0, 0 );
    save(this+".png");
    noLoop();
  }
}

void mouseDragged(){
  float k = 1;
  if( mouseButton == RIGHT ) k = -1;

  for(int i = constrain( mouseX-r, 0, width-1 ); i < mouseX+r; i = constrain( i+1, 0, width-1 )){
    for(int j = constrain( mouseY-r, 0, height-1 ); j < mouseY+r; j = constrain( j+1, 0, height-1 )){
      float d = dist( i, j, mouseX, mouseY );
      float q = ( d < r )?  1 : 0; // (sqrt(2*sq(r)) / d)
      heightMap[i][j] = constrain( heightMap[i][j] + (k * q * 255), 0, 1);
    }
  }
}

void keyPressed(){
  if( key == ' ' ){
    mode = !mode;
    loop();
  }
  if( key == 'c' ) for(int i = 0; i < width; i++) for(int j = 0; j < height; j++) heightMap[i][j] = color(0);
  if( key == 'p' || key == 'P' )save(this+".png");
}

PGraphics drawAutoStereogram( float[][] Z ){
  PGraphics a;
  a = createGraphics( Z.length, Z[0].length );
  a.beginDraw();
  a.loadPixels();
  int E = 258; //eye separation (66mm) * DPI;
  float mu = 1/3f;

  for( int y = 0; y < a.height; y++){
    color pix[] = new int[a.width];
    color same[] = new int[a.width]; //points to a pixel to the right that is constrianed to be this color
    int s; //stereo separation;
    int left, right; // X-values corresponding to the left and right eyes
    for( int x = 0; x < a.width; x++) same[x] = x; // Each pixel is initially linked with itself

    for( int x = 0; x < a.width; x++){
      s = separation(Z[x][y], mu, E);
      left = x - (s+(s&y&1))/2; //pixels left and right must be the same...
      right = left + s;
      if( left >= 0 && right < a.width ){
        boolean visible;//First, perform hidden-surface removal
        int t = 1; // we will check the points (x-t, y) and (x+t, y)
        float zt; // Z-coord of ray at these two points
        do{
          zt = Z[x][y] + 2 * (2 - mu * Z[x][y]) * t / ( mu * E );
          visible = (Z[x-t][y] < zt && Z[x+t][y] < zt); //false if obscured
          t++;
        }
        while( visible && zt < 1 ); //Done hidden-surface removal...

        if( visible ){ //... so record the fact that pixels atleft and right are the same
          for( int k = same[left]; k != left && k!= right; k = same[left] ){
            if(k < right ) left = k;  //but first, juggle the points...
            else{                     //...until either same[left] =  left
              left = right;           //... or same[right] = left
              right = k;
            }
          }
          same[left] = right; //this is where we actually record it
        }
      }
    }
    for( int x = a.width - 1; x >= 0; x-- ){ //now set the mixels on this scan line
      if( same[x] == x ) pix[x] = (random(10) > 5 )? color(255) : color(0);
      else pix[x] = pix[same[x]];
      a.pixels[(a.width * y ) + x] = pix[x];
    }
  }
  a.updatePixels();
  a.endDraw();
  return a;
}

int separation( float z, float mu, float E ){
 return round( (1 - mu * z) * E / ( 2 - mu * z) );
}

float[][] heightmap_from_image( PImage pic ){
  float[][] h = new float[width][height];
  for(int i = 0; i < width; i++) for(int j = 0; j < height; j++) h[i][j] = color(0);

  if( pic.width > width ) pic.resize( width, pic.height * ( width / pic.width ) );
  if( pic.height > height ) pic.resize( pic.width * ( height / pic.height ), height );
  pic.loadPixels();

  int transX = round( (width - pic.width )/2.0 );
  int transY = round( (height - pic.height )/2.0 );
  for(int i = 0; i < pic.width; i++){
    for(int j = 0; j < pic.height; j++){
      h[i+transX][j+transY] = brightness( pic.pixels[(pic.width*j)+i] ) / 255.0;
    }
  }
  return h;
}