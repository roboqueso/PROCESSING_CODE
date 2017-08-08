/*
ART BOX v1

"Theremin"
 - near / far
 - passive buzer
*/

#define trigPin 3
#define echoPin 2
#define buzzerPin 12

int maxInches = 20; //  20 - 24ish
int freq, freqAdj = 3276;
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

  
  delay(100);
  
  Serial.println("SETUP COMPLETE!");
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
  if(inches >= maxInches)
  {
//    Serial.print("TOO FAR FROM SENSOR \n");

  }
  else
  {
    
    //  DO STUFF
    Serial.println( String(duration) + '|' + String(inches));

  }


  delay(250);
}
