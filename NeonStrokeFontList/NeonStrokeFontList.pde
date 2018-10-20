/**
NeonStrokeFontList - NeonStroke + FontList

see : https://docs.oracle.com/javafx/2/text/jfxpub-text.htm

- tune in color(s), text size and font
- re-visit https://docs.oracle.com/javafx/2/text/jfxpub-text.htm for additional magic

*/
import javafx.scene.canvas.*;
import javafx.scene.effect.*;
import javafx.scene.paint.*;
import javafx.scene.shape.*;
import javafx.scene.text.*;

import fixlib.*;


Fixlib fix = Fixlib.init(this);
String SAVE_NAME = "thisShouldBeDynamic";
String SAVE_EXTENSION = ".PNG"; //  ".TIF";

Canvas chuck;
GraphicsContext ctx;  //see: https://docs.oracle.com/javase/10/docs/api/javafx/scene/canvas/GraphicsContext.html

DropShadow ds, ds1;
InnerShadow is = new InnerShadow();
InnerShadow is1 = new InnerShadow();

Blend blend = new Blend();
Blend blend1 = new Blend();
Blend blend2 = new Blend();



float cX, cY, x1, y1;

int rectW,rectH;
int rectRad = 0;  //  store rect radius / point size / 
int stopper = 1;


//  TEXT VARS
String txtMsg;
String fnt;
String[] fontList = PFont.list();
int txtH = 11;  // arbitrary starting font size
int txtW;


//  A value of null is treated as pass-though this means no effect on a parent such as a Group and the equivalent of SRC_OVER for a single Node.
//  SRC_OVER = DEFAULT, use while concepting
BlendMode bMode = BlendMode.SRC_OVER;

//  16 BlendModes : Run final sketch through all 16 BlendModes
//  ADD, BLUE, COLOR_BURN, COLOR_DODGE, DARKEN, DIFFERENCE, EXCLUSION, GREEN, 
//  HARD_LIGHT, LIGHTEN, MULTIPLY, OVERLAY, RED, SCREEN, SOFT_LIGHT, SRC_ATOP
// BlendMode bMode = BlendMode.MULTIPLY;


/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(displayWidth, displayHeight, FX2D); // FX2D required
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/*****************************************************************************/
void setup() 
{
  background(-1);

  cX = width/2;
  cY = height/2;

  //see: https://docs.oracle.com/javase/10/docs/api/javafx/scene/canvas/GraphicsContext.html
  ctx = ((Canvas) surface.getNative()).getGraphicsContext2D();

  textAlign(CENTER);
  rectMode(CENTER);

  //  ARBITRARY starting textSize
  textSize(24);
  txtH = (int) (textAscent()+textDescent());

  ctx.setGlobalBlendMode(bMode);
  ctx.setFontSmoothingType( FontSmoothingType.GRAY );
  ctx.setFillRule(FillRule.EVEN_ODD); //  https://docs.oracle.com/javafx/2/api/javafx/scene/shape/FillRule.html
  ctx.setMiterLimit(1); //  default = 10.0, 1 gives nice round edge to text

  // debug
  printArray(fontList);

}




/*****************************************************************************/
void draw() {
    

    //  LOAD FONT HERE
    try 
    {
      fnt = fontList[frameCount-1]; //  -1 so we get font[0]
    } 
    catch( Exception exc )
    {
      println("FONT EXCEPTION: " + exc.getMessage() );

      fnt = fontList[ int(random(fontList.length-1)) ];
    }

    //  P5 FONT
    textFont( createFont( fnt, txtH ) );
    //  JFX FONT
    ctx.setFont( Font.font( fnt, txtH ) );


    //  APPEND FONT TO SAVE_NAME FOR TRACKING
    //  Generate filename containing sketch settings meta NOW
    SAVE_NAME = fix.pdeName() + "-bMode-" + bMode + "-" + fnt + "-" + (frameCount-1);

    //  TEXT pre-calcs
    txtMsg = fnt; //  font name
    
    //  RE-ADJUST TEXTSIZE TO FIT WIDTH
    txtW = (int)textWidth(txtMsg);
    txtH = (int)min(txtH*width/txtW, height);
    textSize(txtH);

    //  RE-MEASURE FOR RECT
    txtW = (int) textWidth(txtMsg);
    rectW = (int) ( txtW*.98 );
    rectH = (int)( textAscent() + textDescent());

    //  text X/Y
    x1 = 0;
    y1 = cY+(txtH/PI);  //random(height);


//  TODO: figure out smarter way to re-use blends to alternate NEON
    if(frameCount%2==0)
    {
      green();
    }
    else
    { 
      red();
    }

    ctx.setEffect(blend);

    //  RECT
    strokeWeight(TWO_PI);
    noFill();
    rect( x1+(txtW/2)-9, y1-(txtH/PI) , rectW, rectH, -rectRad );

    //  TEXT
    ctx.strokeText( txtMsg, x1-16, y1 );

    //  SAVE PNG FOR EACH FONT
    stampAndSave();

  
  //  STOPPER HERE IN CASE WE'VE COVERED THE FULL FONT LIST ALREADY
  if(frameCount>=fontList.length || (stopper>0 && frameCount >= stopper ) )
  {
    doExit();
  }
  else
  {
    setup();
  }

  

  
}


