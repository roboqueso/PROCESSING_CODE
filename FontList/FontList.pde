//  
//  Show a grid of ALL installed fonts
//
public String[] fontList = PFont.list();
public float xx, yy, txtSz = 21, rowHeight, colWidth;
public String msg = "Processing", fnt;
public Boolean isFinal = true;

void setup(){
  // size( 1024, 768 );
  size( displayWidth, displayHeight );
  background(0);
  stroke(255);
  fill(255);
  

}

void draw(){


  try {
    fnt = fontList[frameCount];
    textFont( createFont( fnt, txtSz ));
  } 
  catch( Exception exc ){
    fnt = fontList[ int(random(fontList.length-1)) ];
    textFont( createFont( fnt, txtSz ));
    fill(random(255));
  }
//  text( msg, xx, yy );

text( fnt, xx, yy );
  
  if( yy <= 1024 ){
  
    yy += textAscent()+textDescent();
    
  } else {
    yy = 0;
    xx += txtSz*6.7;  // 11;//
  }
  
  
  
  if( xx >= 1024 && yy >= 768 ){
      
    strokeWeight(12);
    stroke(#EF2012);
    point(1024/2, 768/2);
    
    strokeWeight(8);
    stroke(0);
    point(1024/2, 768/2);
    
    strokeWeight(4);
    stroke(#20EF12);
    point(1024/2, 768/2);
  
    if(isFinal){
      save( split( this.toString(), "[")[0] + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
    }
    
    noLoop();
  
  }
  
}


