/*
RadarRangeStep

 - Rotary Encoder ( spin + click )
 - Stepper Motor ( spin the radar )
 - Stepper Motor Driver ( drive the motor )
 - Laser Emitter ( onClick FIRE )
 ( - UltraSonic for distance -> buzzer duration )
*/

//  ROTARY ENCODER
#define clkPin 2
#define dtPin 3
#define swPin 4

 
int change, encoderVal = 0;

int newA, newB;

bool fwd = false;
bool rev = false;

  
//  ULTRA SONIC
//int maxInches = 20; //  20 ish
//long duration, inches;

//////////////////////////////////////////////////////////////////////////////////////////////
void setup()
{


  //  ROTARY ENCODER
  //set clkPin,dePin,swPin as INPUT
  pinMode(clkPin, INPUT);
  pinMode(dtPin, INPUT);
  pinMode(swPin, INPUT);
  digitalWrite(swPin, HIGH);


  Serial.begin(115200);
  
  //  ALL GOOD!
  Serial.println("go");
} 


//////////////////////////////////////////////////////////////////////////////////////////////
void loop()
{  

  newA = digitalRead(clkPin);//read the value of clkPin to newA
  newB = digitalRead(dtPin);//read the value of dtPin to newB

  fwd = (bool)newA;
  rev = (bool)newB;

if( fwd && fwd!=rev )
{
  //  FWD  
  encoderVal++;
}
else if ( rev & fwd!=rev )
{
  //  REV  
  encoderVal--;
}
else
{
  //  no change
}

Serial.println( String( newA ) + '|' + String( newB ) + '|' +String( digitalRead(swPin) ) + '|' + String(encoderVal) ); //read the value of clkPin to newA

    //  SPIT OUT DATA
    //  duration|inches|joyX|joyY|joyButtonUp
//    Serial.println( String(duration) + '|' + String(inches) + '|' + String(joyX) + '|' + String(joyY) + '|' + String(joyButton));

//  }


  delay(250);
}


//////////////////////////////////////////////////////////////////////////////////////////////
//  for ROTARY ENCODER
int getEncoderTurn(void)
{
  static int oldA = HIGH; //set the oldA as HIGH
  static int oldB = HIGH; //set the oldB as HIGH
  int result = 0;
  int newA = digitalRead(clkPin);//read the value of clkPin to newA
  int newB = digitalRead(dtPin);//read the value of dtPin to newB
  if (newA != oldA || newB != oldB) //if the value of clkPin or the dtPin has changed
  {
    // something has changed
    if (oldA == HIGH && newA == LOW)
    {
    result = (oldB * 2 - 1);
    }
  }
  oldA = newA;
  oldB = newB;

  return result;
}
