class AnalogMeter{
  PImage pointer;
  PImage scale;
  float step;
  float angle;
  float x;
  float y;
  float Width;
  float Height;
  float pointerScale;
  float startPoint = 3.3;
  float endPoint = 8.9;
  float maxReading;
  boolean extraEllipse;
  ArrayList<String> value = new ArrayList();
  
  public AnalogMeter(){
    pointer = loadImage("pointer.png");
    scale = loadImage("gauge.png");
    step = 1;
    x = width/2;
    y = height/2;
    Width = 240;
    Height = 240;
    pointerScale = 0.7;
    show();
    //drawText();
    int[] c = {0,20,40,60,80,100,120,140,160,180};
    setCalib(c);
    drawScale();
  }
  
  public AnalogMeter(float x,float y,float size,String png){
    pointer = loadImage("pointer.png");
    scale = loadImage(png);
    step = 1;
    this.x = x;
    this.y = y;
    Width = size;
    Height = size;
    pointerScale = 0.7;
    show();
    drawScale();
  }
  
  void drawScale(){
    //tint(255,0,0);
    imageMode(CENTER);
    image(scale,x,y,Width,Height);
  }
  
  void extraEllipse(boolean val){
    this.extraEllipse = val;
  }
   
  void show(){
    //imageMode(CENTER);
    ellipseMode(CENTER);
    // MPH/KPH SCALE
    pushMatrix();
    translate(x,y);
    noStroke();
    if(extraEllipse){
      ellipse(-Width/2.45,Height*0.25,Width/4,Height/4);
    }
    popMatrix();
    //Scale Ellipse
    noStroke();
    fill(245,245,245);
    ellipse(x,y,Width,Height); 
  }
  
  void setCalib(int val[]){
    for(int i=0;i<val.length;i++){
      value.add(i,String.valueOf(val[i]));
    }
  }
  
  //sets where the pointer should point at zero or at no reading
  void setStartPoint(float point){
    this.startPoint = point;
  }
  
  void setMaxReading(float reading){
    this.maxReading = reading;
  }
  
  void setEndPoint(float point){
    this.endPoint = point;
  }
  
  
  /*
  void startPoint(){
    angle = angle+startPoint; 
    translate(x,y);
    rotate(angle); 
    scale(Width/pointer.width*pointerScale);
    imageMode(CORNERS);
    image(pointer,-pointer.width/2,-pointer.width/2);
  } 
  */
  
  void setValue(float value){      
    show(); // Draw new background every time
    drawScale();
    pushMatrix();
    value = constrain(value,0,maxReading);
    float valueToShow = map(value,0.0,maxReading,startPoint,endPoint);
    //valueToShow = (valueToShow <= maxReading)? valueToShow : maxReading;
    translate(x,y);
    rotate(valueToShow); 
    scale(Width/pointer.width*pointerScale);
    imageMode(CORNERS);
    image(pointer,-pointer.width/2,-pointer.width/2);  
    popMatrix();
  }

}