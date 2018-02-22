import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import fixlib.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class NewSystems extends PApplet {


// https://github.com/ericfickes/FIXLIB	


Fixlib fix = Fixlib.init(this);
Boolean isFinal = true;
public int x = 0, y = 0, alf = 21, gridSize = 2, colWidth, rowHeight, maxCt;
public int[] nums = { 37, 11, 2, 4, 13, 8 };


//////////////////////////////////////////////////////////////////////
public void setup() {  // this is run once.   
    background(0xff001100);
     
    
    fix.alpha(alf);
    colWidth = floor( width / gridSize );
    rowHeight = floor( height / gridSize );
     
    maxCt = width+height;
} 


//////////////////////////////////////////////////////////////////////
public void draw() {

    mSystem( x, y );

    strokeWeight( random(3) );
    stroke( random(alf), random(alf), random(alf), alf*PI );
    
    point( x, y );
    ellipse( x, y, alf, alf );
    
    ptSystem( y, x );
    
    
    //    STOPPER
    if( maxCt <= 0 ) {
        textFont( createFont("Silom", 21));
 
        fill(255);
        text("ERICFICKES.COM", 1, height-1 );

        fill(0xff001100);
        text("ERICFICKES.COM", 2, height-2 );

        if ( isFinal )
        {
          save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
        }
      
        noLoop();
        exit();
      }

    maxCt-=3;
}



//////////////////////////////////////////////////////////////////////
public void mSystem( float xx, float yy )
{
    switch( floor(random(8)) )
    {
        case 0:{
            if( xx < width )
            {
                x += colWidth;
            } else {
                x = 0;
                y += rowHeight;
            }
        }
        break;
        
        case 1:{
            if( yy < height )
            {
                y += rowHeight;
                x -= colWidth;
            } else {
                y = 0;
                x += colWidth;
            }
        }
        break;
        
        case 2:{
            x += colWidth;
            y = height-y;
        }
        break;
        
        case 3:{
            x -= colWidth+TWO_PI;
            y += rowHeight+TWO_PI;
        }
        break;
        
        case 4: {
            x += cos(frameCount)*radians(y)+colWidth;
            y += sin(frameCount)*radians(x)+rowHeight;
        }
        
        case 5 : {
           x += cos(frameCount)*noise(x)+rowHeight;
           y += sin(frameCount)*noise(y)+colWidth;
         }
         break;
         
        case 6 : {
           if( x < 0 || y > height ) {
              x = width-rowHeight;
              y = height-colWidth;
           } else {
             x++;
             y+=TWO_PI;
           }
         }
         break;
        
        case 7 :
        {
          if( xx >= width )
          {
            noFill();      
            stroke(0xffEF1975, alf);
            point(x,y);
            ellipse(x, y, rowHeight, rowHeight );
            
            
            point( x, y );
            point( width, y); 
            point( y, x);
            point(x*cos(frameCount), height-y*sin(frameCount) );

            //  curve(x1, y1, x2, y2, x3, y3, x4, y4)
            curve( x, y, width, y, y, x, x*cos(frameCount), height-y*sin(frameCount) );
            curve( 0, 0, x, y, y, x, width-x, height-y);

            strokeWeight(1);
            bezier( x, y, width, y, y, x, x*cos(frameCount), height-y*sin(frameCount) );
            bezier( 0, 0, x, y, y, x, width-x, height-y);
            bezier( y, x, width-x, height-y, y, x, width-x*cos(frameCount), height-y*sin(frameCount) );
            
            textFont( createFont("monospace", alf*gridSize ) );
            fill(0, alf);
            text( maxCt + " > " + gridSize + ":" + colWidth + " x " + rowHeight,  x*cos(frameCount), height-y*sin(frameCount) );
            fill(255, alf);
            text( maxCt + " > " + gridSize + ":" + colWidth + " x " + rowHeight,  x*cos(frameCount)-PI, height-y*sin(frameCount)-PI );
        
            fill(random(255),TWO_PI);

            gridSize = nums[ floor( random(nums.length) ) ]; //floor(random( 2, 10 ));
            colWidth = floor( width / gridSize );
            rowHeight = floor( height / gridSize );
            x = y = 0;
          }
        } break;
    }

}


//////////////////////////////////////////////////////////////////////
public void ptSystem( float x, float y )
{
    switch( floor(random(8)) )
    {
        case 0:{
            point( x, y );
        }
        break;
        
        case 1:{
            point( x, y );
            point( x/PI, x/PI );
        }
        break;
        
        case 2:{
            noFill();
            stroke(0xff1975EF, alf*PI);            
            rect(x, y, y/PI, y/PI, colWidth-rowHeight+noise(frameCount) ); 
            rect(y, x, x/TWO_PI, x/TWO_PI, x-y, y-x, y, x);
            
            stroke(0xff2012EF, alf*PI);
            rect(x, y, y/PI, y/PI ); 
            rect(y, x, x/TWO_PI, x/TWO_PI);
        }
        break;
        
        case 3:{
            point( x, y );
            point( y, x );
            
            //  curve(x1, y1, x2, y2, x3, y3, x4, y4)
            bezier( x, y, width, y, y, x, x*cos(frameCount), height-y*sin(frameCount) );
            bezier( 0, 0, x, y, y, x, width-x, height-y);

            curve( x, y, width, y, y, x, x*cos(frameCount), height-y*sin(frameCount) );
            curve( 0, height, x, y, x-y, y-x, width-x, height-y);

            strokeWeight(1);
            bezier( x, y, width, y, y, x, x*cos(frameCount), height-y*sin(frameCount) );
            curve( x, y, width, y, y, x, x*cos(frameCount), height-y*sin(frameCount) );

        }
        break;
        
        case 4:{
            text( frameCount, x, y );
            point(x, y);
        }
        break;
        
        case 5:{
            point( y, x );
            point( width, y );
        }
        break;
        
        case 6:{
            point( y/PI, x/PI);
            point( x/TWO_PI, x/TWO_PI );
        }
        break;
        
        case 7:{
            point( y, x);
            point( y/TWO_PI, y/TWO_PI );
        }
        break;
        
        case 8 : {
          point( x, y);
          point( width-x, height-y );
        } break;
    }
}

  public void settings() {  size( 1024, 768 );  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "NewSystems" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
