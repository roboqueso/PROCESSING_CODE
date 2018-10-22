/**
NeonStrokeFontList - NeonStroke + FontList

see : https://docs.oracle.com/javafx/2/text/jfxpub-text.htm

TODO:
  * export to OBJ favorites after adding NEON_SIGN_MSG feature

*/
import javafx.scene.canvas.*;
import javafx.scene.effect.*;
import javafx.scene.paint.*;
import javafx.scene.shape.*;
import javafx.scene.text.*;
import javafx.geometry.VPos;
import javafx.scene.text.TextAlignment;


import fixlib.*;


Fixlib fix = Fixlib.init(this);
String SAVE_NAME = "thisShouldBeDynamic";
String SAVE_EXTENSION = ".PNG"; //  ".TIF";

GraphicsContext ctx;  //see: https://docs.oracle.com/javase/10/docs/api/javafx/scene/canvas/GraphicsContext.html

DropShadow ds, ds1;
InnerShadow is = new InnerShadow();
InnerShadow is1 = new InnerShadow();

Blend blend = new Blend();
Blend blend1 = new Blend();
Blend blend2 = new Blend();

boolean showFrame = false; //  include the text frame ( FALSE = just text )

float cX, cY, txtX, txtY;

int rectW,rectH;
int rectRad = 0;  //  store rect radius / point size / 
int stopper = 0;  //  0 = Run through entire fontList[] array
int strokeSz = 9;  //  Stroke weight affects the FRAME and the TEXT

//  TEXT VARS
String txtMsg;
String fnt;


// String[] fontList = PFont.list();  //  P5 FONT LIST

//  ALL INSTALLED FONTS - as known by JFX
// String[] fontList = javafx.scene.text.Font.getFamilies().toArray(new String[0]); //  JFX FONT LIST

//  DEVASKATION FONTS
// String[] fontList = { "Myriad Pro", "AMCAP Eternal", "Helvetica", "Cardo" };

String[] fontList = { "Myriad Pro", "AMCAP Eternal", "Helvetica", "Cardo","Slaytanic", "Arial Rounded MT Bold" };

/*
//  FAVORITES
String[] fontList = { "Slaytanic", "AMCAP Eternal",  "Arial Rounded MT Bold", "Bitwise", "Cardo", 
                      "Catwing", "Chalkduster", "Courier", "Cranberry Gin", "Didot", "Fh_Perception", "Georgia", "Impact", 
                      "Jumble", "Krungthep", "PT Mono", "Raleway", "Rockwell", 
                      "SignPainter", "Silom",  "Trattatello", "Zeoruz" };
*/


int txtH = 11;  // arbitrary starting font size
int txtW;
int bgColor = 255;  //  0 black, 255 white
Font jFont;

//  A value of null is treated as pass-though this means no effect on a parent such as a Group and the equivalent of SRC_OVER for a single Node.
//  SRC_OVER = DEFAULT, use while concepting
BlendMode bMode = BlendMode.SRC_OVER;

//  16 BlendModes : Run final sketch through all 16 BlendModes
//  ADD, BLUE, COLOR_BURN, COLOR_DODGE, DARKEN, DIFFERENCE, EXCLUSION, GREEN, 
//  HARD_LIGHT, LIGHTEN, MULTIPLY, OVERLAY, RED, SCREEN, SOFT_LIGHT, SRC_ATOP
// BlendMode bMode = BlendMode.MULTIPLY;


/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(1920,1080, FX2D); // FX2D required
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());


  // debug
printArray(fontList);
}

