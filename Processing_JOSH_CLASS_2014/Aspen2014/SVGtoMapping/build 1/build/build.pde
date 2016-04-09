PShape s;



void setup() {
	size( 1000, 900 );
	background(#FF6600);
	smooth();

	s = loadShape("layout.svg");
}


void draw() {
	background(#FF6600);

	shape(s,0,0);
}