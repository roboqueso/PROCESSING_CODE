/*
Joystick + laser

TODO: color jazz
*/

// Arduino pin numbers
const int SW_pin = 2; // digital pin connected to switch output
const int X_pin = 0; // analog pin connected to X output
const int Y_pin = 1; // analog pin connected to Y output
const int laserPin = 10;

int clicked = 0;

void setup() {
  
  //  JOYSTICK "switch"
  pinMode(SW_pin, INPUT);
  //  LASER
  pinMode (laserPin, OUTPUT); // define the digital output interface 13 feet

  digitalWrite(SW_pin, HIGH);
  Serial.begin(9600);
}

void loop() {
  Serial.print("Switch:  ");
  Serial.print(digitalRead(SW_pin));
  Serial.print("\n");
  Serial.print("X-axis: ");
  Serial.print(analogRead(X_pin));
  Serial.print("\n");
  Serial.print("Y-axis: ");
  Serial.println(analogRead(Y_pin));
  Serial.print("\n");
  delay(500);


  clicked = digitalRead(SW_pin);
  
  switch( clicked ){

    //  0 = clicked
    case 0:
    {
      digitalWrite (laserPin, HIGH); // Turn Laser On
//      delay (1000); // On For Half a Second
    }
    break;

    //  1 = UP
    case 1:
    {
      digitalWrite (laserPin, LOW); // Turn Laser Off
//      delay (500); // Off for half a second
    }
    break;

    default:
    {
      
      Serial.println("UNKNOWN VALUE : " + String(clicked) );
      
      }
    break;
  }
}
