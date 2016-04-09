import de.voidplus.leapmotion.*;

HGroup rects;
HRect r1, r2, r3, r4, r5;
float colW, colH;


LeapMotion leap;
Finger finger_front;


void setup()
{
	size(1440, 1080, P3D);
	H.init(this).background(#202020).autoClear(false).use3D(true);
	smooth();


	leap = new LeapMotion(this);

	colH = height;
	colW = (width/5)-15;
	rects = H.add(new HGroup());

	// first row of HRect's

	r1 = new HRect(colW, colH );
	r1.strokeWeight(2).stroke(#181818).noFill().loc(0,0);
	rects.add(r1);

	// SHIM SEPARATOR
	rects.add( new HRect( 15, colH).noStroke().fill(255).loc(colW, 0) );

	r2 = new HRect(colW, colH);
	r2.strokeWeight(2).stroke(#181818).noFill().loc(colW+15,0);
	rects.add(r2);

	// SHIM SEPARATOR
	rects.add( new HRect( 15, colH).noStroke().fill(255).loc(colW*2+15, 0) );

	r3 = new HRect(colW, colH);
	r3.strokeWeight(2).stroke(#181818).noFill().loc(colW*2+30,0);
	rects.add(r3);

	// SHIM SEPARATOR
	rects.add( new HRect( 15, colH).noStroke().fill(255).loc(colW*3+30, 0) );

	r4 = new HRect(colW, colH);
	r4.strokeWeight(2).stroke(#181818).noFill().loc(colW*3+45,0);
	rects.add(r4);

	// SHIM SEPARATOR
	rects.add( new HRect( 15, colH).noStroke().fill(255).loc(colW*4+45, 0) );

	r5 = new HRect(colW, colH);
	r5.strokeWeight(2).stroke(#181818).noFill().loc(colW*4+60,0);
	rects.add(r5);

	// SHIM SEPARATOR
	rects.add( new HRect( 15, colH).noStroke().fill(255).loc(colW*5+60, 0) );

}

Hand hand;
Finger finger;

void draw()
{

	H.drawStage();

	fill(random(255));
	stroke(random(255));

if( leap.getHands().size() > 0 ){

	hand = leap.getHands().get(0);

	finger = hand.getFrontFinger();

		if(finger != null)
		{

			// GET THE TIP
			PVector finger_tip = finger.getPositionOfJointTip();

			// int fingerType = finger.getType();

			// ARE WE OVER A BOX?
			if( r1.contains( finger_tip.x, finger_tip.y ))
			{
				doBox1( finger_tip );
			}
			else if( r2.contains( finger_tip.x, finger_tip.y ))
			{
				doBox2( finger_tip );	
			}
			else if( r3.contains( finger_tip.x, finger_tip.y ))
			{
				doBox3(finger_tip);
			}
			else if( r4.contains( finger_tip.x, finger_tip.y ))
			{	
				doBox4(finger_tip);
			}
			else if( r5.contains( finger_tip.x, finger_tip.y ))
			{
				doBox5(finger_tip);
			}

		} else {

			text("null finger", random(width), random(height) );

		}

	}

}


///////////////////////////////////////////////////////////////////////////////
void doBox1( PVector fng )
{
	stroke( random(100, 128), 0, random(100, 128));
	fill( random(200, 230), random(200,230), random(200,250), 100);

	pushMatrix();
		translate(fng.x, fng.y, fng.z );
		box(20);
	popMatrix();
}

///////////////////////////////////////////////////////////////////////////////
void doBox2( PVector fng )
{
	
	// for( int lifespan = 150; lifespan > 0; lifespan-- )
	// {
		strokeWeight(2);
		stroke( random(30,40), random(130, 140), random(30,40) );
		fill(random(200,242), random(200,242), random(11,111), random(100));

	// 	sphereDetail( (int) random(3,7));


		pushMatrix();
			translate(fng.x, fng.y, fng.z );
			// ellipse(0,0,20,20);
			sphereDetail( (int)random(2,5));
			sphere(20);
		popMatrix();


	// }
}

///////////////////////////////////////////////////////////////////////////////
void doBox3( PVector fng )
{
	fill(fng.z, fng.z, fng.y);
	strokeWeight(PI);
	stroke(#0000EF);
	ellipse(fng.x, fng.y, fng.z, fng.z);

	strokeWeight(HALF_PI);
	stroke( random(30), random(144), random(255) );
	line( fng.x, fng.y, (r3.x() + r3.width()/2), r3.height()/2);
}

///////////////////////////////////////////////////////////////////////////////
void doBox4( PVector fng )
{

// GOLDEN TRIANGLE
	fill(#FFD700);
	triangle( fng.x, fng.y, fng.x+(fng.z/3), fng.y-fng.z, fng.x+fng.z, fng.y);


	fill( random(200,218), random(150,165), random(30,40));
	triangle( fng.x, fng.y, fng.x+(fng.z/2), fng.y-fng.z, fng.x+fng.z, fng.y);
}

///////////////////////////////////////////////////////////////////////////////
void doBox5( PVector fng )
{
	fill(#FF3300, 50);
	stroke(#EF6900);
	// text("55555", fng.x, fng.y);

	pushMatrix();
	  translate(fng.x, fng.y, fng.z);
	  rotate(frameCount / -100.0);
	  star(0, 0, 30, 70, 5); 
  	popMatrix();
}





void star(float x, float y, float radius1, float radius2, int npoints) 
{
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}













////// S SAVE HANDLER /////////

void keyPressed(){
switch(key){

	case 's':
		save(pdeName() + getTimestamp() + ".png");
	break;

	case ESC:
		save(pdeName() + getTimestamp() + ".png");
		stop();
	break;
}

}

public String getTimestamp() {
	return ""+month()+day()+year()+hour()+minute()+millis();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?
public String pdeName() {
	return split( this.toString(), "[")[0];
}
