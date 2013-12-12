#ifndef LED_h
#define LED_h

#include "Arduino.h"

class LED {
public:
  // Constructor
  LED( int pinR, int pinG, int pinB );

  // Modification methods
  void set( int valR, int valG, int valB );
  void fade( int duration, int endR, int endG, int endB );
  void fade( int startR, int startG, int startB, int duration, int endR, int endG, int endB );
  void fadeBlocking( int startR, int startG, int startB, int duration, int endR, int endG, int endB );

  // Driver
  void update();

private:
  // Pins
  int pinR;
  int pinG;
  int pinB;

  // Current value
  int valR;
  int valG;
  int valB;

  // Fade variables
  boolean fadeInProgress;
  int fadeDuration;
  unsigned long fadeStartTime;

  int stepTime;

  int endR;
  int endG;
  int endB;

  int diffR;
  int diffG;
  int diffB;

  int steps;
  float stepSizeR;
  float stepSizeG;
  float stepSizeB;

};

#endif





