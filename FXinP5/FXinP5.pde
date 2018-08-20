/**

Inspired by https://discourse.processing.org/t/a-way-to-add-fancy-effects-to-your-sketches/2073

InnerShadow
https://docs.oracle.com/javafx/2/api/javafx/scene/effect/InnerShadow.html

DropShadow
https://docs.oracle.com/javafx/2/api/javafx/scene/effect/DropShadow.html

JavaFX GLOW
see: https://docs.oracle.com/javafx/2/api/javafx/scene/effect/Glow.html

JavaFX LinearGradient
https://docs.oracle.com/javafx/2/api/javafx/scene/paint/LinearGradient.html

Bloom
https://docs.oracle.com/javafx/2/api/javafx/scene/effect/Bloom.html
*/
import javafx.scene.canvas.*;
import javafx.scene.effect.*;
//import javafx.scene.paint.Color; // JavaFX uses different colors than Processing
import javafx.scene.paint.*;

GraphicsContext ctx;

LinearGradient gradient;

//GaussianBlur fxGaussianBlur = new GaussianBlur(20d); // the 'd' stands for 'double'
DropShadow fxDropShadow = new DropShadow(15d, 0d, 20d, Color.gray(0, 0.3)); // we have to use the Color JavaFX class becasue JFX does not support Processing colors (kind of obviously)

Glow fxGlow;
Bloom fxBloom;
InnerShadow fxInnerShadow;


void setup() {
  size(1920, 1080, FX2D); // FX2D required
  
  background(-1);

  smooth(8);
  pixelDensity(displayDensity());

  // JAVAFX!
  fxGlow = new Glow();
  fxBloom = new Bloom();
  fxInnerShadow = new InnerShadow();
  
  // in order to apply effects we need to get the 'native' graphics context of our canvas
  ctx = ((Canvas) surface.getNative()).getGraphicsContext2D();
  
    /* I like to use the valueOf() function of the LinearGradient class,
     because it provides a simple, CSS-like way for defining gradients. */
     /*
  gradient = LinearGradient.valueOf("linear-gradient(" +
                                    "from 0% 0% to 100% 100%," +
                                    "black 0%, white 100%)");
                                    */
                                    gradient = LinearGradient.valueOf("linear-gradient(from 0px 0px to "+width+"px "+height+"px, #00EF43 13%, 0xEF4300 43%, 0x4300EF 86%)");
}

void draw() {

// TODO: make this dynamic like LinearGradient
  /*
 fxInnerShadow.setOffsetX(4);
 fxInnerShadow.setOffsetY(4);
 fxInnerShadow.setColor(Color.web("0xEF2018"));
  */
  //  1 = MAX
  fxBloom.setThreshold(frameCount/10 % 1.1);
  fxGlow.setLevel(frameCount/10 % 1.1);
  
  stroke(frameCount%255);
  
 

  // to disable the effect, just set it to `null`
  //ctx.setEffect(null);
  ctx.setEffect(fxBloom);
  ctx.setEffect(fxGlow);
  ctx.setEffect(fxDropShadow); // material design-style drop shadow
  //ctx.setEffect(fxInnerShadow);
  ctx.setFill(gradient); // use setStroke for strokes
  
  if(frameCount%13==0){
    ellipse(frameCount%width,random(height*.75), 13,13 );
    ellipse(random(frameCount),random(frameCount)%height, 43,43 );
  }
  else
    rect( (random(frameCount)+(frameCount*noise(8)))%width,random(height/6, height/2)+noise(frameCount), random(360), random(160), random(HALF_PI,TWO_PI));
  
  
  if(frameCount>width){
    doExit();
  }
  
}


void doExit(){

   save(this+""+second()+millis()+".png");
    noLoop();
    System.gc();
    super.exit();

}
