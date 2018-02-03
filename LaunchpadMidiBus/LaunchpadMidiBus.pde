import themidibus.*; //Import the library
import javax.sound.midi.MidiMessage; //Import the MidiMessage classes http://java.sun.com/j2se/1.5.0/docs/api/javax/sound/midi/MidiMessage.html
import javax.sound.midi.SysexMessage;
import javax.sound.midi.ShortMessage;

MidiBus myBus; // The MidiBus
Boolean isDown = false;

void setup() {
  size(400, 400);
  background(0);

  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

  // Either you can
  //                   Parent In Out
  //                     |    |  |
  //myBus = new MidiBus(this, 0, 1); // Create a new MidiBus using the device index to select the Midi input and output devices respectively.

  // or you can ...
  //                   Parent         In                   Out
  //                     |            |                     |
  //myBus = new MidiBus(this, "IncomingDeviceName", "OutgoingDeviceName"); // Create a new MidiBus using the device names to select the Midi input and output devices respectively.

  // or for testing you could ...
  //                 Parent  In        Out
  //                   |     |          |
  //myBus = new MidiBus(this, -1, "Java Sound Synthesizer"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  myBus = new MidiBus(this, "Launchpad MK2", "Launchpad MK2"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  //myBus = new MidiBus(this, 0, 0); // Create a new MidiBus object
}

void draw() {
  //   176, 0, 32
  int channel = 2;
  int pitch = (int)( (frameCount+10)%112 );
//println(pitch);
  int velocity = (int)frameCount%255;

  myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
  delay(200);
  myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff

  //int number = 0;
  //int value = (int)random(80,180);

  //myBus.sendControllerChange(channel, number, value ); // Send a controllerChange
  //delay(200);
}


// Notice all bytes below are converted to integeres using the following system:
// int i = (int)(byte & 0xFF) 
// This properly convertes an unsigned byte (MIDI uses unsigned bytes) to a signed int
// Because java only supports signed bytes, you will get incorrect values if you don't do so
/*
void rawMidi(byte[] data) { // You can also use rawMidi(byte[] data, String bus_name)
  // Receive some raw data
  // data[0] will be the status byte
  // data[1] and data[2] will contain the parameter of the message (e.g. pitch and volume for noteOn noteOff)
  println();
  println("Raw Midi Data:");
  println("--------");
  println("Status Byte/MIDI Command:"+(int)(data[0] & 0xFF));
  // N.B. In some cases (noteOn, noteOff, controllerChange, etc) the first half of the status byte is the command and the second half if the channel
  // In these cases (data[0] & 0xF0) gives you the command and (data[0] & 0x0F) gives you the channel
  for (int i = 1;i < data.length;i++) {
    println("Param "+(i+1)+": "+(int)(data[i] & 0xFF));
  }
}
*/
void midiMessage(MidiMessage message) { // You can also use midiMessage(MidiMessage message, long timestamp, String bus_name)
  // Receive a MidiMessage
  // MidiMessage is an abstract class, the actual passed object will be either javax.sound.midi.MetaMessage, javax.sound.midi.ShortMessage, javax.sound.midi.SysexMessage.
  // Check it out here http://java.sun.com/j2se/1.5.0/docs/api/javax/sound/midi/package-summary.html
  println();
  println("MidiMessage Data:");
  println("--------");
  println("Status Byte/MIDI Command:"+message.getStatus());
  for (int i = 1;i < message.getMessage().length;i++) {
    println("Param "+(i+1)+": "+(int)(message.getMessage()[i] & 0xFF));
  }
  
  /*
Message type Hex version Decimal version
Note off 80h, Key, Velocity 128, Key, Velocity
Note on 90h, Key, Velocity 144, Key, Velocity
  */
        textSize(42);
  switch(message.getStatus()){
    //  off
    case 128:
    {
      fill(255,0,0);
      text("OFF", width/2, height/2);
    }
    break;
  
    //  oN
    case 144:
    {
      fill(0,255,0);
      text("ON", width/2, height/2);
    }
    break;
  
  }
  
}



void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}