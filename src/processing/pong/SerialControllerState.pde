import java.util.regex.*;

class SerialControllerState{
  boolean buttonPressedPaddleA = false;
  float positionPaddleA = 0.0f;
  boolean buttonPressedPaddleB = false;
  float positionPaddleB = 0.0f;
  
  final float LOG = log(870); // this is the max value I am getting from my paddles
  final float UL = 0.75f;
  final float LL = 0.25f;
  
  Pattern pattern = Pattern.compile("^([0-9]*\\.[0-9]+|[0-9]+)*,([0-9]*\\.[0-9]+|[0-9]+)*,([0-9]*\\.[0-9]+|[0-9]+)*,([0-9]*\\.[0-9]+|[0-9]+)*$");
  
  public void updateState(String serialPortInput) {

    String tmp = serialPortInput.trim();
    
    if (!pattern.matcher(tmp).matches()) {
      System.err.println(String.format("updateState(): discarding invalid frame '%s'", serialPortInput));
      return;
    }
    
    String[] elements = tmp.split(",");
    
    this.buttonPressedPaddleA = elements[0].equals("1");
    float tmpppa = Float.parseFloat(elements[1]);
    this.buttonPressedPaddleB = elements[2].equals("1");
    float tmpppb = Float.parseFloat(elements[3]);

    tmpppa = constrain(log(tmpppa)/LOG, LL, UL);
    tmpppb = constrain(log(tmpppb)/LOG, LL, UL);    

    positionPaddleA = map(tmpppa, LL, UL, 1.0, 0);
    positionPaddleB = map(tmpppb, LL, UL, 1.0, 0);
  }
}
