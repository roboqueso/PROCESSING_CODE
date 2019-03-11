import nervoussystem.obj.*;

int colCt = 8;
int maxCt = 11;





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


  beginRecord("nervoussystem.obj.OBJExport", this+""+colCt+".obj");
}




/* ------------------------------------------------------------------------- */
void draw() {
// translate(width/2, height/2, colCt );
// pushMatrix();


//  MARBLE : run lowDetail middle
//        : highDetail outer

//  The default resolution is 30, vertices every 360/30 = 12 degrees.


  sphereDetail(360); //  outer marble
  sphere( width/3 );
  
  //  3,5,8,13,21,34,55,89,144
  // sphereDetail( (int)sqrt(144), 144); //  inner marble
 //  sphereDetail( 3, (int)sqrt(3) ); //  inner marble
	// sphere( width/9 );


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
