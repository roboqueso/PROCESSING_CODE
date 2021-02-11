//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);


Boolean isFinal = true;
int alf = 42; //37;

color[] p2 = { #D0FFFF, #D0F0FF, #C0F0FF, #C0F0F0, #B0F0F0, #B0E0F0, #A0E0E0, #A0E0F0, #90D0E0, #90E0F0, #D0F0F0, #B0E0E0, #90E0E0, #80D0E0, #70C0D0, #60C0D0, #70D0D0, #80D0D0, #B0F0E0, #A0E0D0, #90E0D0, #80C0D0, #60A0B0, #406070, #203050, #102050, #102040, #204050, #205060, #204060, #103050, #102060, #103060, #103070, #203080, #204080, #205090, #207090, #3080A0, #4090B0, #40A0B0, #30A0C0, #40B0C0, #50B0D0, #30A0B0, #3090A0, #203070, #3070A0, #206090, #204090, #90C0D0, #90D0D0, #70B0B0, #508080, #3090B0, #40A0C0, #2080A0, #306090, #B0E0D0, #C0F0E0, #50B0C0, #60B0C0, #70A0A0, #205080, #307090, #2070A0, #305090, #60A0A0, #A0D0D0, #40A0D0, #50A0C0, #80C0C0, #509090, #305060, #4080A0, #5090A0, #90C0C0, #3090C0, #3080B0, #70A0B0, #507080, #204070, #4090A0, #407090, #80B0B0, #B0D0D0, #E0FFFF, #60B0D0, #2080B0, #60C0C0, #80B0C0, #608090, #206080, #308090, #6090B0, #A0C0C0, #5070A0, #70C0C0, #609090, #203060, #205070, #406090, #80A0B0, #70B0C0, #60B0B0, #407070, #102030, #306080, #6090A0, #5090B0, #50A0B0, #306070, #203040, #2090A0, #90B0C0, #70D0E0, #103040, #305080, #A0C0D0, #407080, #408090, #5080A0, #104060, #305070, #104070, #80D0C0, #307080, #208090, #60A0C0, #A0D0E0, #104050, #508090, #207080, #C0E0F0, #D0FFF0, #206070, #50C0D0, #50A0D0, #80E0E0, #F0FFFF, #406080, #50B0B0, #B0D0E0, #E0F0FF, #70B0D0, #4090C0, #2070B0, #2060A0, #105070, #507090, #C0E0E0, #304060, #40B0D0, #306060, #E0FFF0, #408080, #D0F0E0, #304050, #409090, #50A0A0, #7090A0, #305050, #60D0D0, #405070, #4080B0, #405060, #205050, #40B0B0, #90D0C0, #40A0A0, #50C0E0, #60D0E0, #90B0B0, #6080A0, #307070, #80A0A0, #60C0E0, #70C0E0, #709090, #50D0E0, #3060A0, #A0F0F0, #4070A0, #40C0D0, #7090B0, #5080B0 }; 


float angle, radius = TWO_PI, x, y, cX, cY;

//  controls at which angle % == 0 starts and stops the noise
int flipStart = 180, flipEnd = 360;
Boolean flip = false;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);  //  P2D, P3D, OPENGL, PDF
  background(alf);  //  #ABCDEF
  fix.alpha(alf);

  cX = width/2;
  cY = height/2;

  noFill();

}



////////////////////////////////////////////////////
//
void draw()
{

    smooth();
    angle = frameCount;
 
    if( angle % 333 == 0 ) {
        flip = true;
    }
    if( angle % 345 == 0 ) {
        flip = false;
    }
 

    if( flip ) {
        x = cX - int( cos(radians(angle)) * random(radius, radius*noise(radius)) );
        y = cY - int( sin(radians(angle)) * random(radius, radius*noise(radius)) );

        // fill( random(255), 75, 75);
        //stroke( random(255), random(255), random(75) );
        fix.ranPalFill(p2);
        fix.ranPalStroke100(p2);
        strokeWeight(random(TWO_PI));


    } else {
        x = cX - int( cos(radians(angle)) * radius );
        y = cY - int( sin(radians(angle)) * radius );

        fill(random(75));
        stroke(random(37));

        strokeWeight(random(2));
    }
 

    if( frameCount % 360 == 0 ) {
        radius += 14;
        fix.ranPalStroke100(p2);
        fix.ranPalFill100(p2);
    }

    if(flip)
    {
      // fix.drawLissajous( x, y, 11*noise(angle) );
      fix.circle(x, y, 11*noise(angle), 11*noise(angle) );
      // ellipse(x, y, 11*noise(angle), 11*noise(angle) );
    } 
    else 
    {
      ellipse( x, y, TWO_PI, TWO_PI );      
    }


 
 



  if( angle > (height+width)*7 )
  {
      doExit();
  }
}




///////////////////////////////////////////////////////////
//  End handler, saves png
void doExit() 
{


	// artDaily("ERICFICKES.COM" );
	artDaily( "ERICFICKES.COM" );

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  }


  noLoop();
  exit();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  // textFont( createFont( "Silom", 18 ) );
  // smooth();

  fill(255);
  text( " "+dailyMsg, 11, height-11 );
}

