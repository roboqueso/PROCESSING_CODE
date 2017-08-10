/**
 * ArtBox_LaserRadarSweep
 * 
 * - Rotary Encoder : rotate & click
 * - LASER : onClick
 * - SERVO : rotate the Laser Radar
 * - RADAR : UltraSonic for distance
 */

#include <Servo.h>



//  ROTARY ENCODER
#define clkPin 2
#define dtPin 3
#define swPin 4 //  this is the switch for CLICK

//  LASER
#define laserPin 7

//  SERVO
#define servoPin 8

//  ULTRA SONIC
#define trigPin 13
#define echoPin 12


Servo servo;   
int servoMin = 11; //  NOTE: 10???  servo range 0 - 180
int servoMax = 180; //  servo range 0 - 180

int servoAngle = servoMin;  //  11 -> 180
int lastVal = servoMin;
int clkPinLast = HIGH;
int buttonUp = HIGH; //  NOT CLICKED


//  ULTRA SONIC
int maxInches = 20; //  20 ish
long duration, inches, cm;


////////////////////////////////////////////////////////////////
void setup() {

  //  ROTARY ENCODER
  pinMode(clkPin, INPUT);
  pinMode(dtPin, INPUT);
  pinMode(swPin, INPUT);
  
  pinMode(dtPin, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(dtPin), RotateEncoder, CHANGE);
  
  digitalWrite(clkPin, HIGH);

  //  LASER
  pinMode (laserPin, OUTPUT); // define the digital output interface 13 feet

  //  ULTRA SONIC PINS
  pinMode(trigPin, OUTPUT);
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2); 
  pinMode(echoPin, INPUT);

  //  SERVO
  servo.attach(servoPin);
  servo.write(servoMin);

  Serial.begin (115200);
  //  ALL GOOD!
  Serial.println("lasers!");
}


////////////////////////////////////////////////////////////////
void loop() {

  
  //  TODO: update with addInterupt listener?
  //  READ ROTARY ENCODER
  buttonUp = digitalRead(swPin);


/**
 * 
 * TODO : FIX ROTARY ENCODER MODULATION 
 * 
 * 
 */



    if (digitalRead(dtPin) == LOW) 
    {
      servoAngle--;
      
      //  wrap
      if( servoAngle < servoMin ){
        servoAngle = servoMax;  
      }
        
    } else {

      servoAngle++;
      //  wrap
      if( servoAngle > servoMax ){
        servoAngle = servoMin;
      }

    }



  //  ULTRA-SONIC distance detection
  digitalWrite(trigPin, HIGH);
//  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);    

  // Read the signal from the sensor: a HIGH pulse whose
  // duration is the time (in microseconds) from the sending
  // of the ping to the reception of its echo off of an object.
  duration = pulseIn(echoPin, HIGH);

  // convert the time into a distance
  inches = (duration/2) / 74; 
  cm = (duration/2) / 29.1;



  //  LASER
  if( digitalRead(swPin) == 0 )
  {

    //  turn servo before laser
    servo.write( servoAngle );
    delay(10);

    digitalWrite (laserPin, HIGH); // Turn Laser On
  }
  else
  {
    digitalWrite (laserPin, LOW); // Turn Laser Off
  }


  //  BROADCAST TO SERIAL on click
  if( servoAngle != lastVal || buttonUp != clkPinLast ) {


    //  NOTE: be safe, the SG90 TowerPro supports 0 - 180, but it actually freaks out with anything 10 and under
    //  make sure servoAngle is safe within servoMin and servoMax before sending
    servoAngle = ( servoAngle < servoMin ) ? servoMin : servoAngle;
    servoAngle = ( servoAngle > servoMax ) ? servoMax : servoAngle;

    //  SPIT OUT DATA
    //  servoAngle|btnUp|radarMS|radarIN|radarCM
    //  EX: 12|1|4884|33|83
    Serial.println( String(servoAngle) + '|' + String(buttonUp) + '|' + String(duration) + '|' + String(inches) + '|' + String(cm));
  }

  lastVal = servoAngle;
  clkPinLast = buttonUp;
}


void RotateEncoder(){
  
}
