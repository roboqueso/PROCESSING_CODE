#include <Servo.h>
 
int servoPin = 9;
 
Servo servo;  
 
int servoAngle = 0;   // servo position in degrees
 
void setup()
{
  Serial.begin(115200);  
  servo.attach(servoPin);
}
 
 
void loop()
{
   //control the servo's direction and the position of the motor
  for( int a = 0; a < 360; a++ )
  {
    servo.write(a);
    delay(1000);          // Wait 1 second
  } 

  exit();
}

