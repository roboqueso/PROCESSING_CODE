
/**
 * LaserRadarButtonSweep
 * 
 * - Rotary Encoder : rotate & click
 * - LASER : onClick
 * - SERVO : rotate the Laser Radar
 * - RADAR : UltraSonic for distance
 * - BUTTON : Toggle SWEEP mode
 */

#include <Servo.h>
//  TODO: checkout SoftwareServo library?


//  ROTARY ENCODER
#define PinCLK 2   // Generating interrupts using CLK signal. NOTE: keep this as 2 for ISR to work
#define PinDT 3    // Reading DT signal
#define PinSW 4    // Reading Push Button switch

//  NOTE: MIN and MAX come from SG90 TowerPro Servo motor
#define RotaryMIN   11
#define RotaryMAX   180

//  LASER
#define laserPin 5

//  SERVO
#define servoPin 8  //  ORANGE wire
//  Vcc             //  RED wire
//  Ground          //  BROWN wire

//  ULTRA SONIC
//  Vcc             //  ORANGE wire
#define trigPin 13  //  GREEN wire
#define echoPin 12  //  BLUE wire
//  Gnd             //  GRAY wire

//  BUTTON
#define buttonPin  6

Servo servo;   

volatile boolean TurnDetected;  // need volatile for Interrupts
volatile boolean rotationdirection;  // CW or CCW rotation

int RotaryPosition=0;    // To store Stepper Motor Position
int PrevPosition;     // Previous Rotary position Value to check accuracy


//  ULTRA SONIC
int maxInches = 20; //  20 ish
long duration,inches, cm;


////////////////////////////////////////////////////////////////////////////////////////////
// Interrupt routine runs if CLK goes from HIGH to LOW
void isr ()  {
  delay(4);  // delay for Debouncing
  rotationdirection = (digitalRead(PinCLK)) ? digitalRead(PinDT) : !digitalRead(PinDT);
  TurnDetected = true;
}



////////////////////////////////////////////////////////////////
void setup() {

  //  ROTARY ENCODER
  pinMode(PinCLK,INPUT);
  pinMode(PinDT,INPUT);
  pinMode(PinSW,INPUT);
  digitalWrite(PinSW, HIGH); // Pull-Up resistor for switch
  attachInterrupt (0,isr,FALLING); // interrupt 0 always connected to pin 2 on Arduino UNO ( works on Mega2560 )

  //  LASER
  pinMode (laserPin, OUTPUT); // define the digital output interface 13 feet

  //  ULTRA SONIC PINS
  pinMode(trigPin, OUTPUT);
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2); 
  pinMode(echoPin, INPUT);

  //  SERVO
  servo.attach(servoPin);
  servo.write(RotaryMIN);

  //  BUTTON
  pinMode(buttonPin, INPUT);

  Serial.begin (115200);
  //  ALL GOOD!
  Serial.println("lasers!");

  RotaryPosition = RotaryMIN;
}


////////////////////////////////////////////////////////////////
void loop() 
{
  duration = distance();

  // convert the time into a distance
  inches = (duration/2) / 74; 
  cm = (duration/2) / 29.1;
  
  //  READ ROTARY ENCODER if rotation detected
  if (TurnDetected) 
  {
    PrevPosition = RotaryPosition; // Save previous position in variable

    //  FWD or REV?
    if (rotationdirection) 
      RotaryPosition++;
    else
      RotaryPosition--;
    
    //  RotaryPosition constrain - don't let RotaryPosition go below MIN or above MAX
    //  NOTE: This means the rotary position does NOT reset once you hit MIN or MAX.
    //  If you hit MIN, you stay at MIN no matter how many times you turn left
    RotaryPosition = constrain( RotaryPosition, RotaryMIN, RotaryMAX );
    
    TurnDetected = false;  // do NOT repeat IF loop until new rotation detected
  }


  //  buttonClick : SWEEP
  //  SWEEP?
  if( digitalRead(buttonPin) == 1 )
  {

    //  LASER ON
    digitalWrite (laserPin, HIGH); // Turn Laser On
    
    //  FORWARD
    for (int pos = RotaryMIN; pos <= RotaryMAX; pos += 2) 
    {
      //  check for loop break
      if(digitalRead(PinSW) == 0) break;

      //  turn servo
      servo.write(pos);  
      delay(150);
      
      //  re-calc distance
      duration = distance();
      RotaryPosition = pos;

      //  spit out data
      broadcast();
    }

    //  BACKWARDS
    for (int pos = RotaryMAX; pos >= RotaryMIN; pos -= 2)
    {
      //  check for loop break
      if(digitalRead(PinSW) == 0) break;

      //  turn servo
      servo.write(pos);  
      delay(150);
      
      //  re-calc distance
      duration = distance();
      RotaryPosition = pos;

      //  spit out data
      broadcast();
    }
  }

  //  encoderClick : TURN & LASER
  //  ONLY LASER OF BUTTON NOT SWEEPING AND ROTATORCLICKED
  else if( digitalRead(buttonPin) == 0 && digitalRead(PinSW) == 0 )
  {

    distance();
    
    if( RotaryPosition != PrevPosition ) {
      
      //  turn servo before laser
      servo.write( RotaryPosition );
    }

    digitalWrite (laserPin, HIGH); // Turn Laser On
    
  }
  else
  {
    //  TURN OFF LASER
    digitalWrite (laserPin, LOW); // Turn Laser Off
  }



  //  BROADCAST TO SERIAL on click
  if( RotaryPosition != PrevPosition || digitalRead(PinSW) == 0 ) {

    broadcast();
  }


  delay(100);

}

//////////////////////////////////////////////////////////////////////////////////////////
//  
long distance(){


    //  ULTRA-SONIC distance detection
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);    

  // Read the signal from the sensor: a HIGH pulse whose
  // duration is the time (in microseconds) from the sending
  // of the ping to the reception of its echo off of an object.
//  duration = pulseIn(echoPin, HIGH);
  return  pulseIn( echoPin, HIGH );

  
}


//////////////////////////////////////////////////////////////////////////////////////////
//  
void broadcast()
{

  // convert the time into a distance
  inches = (duration/2) / 74; 
  cm = (duration/2) / 29.1;

  
      //  SPIT OUT DATA
    //  RotaryPosition|btnUp|radarMS|radarIN|radarCM
    //  EX: 12|1|4884|33|83
    Serial.println( String(RotaryPosition) + '|' + String(digitalRead(PinSW)) + '|' + String(duration) + '|' + String(inches) + '|' + String(cm));
  
  }
