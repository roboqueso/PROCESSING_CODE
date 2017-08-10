#include <Servo.h>



//  ROTARY ENCODER
#define clkPin 2
#define dtPin 3
#define swPin 4

//  LASER
#define laserPin 7

//  SERVO
#define servoPin 8
Servo servo;   
int servoAngle = 0;   // servo position in degrees
int servoMin = 11; //  NOTE: 10???  servo range 0 - 180
int servoMax = 180; //  servo range 0 - 180

int val = servoMin;
int lastVal = servoMin;
int clkPinLast = LOW;
int n = LOW;



////////////////////////////////////////////////////////////////
void setup() {

  //  ROTARY ENCODER
  pinMode(clkPin, INPUT);
  pinMode(dtPin, INPUT);

  pinMode(swPin, INPUT);
  digitalWrite(swPin, HIGH);

  //  LASER
  pinMode (laserPin, OUTPUT); // define the digital output interface 13 feet

  //  SERVO
  servo.attach(servoPin);
  servo.write(servoMin);

  Serial.begin (115200);
}


////////////////////////////////////////////////////////////////
void loop() {
  

  //  TODO: update with addInterupt listener?
  //  READ ROTARY ENCODER
  n = digitalRead(clkPin);
  if ((clkPinLast == LOW) && (n == HIGH)) 
  {
    if (digitalRead(dtPin) == LOW) 
    {
      val--;
      
      //  wrap
      if( val < servoMin ){
        val = servoMax;  
      }
        
    } else {

      val++;
      //  wrap
      if( val > servoMax ){
        val = servoMin;
      }

    }

  }

  //  LASER
  if( digitalRead(swPin) == 0 )
  {


    //  turn servo before laser
    servo.write( val );
    delay(10);

    digitalWrite (laserPin, HIGH); // Turn Laser On
  }
  else
  {
    digitalWrite (laserPin, LOW); // Turn Laser Off
  }

  //  BROADCAST TO SERIAL
  if( val != lastVal || digitalRead(swPin) == 0 ) {


    //  NOTE: be safe, the SG90 TowerPro supports 0 - 180, but it actually freaks out with anything 10 and under
    //  make sure val is safe within servoMin and servoMax before sending
    val = ( val < servoMin ) ? servoMin : val;
    val = ( val > servoMax ) ? servoMax : val;
    
    Serial.println( String(val) + '|' + String(digitalRead(swPin)) );
  }

  lastVal = val;
  clkPinLast = n;
}
