//  Reference for Rotate Encoder module

#define PinCLK 2   // Generating interrupts using CLK signal
                    //  NOTE: keep this as 2 for ISR to work

#define PinDT 3    // Reading DT signal
#define PinSW 4    // Reading Push Button switch

#define RotaryMIN   0
#define RotaryMAX   360

volatile boolean TurnDetected;  // need volatile for Interrupts
volatile boolean rotationdirection;  // CW or CCW rotation

int RotaryPosition=0;    // To store Stepper Motor Position
int PrevPosition;     // Previous Rotary position Value to check accuracy


////////////////////////////////////////////////////////////////////////////////////////////
// Interrupt routine runs if CLK goes from HIGH to LOW
void isr ()  {
  delay(4);  // delay for Debouncing
  rotationdirection = (digitalRead(PinCLK)) ? digitalRead(PinDT) : !digitalRead(PinDT);
  TurnDetected = true;
}

////////////////////////////////////////////////////////////////////////////////////////////
//
void setup ()  {

  //  ROTARY ENCODER
  pinMode(PinCLK,INPUT);
  pinMode(PinDT,INPUT);
  pinMode(PinSW,INPUT);
  digitalWrite(PinSW, HIGH); // Pull-Up resistor for switch
  attachInterrupt (0,isr,FALLING); // interrupt 0 always connected to pin 2 on Arduino UNO ( works on Mega2560 )

  Serial.begin(115200);

}

////////////////////////////////////////////////////////////////////////////////////////////
//
void loop ()  {


  // Runs if rotation was detected
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

  
   

  //  SPIT OUT ENCODER POSITION AND CLICK
  Serial.println( String(RotaryPosition) + '|' + String(digitalRead(PinSW)) );

}

