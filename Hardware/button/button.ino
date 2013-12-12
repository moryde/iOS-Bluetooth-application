#include <Bounce.h>
#include <JeeLib.h>

#include "LED.h"

// RF Config
#define RF_ID 10
//#define RF_ID_RANDOM //Enable for random ID (0-29)
#define RF_GRP 5
#define RF_BUFFER_SIZE 66

// RF HUB Config
#define RF_HUB_ID 1

// Config
#define LED_R_PIN 6
#define LED_G_PIN 3
#define LED_B_PIN 5
#define BUTTON_PIN 4
#define BUTTON_DEBOUNCE 5
#define SERIAL_BAUD 57600

LED led = LED( LED_R_PIN, LED_G_PIN, LED_B_PIN );
Bounce button = Bounce( BUTTON_PIN, BUTTON_DEBOUNCE );

// True if this needs to transmit
static boolean transmit = false;

static byte length;
static byte buffer[RF_BUFFER_SIZE];

void setup() {
  led.set(0, 255, 0);
  Serial.begin(SERIAL_BAUD);

  // RF setup
    Serial.println("LOL1");

  rf12_initialize(RF_ID, RF12_433MHZ, RF_GRP);
  Serial.println("LOL");
  // Print config
  Serial.print("Button booted. Group:");
  Serial.print(RF_GRP);
  Serial.print(" ID:");
  Serial.print(RF_ID);
  Serial.print(" HubID:");
  Serial.println(RF_HUB_ID);

  // Started
  led.fade(5, 0, 0, 0);
}

void loop() {
  led.update();
  
  if( button.update() ) {
    if( button.read() ) {
      Serial.println("Button pressed");
#ifdef RF_ID_RANDOM
      buffer[0] = random(30);
#else
      buffer[0] = RF_ID;
#endif
      length = 1;
      transmit = true;
    }
  }

  if (transmit && rf12_canSend()) {
    Serial.println("Transmitting...");

    // Sets destination bit and destination
    byte header = RF12_HDR_DST | RF_HUB_ID; 
    rf12_sendStart(header, buffer, length);

    transmit = false;
  }

  if (rf12_recvDone()) {
    if (rf12_crc == 0) {
      Serial.println("Receiving...");
      if ( rf12_len == 3 ) {
        // LED Set color
        led.set( rf12_data[0], rf12_data[1], rf12_data[2] );
        Serial.print("LED:");
        for ( int i = 0; i < rf12_len; i++ ) {
          Serial.print(" ");
          Serial.print(rf12_data[i], HEX);
        }
        Serial.println();
      }  
      else if ( rf12_len == 4 ) {
        // LED Fade, no prev. color
        led.fade( rf12_data[0], rf12_data[1], rf12_data[2], rf12_data[3] );
      } 
      else if ( rf12_len == 7 ) {
        // LED Fade, prev. color
        led.fade( rf12_data[0], rf12_data[1], rf12_data[2], rf12_data[3], rf12_data[4], rf12_data[5], rf12_data[6] );
      }
      else {
        Serial.println("Undefined packet received.");
        printPacket();
      }
    } 
    else {
      Serial.println("Received bad packet");
      printPacket( 15 );
    }
  }
}

void printPacket() {
  // Print RF12_MAXDATA data
  printPacket( RF12_MAXDATA );
}

void printPacket(int dataLimit) {
  Serial.print("Header: ");
  for (byte i = 0; i < 3; ++i) {
    Serial.print(" 0x");
    Serial.print(rf12_buf[i], HEX);
  }
  Serial.println();

  Serial.print("Data:   ");
  for (byte i = 0; i < rf12_len; ++i) {
    Serial.print(" 0x");
    Serial.print(rf12_data[i], HEX);

    // Cap packet length
    if ( i > dataLimit ) {
      Serial.print("...");
      break;
    }
  }
  Serial.println();
}





