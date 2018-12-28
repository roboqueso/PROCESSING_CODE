import nervoussystem.obj.*;

int colCt = 4;
int maxCt = 16;





/* ------------------------------------------------------------------------- */
void  settings ()  {
    //  For best results, change size() to match dimensions of mainImgFile
    size( 1600, 1600, P3D);
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}


/* ------------------------------------------------------------------------- */
void setup() {
	background(-1);
	strokeWeight(PI);
	noFill();

  beginRecord("nervoussystem.obj.OBJExport", this+""+colCt+".obj");
}




/* ------------------------------------------------------------------------- */
void draw() {
 
	stroke(random(255));


  // lights();
  // camera();
  // ortho();

// translate(width/2, height/2, colCt );
// pushMatrix();


	sphereDetail(colCt);
	sphere( (colCt*240) );

// popMatrix();

  if(colCt > maxCt ){
  save(this+ "-" + colCt +".png");
  endRecord();

    noLoop();
    exit();
  } else {
    
    colCt++;
    // setup();
  }

}
