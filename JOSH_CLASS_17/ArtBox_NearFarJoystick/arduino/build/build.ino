/*
ART BOX v1

 - near / far
 - joystick x|y|click
*/

#define trigPin 3
#define echoPin 2

//  JOYSTICK
#define joyXPin A0
#define joyYPin A1
#define joyButtonPin 4

int joyX = 0;
int joyY = 0;
int joyButton = 0;

//  ULTRA SONIC
int maxInches = 20; //  20 ish
long duration, inches;

//////////////////////////////////////////////////////////////////////////////////////////////
void setup()
{
  Serial.begin(115200);

  //  ULTRA SONIC PINS
  pinMode(trigPin, OUTPUT);
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2); 
  pinMode(echoPin, INPUT);


  //  JOYSTICK
  pinMode(joyXPin, INPUT);
  pinMode(joyYPin, INPUT);

  //activate pull-up resistor on the push-button pin
  pinMode(joyButtonPin, INPUT_PULLUP); 

  //  ALL GOOD!
  Serial.println("go");
} 


//////////////////////////////////////////////////////////////////////////////////////////////
void loop()
{  
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);    

  // Read the signal from the sensor: a HIGH pulse whose
  // duration is the time (in microseconds) from the sending
  // of the ping to the reception of its echo off of an object.
  duration = pulseIn(echoPin, HIGH);

  // convert the time into a distance
  inches = (duration/2) / 74; 

  //  GOT MOTION IN RANGE?
//  if(inches <= maxInches)
//  {
    //  READ JOYSTICK
    joyX = analogRead(joyXPin);
    joyY = analogRead(joyYPin);
    joyButton = digitalRead(joyButtonPin);


    //  SPIT OUT DATA
    //  duration|inches|joyX|joyY|joyButtonUp
    Serial.println( String(duration) + '|' + String(inches) + '|' + String(joyX) + '|' + String(joyY) + '|' + String(joyButton));

//  }


  delay(250);
}
