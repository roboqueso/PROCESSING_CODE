/*
inspired by https://www.hypeframework.com/projects/HShape-002

exploring HYPE magic with P5 exported OBJs


THIS SHIT NEEDS TO BE REWRITTEN, IT DOESN'T WORK WITH YOUR OBJS


*/


import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

HColorPool colors;
HShape     s1, s2, s3, s4, s5, s6, s7, s8, s9;

void setup() {
	size(1600, 1600, P3D);
	background(-1);
	H.init(this).background(-1).use3D(true);
	smooth(8);

println("SETUP");


	colors = new HColorPool().add(#FFFFFF, 9).add(#ECECEC, 9).add(#CCCCCC, 9).add(#333333, 3).add(#0095a8, 2).add(#00616f, 2).add(#FF3300).add(#FF6600);

	H.add( s1 = new HShape("ball1.obj") )
		.enableStyle(false)
		.scale(1.5f)
		.strokeWeight(1)
		.stroke(H.RED, 255)
		.fill(H.MAGENTA, 50)
		.anchorAt(H.CENTER)
		.loc(120, height/2 - 175)
		.alpha(127) 
	;

	//alpha will override individual stroke and fill alpha values

	s2 = new HShape("ball2.obj").enableStyle(false);
	H.add(s2)
	.scale(1.5f)
	.strokeWeight(3)
	.stroke(H.YELLOW, 150) //set alpha of stroke
	.fill(H.BLUE, 13) //set alpha of fill
	.anchorAt(H.CENTER)
	.loc(width/2, height/2 - 175)
	;

	s3 = new HShape("ball3.obj");
	s3.randomColors(colors.strokeOnly());
	H.add(s3)
	.scale(1.5f)
	.fill(H.GREY, 100)
	.stroke(H.RED, 200) //stroke color is overriden by randomColors, but the alpha is inherited
	.strokeWeight(3)
	.anchorAt(H.CENTER)
	.loc(width - 120, height/2 - 175)
	;

	s4 = new HShape("ball4.obj");
	s4.randomColors(colors.fillOnly());
	H.add(s4)
	.scale(1.5f)
	.strokeWeight(3)
	.stroke(H.GREEN, 255)
	.fill(H.RED, 100) //fill color is overriden by randomColors, but the alpha is inherited
	.anchorAt(H.CENTER)
	.loc(120, height/2 + 15)
	;

	s5 = new HShape("ball5.obj");
	s5.enableStyle(false);
	H.add(s5)
	.scale(1.5f)
	.strokeWeight(6)
	.stroke(H.WHITE, 100)
	.fill(H.GREEN, 50)
	.anchorAt(H.CENTER)
	.loc(width/2, height/2 + 15)
	;

	s6 = new HShape("ball6.obj");
	s6.enableStyle(false);
	H.add(s6)
	.scale(1.5f)
	.strokeWeight(12)
	.fill(H.MAGENTA, 100)
	.noStroke()
	.anchorAt(H.CENTER)
	.loc(width - 120, height/2 + 15)
	;

	s7 = new HShape("ball7.obj");
	s7.enableStyle(true);
	H.add(s7)
	.scale(1.5f)
	.strokeWeight(3)
	.stroke(H.GREEN, 255)
	.fill(H.RED, 255)
	.anchorAt(H.CENTER)
	.loc(120, height/2 + 200)
	;

	for (int i=0; i<=s7.numChildren(); i+=3) {
	s7.setChild(i); //set every third item to have a green stroke and red fill
	}

	s8 = new HShape("ball8.obj");
	s8.enableStyle(false);
	H.add(s8)
	.scale(1.5f)
	.strokeWeight(12)
	.stroke(H.MAGENTA, 150)
	.noFill()
	.anchorAt(H.CENTER)
	.loc(width/2, height/2 + 200)
	;

	for (int i=0; i<=s8.numChildren(); i+=2) {
	s8.setChild(i); //set every second item to have a maagenta stroke and no fill
	}

	s9 = new HShape("ball9.obj");
	H.add(s9)
	.scale(1.5f)
	.strokeWeight(8)
	.fill(H.YELLOW, 190)
	.stroke(H.BLUE)
	.anchorAt(H.CENTER)
	.loc(width - 120, height/2 + 200)
	;

	for (int i=0; i<=s9.numChildren(); i+=3) {
		s9.setChild(i); //starting from the first item, set every third item to have a yellow fill and no stroke
	}

	s9.fill(H.RED, 155);
	s9.stroke(H.GREEN, 255);
	s9.strokeWeight(2);

	for (int i=1; i<=s9.numChildren(); i+=3) {
		s9.setChild(i); //starting from the second item, set every third item to have a red fill and green stroke
	}



println("DONE W/SETUP");

}


void draw() {

	println("draw: "+ frameCount );

	//animate with random colors
	s3.randomColors(colors.strokeOnly());
	s4.randomColors(colors.fillOnly());
	
	H.drawStage();

save(this+".png");




	if(frameCount>69){
		exit();
	}
}
/*
PShape s;

void setup() {
  size(1600, 1600, P3D);
  background(-1);
  // The file "bot.obj" must be in the data folder
  // of the current sketch to load successfully
  s = loadShape("ball2.obj");
  strokeWeight(PI);

}

void draw() {
	stroke(random(255));

	lights();
	camera();


	translate(width/2, height/2);
	shape(s, 0, 0);
}
*/