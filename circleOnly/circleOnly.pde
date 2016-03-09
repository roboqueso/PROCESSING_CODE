size( 1024, 768 );
background(21);

  int xx;
  int yy;
  
  int cX = this.width / 2;
  int cY = this.height / 2;
  
  float angle      = 45; 
  float radius     = 100;
  float frequency  = 1;
  int circleSize   = 100;
  
  noFill();
  smooth();
      
     // draw ellipse around a circle
    for (int i = 0; i <= 360; i++)
    {
  
      xx = cX - int( cos(radians(angle)) * radius );
      yy = cY - int( sin(radians(angle)) * radius );
      
      if( i <= 90 )
      {
        stroke( 255, 0,0 );      
      }
      else if( i <= 180 )
      {
        stroke( #75EF19 );      
      }
      else if( i <= 270 )
      {
        stroke( #EFEFEF );     
      }
      else if( i <= 360 )
      {
        stroke( #1975EF );      
      }

      strokeWeight( 0.5 );
  
      ellipse( xx, yy, circleSize, circleSize );
  
angle -= frequency;

      
    } 

//  save it
saveFrame("circle.png");

noLoop();
