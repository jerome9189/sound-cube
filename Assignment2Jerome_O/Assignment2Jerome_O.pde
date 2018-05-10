// ANN demo.
//RGB Output.
// Haein Kang, 2018

//OSC
import oscP5.*;
import netP5.*;  
import processing.sound.*;
SoundFile[] file = new SoundFile[27];
OscP5 oscP5;
NetAddress dest;

String message = "Waiting...";
float[] amplitudes = new float[27];

void setup() 
{
  size(400,400);
  
  //Initialize OSC communication
  oscP5 = new OscP5(this, 12000); //listen for OSC messages on port 12000 (Wekinator default)
  dest = new NetAddress("127.0.0.1",6449); //send messages back to Wekinator on port 6448, localhost (this machine) (default)
  file[0] = new SoundFile(this, "rain.mp3");
  file[0].loop();
  file[1] = new SoundFile(this, "thunder.mp3");
  file[1].loop();

}

void draw() 
{
  //background(r, g, b);
  fill(255);
  textSize(56);
  textAlign(CENTER);
  //text(message, 200, 200);
}

//OSC EVENT
void oscEvent(OscMessage theOscMessage) 
{
  if (theOscMessage.checkAddrPattern("/wek/outputs") == true) 
  {
    if(theOscMessage.checkTypetag("fffffffffffffffffffffffffff")) 
    {
      for(int i = 0; i < 2; i++) {
        file[i].amp(theOscMessage.get(i).floatValue());
      }
      
    } 
  }
  else
  {
    message = "Waiting...";
  }
}
