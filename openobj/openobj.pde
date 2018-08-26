/**
NOTE: large OBJs cause this sketch to choke
** local machine problem perhaps?
*/


// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);

ArrayList<PShape> shapes = new ArrayList<PShape>();
PShape s;
float x, y;

/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(1920, 1080, P3D); // FX2D required
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/*****************************************************************************/
void setup() 
{
  background(-255);

  // size(100, 100, P3D);
  // The file "bot.obj" must be in the data folder
  // of the current sketch to load successfully
  s = loadShape("deskcalendar/desk_calendar_004.obj");
}

void draw() {
  background(204);
  translate(width/2, height/2);
  shape(s, 0, 0);
}