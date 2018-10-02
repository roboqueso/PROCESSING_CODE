/**
 * load image and dice into pieces 
 */

PImage img, tmpSlice;
int rows = 11;
int cols = 11;

int colWidth, rowHeight;

void setup() {
  size(displayWidth, displayHeight);
  
  img = loadImage("devaskation-logo-4.png");  // Load the image into the program
  
  // debug
  println("img : " + img.width + ", "+ img.height );
  
  //  do calculations
  colWidth = ( img.width/rows );
  rowHeight = ( img.height / cols);
  
}

void draw() {
  
  //  SLICE IT UP
  //  OUTER ROW LOOP ( t - b ) 
  for( int row = 0; row < rows; row++)
  {

    //  INNER COLUMN LOOP ( l-r )  
    for( int col = 0; col < cols; col++)
    {
      tmpSlice = img.get( (colWidth*col), (rowHeight*row), colWidth, rowHeight);
      tmpSlice.save("slices/slice_r"+row+"c"+col+".png");
      
      //  lay it down on the screen
      image( tmpSlice, (colWidth*col), (rowHeight*row) );
    }
  }
  
  // Displays the image at its actual size at point (0,0)
  //image(img, 0, 0);
}
