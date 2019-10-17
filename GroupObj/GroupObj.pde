import nervoussystem.obj.*;
import fixlib.*;
Fixlib fix = Fixlib.init(this);
OBJExport obj;

//  CLICK to export group as .OBJ

PShape group;

void setup() {
  size(100, 100, P3D );
  // Make a group PShape
  group = createShape(GROUP);
  
  // Make three shapes
  PShape path = createShape();

path.setStroke(#EF2019);
path.setFill(#EF1975);

  path.beginShape();
    path.vertex(-20, -20);
    path.vertex(0, -40);
    path.vertex(20, -20);
  path.endShape(CLOSE);

  PShape rectangle = createShape(RECT, -20, -20, 40, 40);
rectangle.setStroke(#EF1975);
rectangle.setFill(#EF2019);

  PShape circle = createShape(ELLIPSE, 0, 0, 20, 20);
  circle.setStroke(#DAD420);
  circle.setFill(#EF4419);


  // Add all three as children
  group.addChild(path);
  group.addChild(rectangle);
  group.addChild(circle);
  group.addChild(rectangle);
  group.addChild(circle);

}

void draw() {
  background(52);
  translate(mouseX, mouseY, mouseX-mouseY);
  shape(group);
}

void mouseClicked(){


  println(" children : " + group.getChildCount() );
  
  // OBJExport obj = (OBJExport) createGraphics( width, height, "nervoussystem.obj.OBJExport", fix.pdeName()+"-"+fn+(s1?"s1":"")+(s2?"s2":"")+(s3?"s3":"")+".obj");
  obj = (OBJExport) createGraphics( width, height, "nervoussystem.obj.OBJExport", this+".obj");  
    obj.beginDraw();
   
      obj.beginShape();
      obj.translate(mouseX, mouseY, mouseX-mouseY);
      
  for( int cc = 0; cc < group.getChildCount(); cc++){
    PShape child = group.getChild(cc);
    
println(" child : " + cc+1 + " :: " + child.getVertexCount() );
//obj.text(" child : " + cc+1 + " :: " + child.getVertexCount(), width/2, height/2 );
obj.rotate( 90 * cc );

    for(int ii = 0; ii < child.getVertexCount(); ii++){
      PVector vct = child.getVertex( ii );
      obj.vertex( vct.x, vct.y, vct.z );
    }
  }
  obj.endShape(CLOSE);
  
      save( fix.pdeName() + fix.getTimestamp()+".png" );
    
        obj.endDraw();
    obj.dispose();
    obj = null;

    exit();

}
