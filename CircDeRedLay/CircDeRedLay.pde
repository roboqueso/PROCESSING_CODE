
/////////////////////////////////////

Boolean isFinal = true;
int alf = 11;
float cX, cY, eX, eY, i;

void setup() {
    background(#000011);
    size(1024, 768);
  frameRate(303); 
    smooth();
    noFill();
    ellipseMode(CENTER);
    rectMode(CENTER);
    
    cX = width/2;
    cY = height/2;
} 

void draw() {  // this is run repeatedly.  


    eX = cX *cos(frameCount)*radians(cX); 
    eY = cY *sin(frameCount)*radians(cY);


    stroke(random(255), alf);
    systems(eX, eY);
    stroke(random(11,42), alf);
    systems(eY, eX);
    
    stroke(0,0,random(alf),alf);
    systems(cX+i, cY+i);
    
    stroke(random(alf),0,0,alf);
    systems(cX-i, cY-i);

    // move over a pixel
    if (i < width/2) {
        i+=1;
    } else {
        i = 0; 
    }
    

  if( frameCount > height+width )
    {
        exit();
    }
}





///////////////////////////////////////////////////////////////////
//    Create a SWITCH based drawing system that accepts X, Y, and
//    randomly choose which movement system to fire
void systems( float x, float y )
{
    int pick;

    //  which system is going to be run?
    pick = floor(random(16));

//println(pick);


    switch( pick ){
        
        case 0:
        {
            x = floor( (width/2)+cos(radians(frameCount))*(x-y) );
            y = floor( (height/2)+sin(radians(frameCount))*(y-x) );
            point( x-PI, y+PI );
        }
        break;
        
        case 1:
        {
            rect( x*cos(frameCount)*radians(TWO_PI), y*sin(frameCount)*radians(TWO_PI), x, x );
        }
        break;
        
        case 2:
        {
            rect( x, y, TWO_PI+x*noise(frameCount), TWO_PI+x*noise(frameCount) );
        }
        break;
        
        case 3:
        {
            rect( y * cos(x)*frameCount, x*sin(y)*frameCount, frameCount, frameCount );
        }
        break;

        case 4:
        {
          bezier( x, y, x * cos(x)*frameCount, y*sin(y)*frameCount, frameCount, frameCount, y * cos(x)*frameCount, x*sin(y)*frameCount, frameCount, frameCount, y, x );
        }
        break;
        
        case 5:
        {
            ellipse( x*cos(frameCount)*radians(TWO_PI), y*sin(frameCount)*radians(TWO_PI), y, y );
        }
        break;
        
        case 6 :
        {
          x = random(x);
          y = random(y);

          stroke(#EF2012,75);
          strokeWeight(2);
          drawLissajous( x, y, random(frameCount/TWO_PI) );
          stroke(#000011,100);
          strokeWeight(1);
          drawLissajous( x, y, random(frameCount/TWO_PI) );
        }
        break;

        case 7:
        {
          circle( x, y, x, x );
        }
        break;
        
        case 8:
          hexagon( x, y, 42 );
        break;
        
        case 9:
          circle( x, y, x, y, 11 );
        break;
        
        case 10:
          radialLine(y, x, x, y);
        break;
        
        case 11:
          curve( x, y, x * cos(x)*frameCount, y*sin(y)*frameCount, y * cos(x)*frameCount, x*sin(y)*frameCount, y, x );            
        break;
        
        case 12 : {
          strokeWeight(random(TWO_PI,22));
          stroke(random(frameCount*noise(frameCount)) );
      
          point( i *cos(frameCount)*radians(i), i *sin(frameCount)*radians(i) );
          point( width-i*cos(frameCount)*radians(i),  i *sin(frameCount)*radians(i) );
          point( i*cos(frameCount)*radians(i),  height-i *sin(frameCount)*radians(i) );
          point( width-i*cos(frameCount)*radians(i),  height-i *sin(frameCount)*radians(i) );
          point( (width/2)-i*cos(frameCount)*radians(i),  (height/2)-i *sin(frameCount)*radians(i) );
        }
        break;
        
        case 13 : 
          {
            strokeWeight(random(.37, .99));
            stroke(random(227,255),alf);
          
            line( eX, eY, i *cos(frameCount)*radians(i), i *sin(frameCount)*radians(i) );
            line( eX, eY,width-i*cos(frameCount)*radians(i),  i *sin(frameCount)*radians(i) );
            line( eX, eY,i*cos(frameCount)*radians(i),  height-i *sin(frameCount)*radians(i) );
            line( eX, eY,width-i*cos(frameCount)*radians(i),  height-i *sin(frameCount)*radians(i) );
            line( eX, eY, cX-i*cos(frameCount)*radians(i),  cY-i *sin(frameCount)*radians(i) );
          }
          break;
          
          case 14:
          {
            strokeWeight(1);
            stroke(#EFEFEF,alf);
            rect(eX,eY, frameCount*noise(frameCount), frameCount*noise(frameCount));
          }
          break;
          
          case 15: 
          {
            stroke(random(alf), alf*2);
            bezier( eX, eY, width-eX, height-eY, eY, eX, width-eY, height-cX );
            bezier( eY, eX, height-eY, width-eX, eX, eY, height-cX, width-eY );
          }
          
          case 16:
          {
            stroke(random(alf), alf*2);
            curve( eX, eY, width-eX, height-eY, eY, eX, width-eY, height-cX );
            curve( eY, eX, height-eY, width-eX, eX, eY, height-cX, width-eY );
          }
        break;

        default:
        {
          text(pick + " NOT IMPLEMENTED", x, y);
        }
        break;
    }
}

void radialLine(float r1, float a1, float r2, float a2){
    
    float x1 = width/2  + cos(a1)*r1;
    float y1 = height/2 + sin(a1)*r1;
    float x2 = width/2  + cos(a2)*r2;
    float y2 = height/2 + sin(a2)*r2;
    
    line(x1, y1, x2, y2);
//    fill(255);
noFill();
    ellipse(x1,y1, TWO_PI, TWO_PI);
    ellipse(x2,y2, TWO_PI, TWO_PI);
    
    //println([r1,a1,r2,a2]);
}


//////////////////////////////////////////////////////
//  
void drawLissajous( float a, float b, float amp )
{
//  float amp = 33;
  float x, y;
  
  for( float t = 0; t <= 360; t += .1)
  {
    x = a - amp * sin(a * t * PI/180);
    y = b - amp * sin(b * t * PI/180);

    point(x,y);
    point(y,x);
  }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  pull colors out of image and return color[]
//  http://forum.processing.org/topic/extract-colors-from-images
ArrayList getImgColors( PImage img ) 
{
  ArrayList alColors = new ArrayList();
  
  img.loadPixels();
  
  int color1, color2;
  // TODO: what's a good way to pull DISTINCT colors with a color[]?
  for( int c = 0; c < img.pixels.length; c++ ) 
  {
      if( alColors.size() == 0 ) { 
        alColors.add( (color)img.pixels[ c ] );
      } else 
      {
         
        if( ! alColors.contains( (color)img.pixels[ c ] ) ) 
        {
          color1 = (Integer) alColors.get( alColors.size()-1 );
          color2 = img.pixels[c];
          // filter out colors    
//          if( color2 > color1 )
          if( color2 < color1 )
          {
        
            alColors.add( (color)img.pixels[ c ] );
        
          }
        }
      }

  }
  
  return alColors;

}


///////////////////////////////////////////////////////////
//  Helper to random(255) stroke
void randFill() {  
  fill( random(255), random(255), random(255), alf );
}
void randStroke() {  
  stroke( random(255), random(255), random(255), alf );
}
void randStroke100() {  
  stroke( random(255), random(255), random(255), 100 );
}

////////////////////////////////////////////////////
//  Randomly stroke using image from color list
void ranPalStroke(color[] palette)
{
  // pallete
  stroke( palette[ int(random( palette.length-1 )) ], alf );
}
void ranPalStroke(ArrayList palette)
{
  // pallete
  stroke( (Integer)palette.get( (int)random( palette.size()-1 ) ), alf );
}
void ranPalStroke100(color[] palette)
{
  // pallete
  stroke( palette[ int(random( palette.length-1 )) ], 100 );
}

void ranPalFill(color[] palette)
{
  fill( palette[ int(random( palette.length-1 )) ], alf );
}
void ranPalFill(ArrayList palette)
{
  // pallete
  fill( (Integer)palette.get( (int)random( palette.size()-1 ) ), alf );
}



//////////////////////////////////////////////////////////////////////////
//  Draw manual circle
void circle( float startX, float startY, float w, float h ) {

  float angle = 0;
  float xx, yy;
  noFill();
  
  while ( angle < 360 ) {

    // make circle draw faster by skipping angles
    if( angle % 3 == 0 ) {

    xx = startX - int( cos(radians(angle)) * w );
    yy = startY - int( sin(radians(angle)) * w );


    ellipse( xx, yy, w, h );
    }
    angle++;
  }
}

//////////////////////////////////////////////////////////////////////////
//  Draw manual circle
//  OVERRIDE : @modAngle - restrict drawing to angle % @modAngle
void circle( float startX, float startY, float w, float h, float modAngle ) {

  float angle = 0;
  float xx, yy;

  while ( angle < 360 ) {

    // make circle draw faster by skipping angles
    if( angle % modAngle == 0 ) {

      xx = startX - int( cos(radians(angle)) * w );
      yy = startY - int( sin(radians(angle)) * w );
  
      smooth();
      ellipse( xx, yy, w, h );
    }
    angle++;
  }
}

//////////////////////////////////////////////////////////////////////////
//  HEXAGON inspired by http://www.rdwarf.com/lerickson/hex/index.html
void hexagon( float startX, float startY, float shapeSize ) {

  line( startX, startY+(shapeSize*.5), startX+(shapeSize*.25), startY );
  line( startX+(shapeSize*.25), startY, startX+(shapeSize*.75), startY );
  line( startX+(shapeSize*.75), startY, startX+(shapeSize), startY+(shapeSize*.5) );

  line( startX+(shapeSize), startY+(shapeSize*.5), startX+(shapeSize*.75), startY+shapeSize );
  line( startX+(shapeSize*.75), startY+shapeSize, startX+(shapeSize*.25), startY+shapeSize );
  line( startX+(shapeSize*.25), startY+shapeSize, startX, startY+(shapeSize*.5) );
}


///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void exit() 
{

  //  artDaily("The difference between who you are and who you want to be is WHAT YOU DO");
  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
    save( pdeName() + "-" + getTimestamp()+".png" );
  }

  noLoop();
  System.gc();
  super.stop();
}

///////////////////////////////////////////////////////////
String getTimestamp() {
  return ""+month()+day()+year()+hour()+minute()+second()+millis();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?
String pdeName() {
  return split( this.toString(), "[")[0];
}

//////////////////////////
int f0 = 0;
int f1 = 1;
//int f2 = 1;

int nextFib( int f2)
{
  //   int result = f2;
  f0 = f1;
  f1 = f2;
  f2 = f0 + f1;

  return f0 + f1;
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 42 ) );
  smooth();
  
  fill(#20EF75);
  text( " "+dailyMsg, width-420, this.height-10);
  
  fill(0);
  text( " "+dailyMsg, width-421, this.height-9);
  
  fill(#EFEFEF);
  text( " "+dailyMsg, width-422, this.height-8);
}

