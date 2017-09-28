const char Z = '|';

const int BTN_1 = 2; // btn 1
const int BTN_2 = 3; // btn 1
const int BTN_3 = 4; // btn 1

const int LED_1 = 8; // btn 1
const int LED_2 = 9; // btn 1
const int LED_3 = 10; // btn 1

boolean led1_on = false;
boolean led2_on = false;
boolean led3_on = false;

void setup() {
  
pinMode( BTN_1, INPUT_PULLUP );
pinMode( BTN_2, INPUT_PULLUP );
pinMode( BTN_3, INPUT_PULLUP );

digitalWrite( BTN_1, HIGH );
digitalWrite( BTN_2, HIGH );
digitalWrite( BTN_3, HIGH );


pinMode( LED_1, OUTPUT );
pinMode( LED_2, OUTPUT );
pinMode( LED_3, OUTPUT );

//  LEDs off
digitalWrite( LED_1, LOW );
digitalWrite( LED_2, LOW );
digitalWrite( LED_3, LOW );


  Serial.begin(115200);
}


void loop() {
  //  DEBUG
  Serial.println( String( digitalRead(BTN_1) ) + Z + String( digitalRead(BTN_2) ) + Z + String( digitalRead(BTN_3) ) );

    
  if(led1_on)
    digitalWrite( LED_1, HIGH );
  else
    digitalWrite( LED_1, LOW );

  if(led2_on)
    digitalWrite( LED_2, HIGH );
  else
    digitalWrite( LED_2, LOW );


  if(led3_on)
    digitalWrite( LED_3, HIGH );
  else
    digitalWrite( LED_3, LOW );

  if( digitalRead(BTN_1) == LOW ) led1_on = ! led1_on;
  if( digitalRead(BTN_2) == LOW ) led2_on = ! led2_on;
  if( digitalRead(BTN_3) == LOW ) led3_on = ! led3_on;
  delay(500);
}

