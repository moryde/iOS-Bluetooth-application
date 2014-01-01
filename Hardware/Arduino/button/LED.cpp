#include "LED.h"

LED::LED( int pinR, int pinG, int pinB ) {
  this->pinR = pinR;
  this->pinG = pinG;
  this->pinB = pinB;
  pinMode( this->pinR, OUTPUT );
  pinMode( this->pinG, OUTPUT );
  pinMode( this->pinB, OUTPUT );

}

void LED::set( int valR, int valG, int valB ) {
  this->valR = valR;
  this->valG = valG;
  this->valB = valB;
  analogWrite( this->pinR, this->valR );
  analogWrite( this->pinG, this->valG );
  analogWrite( this->pinB, this->valB );
}

void LED::fade( int duration, int endR, int endG, int endB ) {
  this->fade( this->valR, this->valG, this->valB, duration, endR, endG, endB );
}

void LED::fade( int startR, int startG, int startB, int duration, int endR, int endG, int endB ) {
  this->fadeInProgress = true;
  this->fadeStartTime = millis();
  this->steps = 100;

  this->set( startR, startG, startB );

  this->fadeDuration = duration;

  this->endR = endR;
  this->endG = endG;
  this->endB = endB;

  this->diffR = this->endR - startR;
  this->diffG = this->endG - startG;
  this->diffB = this->endB - startB;

  this->stepSizeR = (float) diffR / steps;
  this->stepSizeG = (float) diffG / steps;
  this->stepSizeB = (float) diffB / steps;

  // To ms, and then to step time
  int stepTime = (float) duration * 1000 / 100;
}

void LED::update() {
  if (!this->fadeInProgress) {
    return;
  }

  // How much time has been used fading so far
  int fadeProgressTime = millis() - this->fadeStartTime;

  // Fade progressed from 0.0 to 1.0
  double fadeProgress = fadeProgressTime / (this->fadeDuration * 1000.0);

  // Steps left
  double stepsLeft = (1.0 - fadeProgress) * this->steps;

  // End color - what still lies ahead = current
  int valR = this->endR - (stepsLeft * this->stepSizeR);
  int valG = this->endG - (stepsLeft * this->stepSizeG);
  int valB = this->endB - (stepsLeft * this->stepSizeB);

  // Set color (Not needed for fade to work, but enables one to make a new fade during a current fade).
  this->set( valR, valG, valB );

  // Stop fade if done
  if ( fadeProgress > 1.0 ) {
    this->fadeInProgress = false;
    this->set( this->endR, this->endG, this->endB );
  }

}

void LED::fadeBlocking( int startR, int startG, int startB, int duration, int endR, int endG, int endB ) {
  int steps = 100;

  int diffR = endR - startR;
  int diffG = endG - startG;
  int diffB = endB - startB;

  float stepSizeR = (float) diffR / steps;
  float stepSizeG = (float) diffG / steps;
  float stepSizeB = (float) diffB / steps;

  // To ms, and then to step time
  int stepTime = (float) duration * 1000 / 100;

  for ( int i = 0; i < steps; i++ ) {
    //TODO: Recalculate the step value on the fly: Will eliminate that it gets more and more off.
    analogWrite( this->pinR, this->valR + (stepSizeR *i) );
    analogWrite( this->pinG, this->valG + (stepSizeG *i) );
    analogWrite( this->pinB, this->valB + (stepSizeB *i) );
    delay( stepTime );
  }

  this->set( endR, endG, endB );
}




