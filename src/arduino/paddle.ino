const int PADDLE_A_BTN_PORT = A0;
const int PADDLE_B_BTN_PORT = A1;
const int PADDLE_A_POS_PORT = A2;
const int PADDLE_B_POS_PORT = A3;

const int DELAY_BETWEEN_READS_MS = 2;
const int BTN_READS = 3; // number of analog reads > 0 to report a button press
const int POS_READS = 10; // number of analog reads to average to give the position

int read_button(int port) {
  int zeroes = 0;
  for(int reading=0; reading <BTN_READS; reading++){
    int read = analogRead(port);
    delay(DELAY_BETWEEN_READS_MS);
    if(read==0) zeroes++;
  }
  return(zeroes==BTN_READS?1:0);
}

float read_position(int port){
  int sum = 0;
  for(int i=0; i<POS_READS; i++){
    sum += analogRead(port);
    delay(DELAY_BETWEEN_READS_MS);
  }
  return (sum/POS_READS);
}

void setup() {
  Serial.begin(115200);
}

void loop() {
  Serial.print(read_button(PADDLE_A_BTN_PORT));
  Serial.print(",");
  Serial.print(read_position(PADDLE_A_POS_PORT));
  Serial.print(",");
  Serial.print(read_button(PADDLE_B_BTN_PORT));
  Serial.print(",");
  Serial.print(read_position(PADDLE_B_POS_PORT));
  Serial.println();
}
