// adapted from https://github.com/nok/leap-motion-processing/
// Sends 15 features ((x,y,z) tip of each finger) to Wekinator
// sends to port 6448 using /wek/inputs message

import de.voidplus.leapmotion.*;

import oscP5.*;
import netP5.*;

int num=0;
OscP5 oscP5;
NetAddress dest;

LeapMotion leap;
int numFound = 0;

float[] features = new float[15];

void setup() 
{
  size(800, 500, OPENGL);
  background(255);

//OSC
  oscP5 = new OscP5(this, 9000);
  dest = new NetAddress("127.0.0.1", 6448); //May you need to change HERE!!

  leap = new LeapMotion(this);
}

void draw() 
{
  background(255);
  numFound = 0;
  for (Hand hand : leap.getHands ()) 
  {
    numFound++;
    hand.draw();
    for (Finger finger : hand.getFingers()) 
    {
      switch(finger.getType()) 
      {
        case 0:
          // System.out.println("thumb");
          PVector pos = finger.getPosition();
          features[0] = pos.x;
          features[1] = pos.y;
          features[2] = pos.z;
          
          break;
        case 1:
          // System.out.println("index");
                  pos = finger.getPosition();
          features[3] = pos.x;
          features[4] = pos.y;
          features[5] = pos.z;
          break;
        case 2:
          // System.out.println("middle");
                  pos = finger.getPosition();
          features[6] = pos.x;
          features[7] = pos.y;
          features[8] = pos.z;
          break;
        case 3:
          // System.out.println("ring");
                  pos = finger.getPosition();
          features[9] = pos.x;
          features[10] = pos.y;
          features[11] = pos.z;
          break;
        case 4:
          // System.out.println("pinky");
                  pos = finger.getPosition();
          features[12] = pos.x;
          features[13] = pos.y;
          features[14] = pos.z;
          break;
      }
    }
  }
  
// =========== OSC ============
  if (num % 3 == 0) {
     sendOsc();
  }
  num++;
}

//====== OSC SEND ======
void sendOsc() 
{
  OscMessage msg = new OscMessage("/wek/inputs");
  if (numFound > 0) 
  {
    for (int i = 0; i < features.length; i++) 
    {
      msg.add(features[i]);
    }
  } 
  else 
  {
    for (int i = 0; i < features.length; i++) 
    {
      msg.add(0.);
    }
  }
  oscP5.send(msg, dest);
}