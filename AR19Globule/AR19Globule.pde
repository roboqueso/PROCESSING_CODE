//  SEE:   https://ello.co/ericfickes/post/erj73rc81gqs0mdhqatk9q
//  GOTO:  https://github.com/ericfickes/FIXLIB 
import nervoussystem.obj.*;
import fixlib.*;

/*
Make "SPHERE" based OBJ shapes
- Birds eye view looks eyeball-ish
*/

Fixlib fix = Fixlib.init(this);

float cX, cY;
PShape nshp;

////////////////////////////////////////////////////
//
void setup() {
  // size to match image
  size(900,900, P3D);

  //  -------------------------------------------
  smooth();
  noFill();

  cX = int( this.width / 2 );
  cY = int( this.height / 2 );
  
  strokeWeight(TWO_PI);

}


////////////////////////////////////////////////////
//
void draw()
{
    // sphereDetail(24);
    PShape sp = createShape( SPHERE, width );

  OBJExport obj = (OBJExport) createGraphics( width, height, "nervoussystem.obj.OBJExport", fix.pdeName()+this+".obj");
  obj.beginDraw();

    obj.translate(cX, cY);
    obj.beginShape(TRIANGLE_FAN);
    obj.stroke(0);
    obj.noFill();
    obj.setColor(false);
    
    for( int pp = 0; pp < sp.getVertexCount()-1; pp++ ){

        PVector vv = sp.getVertex(pp);
        
        if(pp%2==0){
            obj.vertex( vv.x, vv.y, vv.z );
            obj.vertex( vv.x, vv.y+pp, vv.z );
            obj.vertex( vv.x, vv.y-pp, vv.z );
            
            obj.vertex( vv.x, -vv.y+pp, vv.z );
            obj.vertex( vv.x, -vv.y-pp, vv.z );
        }

    }

    obj.endShape(CLOSE);


    obj.endDraw();
    obj.dispose();



    // save(this+".png");
    exit();

 
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
//  Draw manual circle
//  OVERRIDE : @modAngle - restrict drawing to angle % @modAngle
void dotCircle( float startX, float startY, float w, float h, float modAngle ) {

  float angle = 0;
  float xx, yy;

  while ( angle < 360 ) {

    // make circle draw faster by skipping angles
    if( angle % modAngle == 0 ) {

      xx = startX - int( cos(radians(angle)) * w );
      yy = startY - int( sin(radians(angle)) * w );
  
      smooth();
      point( xx, yy );
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
void doExit() 
{
  
  artDaily("ERICFICKES.COM");

  save( fix.pdeName() + fix.getTimestamp() + ".png" );
  

  super.stop();
}





///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  PFont font = createFont( "Silom", 18 );

  smooth();
  textFont( font );
  strokeWeight(1);

//  fill( #000000 , 666 );
  fill(#EFEFEF );
  text( " "+dailyMsg, this.width-225, this.height-15);
  
//  fill( #003600 , 666 );
  fill(0 );
  text( " "+dailyMsg, this.width-226, this.height-16);
}


///////////////////////////////////////////////////////////
//  draws circle from supplied x, y
void drawCore( int XX, int YY, int maxSize ) {

  float r = 1;  // 75;
  float theta = 2;

  int alf = 10;
  float x;
  float y;

  smooth();
  strokeWeight(.13);

  while ( theta <= maxSize )
  {    
    x = (PI*r) * cos(theta);
    y = (PI*r) * sin(theta);

    if (x%2==0)stroke(255, alf);
    else if (x%3==0) stroke(255, 0, 0, alf);
    else stroke( 109, 109, 109, alf);

    ellipse( int(XX+x), int(YY+y), x, x );

    heart( int(YY+y), int(XX+x), int(y), int(y) );

    theta+= 0.25;

    if ( frameCount%2==0) {
      r++;
      theta+=.5;
    }
  }
}




///////////////////////////////////////////////////////////
//  
//  draw heart
void heart( int x, int y, int w, int h ) 
{
  ellipseMode(RADIUS);
  smooth();

  //  stroke(#EF7519, alf);  // 37
  stroke(#EF1111);  // 37

  strokeWeight(2);
  //  noFill();

  //  bubbles
  ellipse( x-w, y, w, w);
  ellipse( x+w, y, w, w);
  //  ellipseMode(MODE)
  //  MODE  Either CENTER, RADIUS, CORNER, or CORNERS


  //  lines 
  line( x-(w*2), y, x, y + w*PI);
  line( x+(w*2), y, x, y + w*PI);
}
