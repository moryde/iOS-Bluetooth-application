#include <JeeLib.h>
#include <Wire.h>

// RF Config
#define RF_ID 1
#define RF_GRP 5
#define RF_BUFFER_SIZE 66

// Config
#define I2C_ADDR 2
#define I2C_BUFF_SIZE 10
#define SERIAL_BAUD 57600

// ID of last pressed button. 0 = empty
static int button_id = 0;

// True if this needs to transmit
static boolean transmit = false;

static byte header;
static byte length;
static byte buffer[RF_BUFFER_SIZE];

void setup() {
  Serial.begin(SERIAL_BAUD);

  // RF setup
  rf12_initialize(RF_ID, RF12_433MHZ, RF_GRP);  

  // I2C setup and registration
  Wire.begin(I2C_ADDR);
  Wire.onReceive(wireWriteEvent);
  Wire.onRequest(wireReadEvent);

  // Print config
  Serial.print("Hub booted. Group:");
  Serial.print(RF_GRP);
  Serial.print(" ID:");
  Serial.println(RF_ID);
}

void loop() {
  if (transmit && rf12_canSend()) {
    Serial.println("Transmitting...");
    rf12_sendStart(header, buffer, length);
    transmit = false;
    Serial.println(length);
  }

  if (rf12_recvDone()) {
    if (rf12_crc == 0) {
      Serial.println("Receiving...");
      if ( rf12_len == 1 ) {
        // Double as 'button pressed' and 'pong'
        button_id = rf12_data[0];
        Serial.print("Button pressed on: ");
        Serial.println(button_id);
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

// LED change
void wireWriteEvent(int howMany) {
  Serial.print("Wire write... ");

  // Read into buffer
  char data[I2C_BUFF_SIZE];
  int count = 0;
  while( 0 < Wire.available() && count < I2C_BUFF_SIZE ) {
    data[count] = Wire.read();
    count++;
  }

  // Read data
  if ( count == 4 | count == 5 | count == 8 ) {
    int id = data[0];
    int ledValueR = data[1];
    int ledValueG = data[2];
    int ledValueB = data[3];

    // Sets destination bit and destination    
    header = RF12_HDR_DST | id;

    transmit = true;
    Serial.println("OK");
    if ( count == 4 ) {
      // LED Set color
      buffer[0] = ledValueR;
      buffer[1] = ledValueG;
      buffer[2] = ledValueB;
      length = 3;
    } 
    else if ( count == 5 ) {
      // LED Fade, no prev. color
      int duration = data[1];
      int endR = data[2];
      int endG = data[3];
      int endB = data[4];    
      buffer[0] = duration;
      buffer[1] = endR;
      buffer[2] = endG;
      buffer[3] = endB;
      length = 4;
    } 
    else if ( count == 8 ) {
      // LED Fade, prev. color
      int duration = data[4];
      int endR = data[5];
      int endG = data[6];
      int endB = data[7];    
      buffer[0] = ledValueR;
      buffer[1] = ledValueG;
      buffer[2] = ledValueB;
      buffer[3] = duration;
      buffer[4] = endR;
      buffer[5] = endG;
      buffer[6] = endB;
      length = 7;
    } 
  } else if ( count == 1 ) {
    // Ping command
    int id = data[0];

    // Sets destination bit and destination    
    header = RF12_HDR_DST | id;   
    transmit = true;
    
    // Payload
    buffer[0] = true;
    length = 1;
    
    Serial.println("OK");
  }
  else {
    Serial.print( "Bad: " );
    for( int i = 0; i < count; i++ ) {
      Serial.print(" 0x");
      Serial.print(data[i], HEX);
    }
    Serial.println();
  }
}

// Button pressed ?
void wireReadEvent() {
  Wire.write(button_id);
  button_id = 0;
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
