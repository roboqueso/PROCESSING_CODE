import processing.opengl.*;
import nervoussystem.obj.*;


void setup()
{
    size(450, 450, OPENGL);
    beginRecord("nervoussystem.obj.OBJExport", this+".obj");
    sphereDetail(3);
}

void draw()
{
    lights();
    camera();

    fill(255, 128, 0);

    pushMatrix();    
    translate( 120, 120, 0 );
    rotateX( PI/6 );
    rotateY( radians( frameCount ) );
    rotateZ( radians( frameCount ) );
    drawCylinder( 6, 50, 80, 100 );
    popMatrix();

    pushMatrix();    
    translate( 330, 120, 0 );
    rotateX( PI/4 );
    rotateY( radians( frameCount ) );
    rotateZ( radians( frameCount ) );
    drawCylinder( 9, 40, 20, 100 );
    popMatrix();

    pushMatrix();    
    translate( 120, 330, 0 );
    rotateX( PI/2 );
    rotateY( radians( frameCount ) );
    rotateZ( radians( frameCount ) );
    drawCylinder( 30, 50, 50, 100 );
    popMatrix();

    pushMatrix();    
    translate( 330, 330, 0 );
    rotateX( PI/12 );
    rotateY( radians( frameCount ) );
    rotateZ( radians( frameCount ) );
    drawCylinder( 8, 50, 5, 100 );
    popMatrix();


    if(frameCount > 45){
	endRecord();
    save(this+".png");
    exit();
	}
}

void drawCylinder( int sides, float r1, float r2, float h)
{
    float angle = 360 / sides;
    float halfHeight = h / 2;

    // draw top of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r1;
        float y = sin( radians( i * angle ) ) * r1;
        vertex( x, y, -halfHeight);
    }
    endShape(CLOSE);

    // draw bottom of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r2;
        float y = sin( radians( i * angle ) ) * r2;
        vertex( x, y, halfHeight);
    }
    endShape(CLOSE);
    
    // draw sides
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
        float x1 = cos( radians( i * angle ) ) * r1;
        float y1 = sin( radians( i * angle ) ) * r1;
        float x2 = cos( radians( i * angle ) ) * r2;
        float y2 = sin( radians( i * angle ) ) * r2;
        vertex( x1, y1, -halfHeight);
        vertex( x2, y2, halfHeight);    
    }
    endShape(CLOSE);

}