///////////////////////////////////////////////////////////////////////////////
void stampAndSave()
{
  //  alternate stamp color
  if(frameCount%2==0)
    fill(#EF1975);
  else if(frameCount%3==0)
    fill(#19EF75);
  else
    fill(#1975EF);

  textSize(13);
  txtMsg = "ERICFICKES.COM";
  text(txtMsg, width-textWidth(txtMsg), height-textAscent());
  save(SAVE_NAME+SAVE_EXTENSION); //  CONTROL EXTENSION UP TOP
}


///////////////////////////////////////////////////////////////////////////////
void red(){
      ctx.setStroke(Color.web("#EFEF43"));

          blend = new Blend();
          blend.setMode(BlendMode.MULTIPLY);
                
          ds = new DropShadow();
          ds.setColor(Color.web("#EF1975", 0.75));
          ds.setOffsetX(5);
          ds.setOffsetY(5);
          ds.setRadius(5);
          ds.setSpread(0.2);
          
          blend.setBottomInput(ds);
          
          ds1 = new DropShadow();
          ds1.setColor(Color.web("#EF2018", 0.75));
          ds1.setRadius(20);
          ds1.setSpread(0.2);
          
          blend2 = new Blend();
          blend2.setMode(BlendMode.MULTIPLY);
          
          is = new InnerShadow();
          is.setColor(Color.web("#EF1975", 0.75));
          is.setRadius(9);
          is.setChoke(0.8);
          blend2.setBottomInput(is);
          
          is1 = new InnerShadow();
          is1.setColor(Color.web("#EF2018", 0.75));
          is1.setRadius(5);
          is1.setChoke(0.4);
          blend2.setTopInput(is1);
          
          blend1 = new Blend();
          blend1.setMode(BlendMode.MULTIPLY);
          blend1.setBottomInput(ds1);
          blend1.setTopInput(blend2);
          
          blend.setTopInput(blend1);
}


///////////////////////////////////////////////////////////////////////////////
void green(){
        //  GREEN
      ctx.setStroke(Color.web("#19EF75"));  //  1843EF
      
          blend = new Blend();
          blend.setMode(BlendMode.MULTIPLY);
                
          ds = new DropShadow();
          ds.setColor(Color.web("#19EF75", 0.75));
          ds.setOffsetX(5);
          ds.setOffsetY(5);
          ds.setRadius(5);
          ds.setSpread(0.2);
          
          blend.setBottomInput(ds);
          
          ds1 = new DropShadow();
          ds1.setColor(Color.web("#2018EF", 0.75));
          ds1.setRadius(20);
          ds1.setSpread(0.2);
          
          blend2 = new Blend();
          blend2.setMode(BlendMode.MULTIPLY);
          
          is = new InnerShadow();
          is.setColor(Color.web("#1975EF", 0.75)) ;
          is.setRadius(9);
          is.setChoke(0.8);
          blend2.setBottomInput(is);
          
          is1 = new InnerShadow();
          is1.setColor(Color.web("#20EF18", 0.75)) ;
          is1.setRadius(5);
          is1.setChoke(0.4);
          blend2.setTopInput(is1);
          
          blend1 = new Blend();
          blend1.setMode(BlendMode.MULTIPLY);
          blend1.setBottomInput(ds1);
          blend1.setTopInput(blend2);
          
          blend.setTopInput(blend1);
          
          ctx.setEffect(blend);
}


/* ------------------------------------------------------------------------- */
/*  NON - P5 BELOW  */
/* ------------------------------------------------------------------------- */

/**
  End of sketch closer
*/
void doExit(){
  String msg = "ERICFICKES.com ";
  //  stamp bottom right based on textSize
  fill(#EF1975);
  textSize(13);
  text(msg, width-(textWidth(msg)+textAscent()), height-textAscent());
  
  save(SAVE_NAME+SAVE_EXTENSION); //  CONTROL EXTENSION UP TOP
  
  //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
