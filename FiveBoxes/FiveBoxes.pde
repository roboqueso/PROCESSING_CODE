HGroup rects;
HRect r1, r2, r3, r4, r5;

float colW, colH;

void setup(){
  size(1440, 1080);
  H.init(this).background(#202020).autoClear(false);
  smooth();
  

  colH = height;
  colW = (width/5)-15;
  rects = H.add(new HGroup());

  // first row of HRect's

  r1 = new HRect(colW, colH ).rounding(8);
  r1.strokeWeight(2).stroke(#181818).noFill().loc(0,0);
  rects.add(r1);

	// SHIM SEPARATOR
	rects.add( new HRect( 15, colH).noStroke().fill(255).loc(colW, 0) );

  r2 = new HRect(colW, colH).rounding(8);
  r2.strokeWeight(2).stroke(#181818).noFill().loc(colW+15,0);
  rects.add(r2);

	// SHIM SEPARATOR
	rects.add( new HRect( 15, colH).noStroke().fill(255).loc(colW*2+15, 0) );

  r3 = new HRect(colW, colH).rounding(8);
  r3.strokeWeight(2).stroke(#181818).noFill().loc(colW*2+30,0);
  rects.add(r3);

	// SHIM SEPARATOR
	rects.add( new HRect( 15, colH).noStroke().fill(255).loc(colW*3+30, 0) );

  r4 = new HRect(colW, colH).rounding(8);
  r4.strokeWeight(2).stroke(#181818).noFill().loc(colW*3+45,0);
  rects.add(r4);

	// SHIM SEPARATOR
	rects.add( new HRect( 15, colH).noStroke().fill(255).loc(colW*4+45, 0) );

  r5 = new HRect(colW, colH).rounding(8);
  r5.strokeWeight(2).stroke(#181818).noFill().loc(colW*4+60,0);
  rects.add(r5);

}

void draw()
{

  H.drawStage();

fill(random(255));
stroke(random(255));

  if( r1.contains( mouseX, mouseY ))
  {
  	rect(mouseX, mouseY, 11, 11);
  }
  else if( r2.contains( mouseX, mouseY ))
  {
  	ellipse(mouseX, mouseY, 11, 11);
  }
  else if( r3.contains( mouseX, mouseY ))
  {
  	line(mouseX, mouseY, (r3.x() + r3.width()/2), r3.height()/2);
  }
  else if( r4.contains( mouseX, mouseY ))
  {
  	text("4", mouseX, mouseY);
  }
  else if( r5.contains( mouseX, mouseY ))
  {
  	text("55555", mouseX, mouseY);
  }

}


void keyPressed()
{
  switch(key){
    case ESC:{
      save(this+".png");
      stop();
    };
  }
}