/*****************************************************************************/
void setup() 
{
  background(bgColor);
  
  noFill();
  rectMode(CENTER); //  NOTE: rect( x,y ) = the RECT's CENTER POINT
  textAlign(CENTER,CENTER);

  //  ONLY IF ROUND EDGES NEEDED - impacts sharp edged fonts
  // strokeJoin(ROUND);
  // strokeCap(ROUND);

  cX = width/2;
  cY = height/2;

  //see: https://docs.oracle.com/javase/10/docs/api/javafx/scene/canvas/GraphicsContext.html
  ctx = ((Canvas) surface.getNative()).getGraphicsContext2D();

  txtH = (int) (textAscent()+textDescent());

  ctx.setGlobalBlendMode(bMode);
  ctx.setFontSmoothingType( FontSmoothingType.GRAY );
  ctx.setFillRule(FillRule.EVEN_ODD); //  https://docs.oracle.com/javafx/2/api/javafx/scene/shape/FillRule.html
  
  //  The ratio limit of how far a MITER line join may extend in the direction of a 
  //  sharp corner between segments in the boundary path of a shape, relative to the 
  //  line width, before it is truncated to a BEVEL join in a stroke operation.
  
  //  ONLY IF ROUND EDGES NEEDED - impacts sharp edged fonts
  // ctx.setMiterLimit(1.0); //  default = 10.0, 1 is nice
  // ctx.setLineCap(StrokeLineCap.ROUND);

  ctx.setTextAlign(TextAlignment.CENTER);
  ctx.setTextBaseline(VPos.CENTER);

}




/*****************************************************************************/
void draw() {
    
    
    //  LOAD FONT HERE
    try 
    {
      fnt = fontList[frameCount-1]; //  -1 so we get font[0]

      jFont = new Font(fnt, txtH );
    } 
    catch( Exception exc )
    {
      println("FONT EXCEPTION: " + exc.getMessage() );

      fnt = fontList[ int(random(fontList.length-1)) ];
    }

      //  P5 FONT
      textFont( createFont( fnt, txtH ) );
      //  JFX FONT
      ctx.setFont( jFont );

    //  APPEND FONT TO SAVE_NAME FOR TRACKING
    //  Generate filename containing sketch settings meta NOW
    // Blendmode doesn't really matter at the moment
    //  "-bMode-" + bMode + 
    SAVE_NAME = fix.pdeName() + "-" + (frameCount-1) + "-" + fnt  + "-bgColor" + bgColor + "-strokeSz-" + strokeSz ;

    //  TEXT pre-calcs
    txtMsg = fnt; //  font name


    //  RE-ADJUST TEXTSIZE TO FIT WIDTH
    txtW = (int)textWidth(txtMsg);
    txtH = (int)min(txtH*width/txtW, height);
    textSize(txtH);

    //  RE-MEASURE FOR RECT
    txtW = (int) textWidth(txtMsg);
    rectW = (int) ( txtW*.99 );
    rectH = (int)( textAscent() + textDescent());

    //  text X/Y
    txtX = cX;
    txtY = cY;  //+(txtH/PI);  //random(height);

    // Shrink text size so it fits INSIDE the RECT better
    txtH -= 8;
    textSize(txtH);


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
    if(showFrame){
      //  STROKE A BIT BIGGER THAN TEXT
      strokeWeight(strokeSz*HALF_PI);
      //  Use CENTER PONT because rectMode(CENTER)
      rect( cX, cY , rectW, rectH, -rectRad );
    }

    //  TEXT
    strokeWeight(strokeSz);

    ctx.strokeText( txtMsg, txtX, txtY );


//  DROP P5 text in upper LEFT corner
fill(#696969);
textSize(txtH/PI);
text(txtMsg, txtX,  txtX-textDescent() );

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
  textSize(13);
  if(frameCount%2==0)
  {
    //green();
    fill(#20EF18);
  }
  else
  { 
    // red();
    fill(#EF4324);
  }
  txtMsg = "ERICFICKES.COM";
  text(txtMsg, width-(textWidth(txtMsg)*.25), height-( (textAscent()+textDescent())*1.11 ) );
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
  text(msg, width-(textWidth(msg)+textAscent()), height-txtH);
  
  save(SAVE_NAME+SAVE_EXTENSION); //  CONTROL EXTENSION UP TOP
  
  //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
