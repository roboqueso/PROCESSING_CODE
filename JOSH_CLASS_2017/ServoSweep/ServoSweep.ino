#include <Servo.h>

/*

Sweep while holding button

*/

#define buttonPin  6
#define servoPin  8

Servo myservo;  // create servo object to control a servo

int pos = 0;    // variable to store the servo position

void setup() 
{
  Serial.begin(115200);

  
  myservo.attach(servoPin);  // attaches the servo on pin 9 to the servo object
  // initialize the pushbutton pin as an input:
  pinMode(buttonPin, INPUT);



  Serial.println("start");
}



void loop() 
{
  //  toggle sweep
  if( digitalRead(buttonPin) == 1 )
  {
    
    for (pos = 11; pos <= 180; pos += 1) { // goes from 0 degrees to 180 degrees
      // in steps of 1 degree
      myservo.write(pos);              // tell servo to go to position in variable 'pos'
      delay(15);
    }
    for (pos = 180; pos >= 11; pos -= 1) { // goes from 180 degrees to 0 degrees
      myservo.write(pos);              // tell servo to go to position in variable 'pos'
      delay(15);
    }
  
  } else {
    
    myservo.write(11);

    
  }

  Serial.println( digitalRead(buttonPin) );
  
}

