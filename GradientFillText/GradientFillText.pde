/**
GradientFillText - use JFX Gradient to create graffit style text

TODO:

- check out examples:

http://learningprocessing.com/examples/chp17/example-17-08-textalongcurve
http://learningprocessing.com/examples/chp17/example-17-07-boxesoncurve

https://docs.oracle.com/javase/8/javafx/user-interface-tutorial/text-settings.htm

JavaFX LinearGradient
  https://docs.oracle.com/javafx/2/api/javafx/scene/paint/LinearGradient.html
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

LinearGradient gradFill, gradStroke;

boolean showBg = false; //  show background image

float cX, cY, txtX, txtY;

int rectW,rectH;
int rectRad = 0;  //  store rect radius / point size / 
int stopper = 0;  //  0 = Run through entire fontList[] array
int strokeSz = 4;  //  Stroke weight affects the FRAME and the TEXT

//  TEXT VARS
String txtMsg;
String fnt;
// String[] fontList = PFont.list();  //  P5 FONT LIST

//  ALL INSTALLED FONTS - as known by JFX
// String[] fontList = javafx.scene.text.Font.getFamilies().toArray(new String[0]); //  JFX FONT LIST
//  TODO: curate favorites - NON-STANDARD SHIT
//  * export to OBJ favorites after adding NEON_SIGN_MSG feature


//  DEVASKATION FONTS
// String[] fontList = { "Myriad Pro", "AMCAP Eternal", "Helvetica", "Cardo" };

//  FAVORITES
String[] fontList = { "Slaytanic", "AMCAP Eternal",  "Arial Rounded MT Bold", "Bitwise", "Cardo", 
                      "Catwing", "Chalkduster", "Courier", "Cranberry Gin", "Didot", "Fh_Perception", "Georgia", "Impact", 
                      "Jumble", "Krungthep", "PT Mono", "Raleway", "Rockwell", 
                      "SignPainter", "Silom",  "Trattatello", "Zeoruz" };




int txtH = 11;  // arbitrary starting font size
int txtW;
// int bgColor = 255;  //  0 black, 255 white
Font jFont;
PImage bgImage;

//  A value of null is treated as pass-though this means no effect on a parent such as a Group and the equivalent of SRC_OVER for a single Node.
//  SRC_OVER = DEFAULT, use while concepting
// BlendMode bMode = BlendMode.SRC_OVER;

//  16 BlendModes : Run final sketch through all 16 BlendModes
//  ADD, BLUE, COLOR_BURN, COLOR_DODGE, DARKEN, DIFFERENCE, EXCLUSION, GREEN, 
//  HARD_LIGHT, LIGHTEN, MULTIPLY, OVERLAY, RED, SCREEN, SOFT_LIGHT, SRC_ATOP
BlendMode bMode = BlendMode.EXCLUSION;


/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(1920,1440, FX2D); // FX2D required
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());

    if(showBg)
      bgImage = loadImage("graffiti.png");
  
  // debug
  printArray(fontList);
}

/*****************************************************************************/
void setup() 
{
  background(-1);

  if(showBg)
    image(bgImage,0,0,width,height);
  
  noFill();
  rectMode(CENTER); //  NOTE: rect( x,y ) = the RECT's CENTER POINT
  textAlign(CENTER,CENTER);

  // textMode(SHAPE); //  todo: retry with P3D

  cX = width/2;
  cY = height/2;

  //see: https://docs.oracle.com/javase/10/docs/api/javafx/scene/canvas/GraphicsContext.html
  ctx = ((Canvas) surface.getNative()).getGraphicsContext2D();

  //  fill
  gradFill = LinearGradient.valueOf("linear-gradient(from 0px 0px to 0px "+height+"px, #5ca4db 20%, #a0aea8 40%, #cf94ad 60%, #a4347d 80% )");

  //  stroke
  gradStroke = LinearGradient.valueOf("linear-gradient(from 0px 0px to "+width+"px 0px, #1975EF 20%, #EFEFEF 40%, #ef4318 60%, #EF1975 80%)");

  
  ctx.setStroke(gradStroke);  //  Color.BLACK
  ctx.setFill(gradFill);

  ctx.setGlobalBlendMode(bMode);
  ctx.setFontSmoothingType( FontSmoothingType.GRAY );  //  LCD or GRAY
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
    //  
    SAVE_NAME = fix.pdeName() + "-" + (frameCount-1) + "-" + fnt  + "-strokeSz" + strokeSz +"-bMode-" + bMode;

    //  TEXT pre-calcs
    txtMsg = fnt; //  font name

    //  RE-ADJUST TEXTSIZE TO FIT WIDTH
    txtW = (int)textWidth(txtMsg);
    txtH = (int)min(txtH*width/txtW, height);
    textSize(txtH);

    //  text X/Y
    txtX = cX;
    txtY = cY;  //+(txtH/PI);  //random(height);

    // Shrink text size so it fits INSIDE the RECT better
    txtH -= 8;



  //  TEXT BALL
  pushMatrix();
  translate(cX, cY); // Translate to the center
  for(int rr = 0; rr < 360; rr+=6)
  {

    rotate(rr);                // Rotate by theta

    //  TEXT
    strokeWeight(strokeSz*.69);
    textSize(txtH*.69);
    ctx.fillText( txtMsg, 0,0 );
    ctx.strokeText( txtMsg, 0,0 );

    text(txtMsg,0,0);

  }
  popMatrix();




    //  TEXT
    textSize(txtH);
    strokeWeight(strokeSz);
    ctx.fillText( txtMsg, txtX, txtY );
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
