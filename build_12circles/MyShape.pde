 class MyShape {
  
  PVector loc;
  RShape curSVG;
  RShape[] _ChildShapes;
  color[] myStyles, pickedAlpha;
  int numChildren, ranNum;
  float myRotate, myScale;
  
  MyShape(float x, float y) {
    loc = new PVector(x, y, 0);
    
    ranNum = (int) random(100) % imgList.size();

    curSVG = (RShape) imgList.get(ranNum);
 
    numChildren = curSVG.countChildren();
    
    
    _ChildShapes = new RShape[numChildren];
    myStyles = new color[numChildren];
    
    pickedAlpha = new color[numChildren];
    for (int i=0; i<numChildren; i++) {
      _ChildShapes[i] = curSVG.children[i];
      myStyles[i] = palette[(int)random(palette.length)];
      pickedAlpha[i] = (int)random(255);
    }
    
    myRotate = radians( (int) (random(4)+1) *90 );
    myScale  = (int) (random(2)+1) *50 ;
  }
  
  void display() {
    for (int i=0; i<numChildren; i++) {
      RStyle style = _ChildShapes[i].getStyle();
      style.strokeColor = #EF7500;
      style.stroke = false;
      style.fillColor = myStyles[i];
      style.setFillAlpha( pickedAlpha[i] );
    }

    pushMatrix();
    translate(loc.x + xn(loc), loc.y + xn(loc) );
    rotate( myRotate );
        
    // SVG, x, y, width, height
    RG.shape(curSVG, 0, 0, myScale, myScale);
    popMatrix();
    
    loc.z++;
  }
}
