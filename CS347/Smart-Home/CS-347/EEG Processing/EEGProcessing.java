public class EEGProcessing {

  //create array of booleans for raspberry pi to read
  static int[] sendData(boolean sad, boolean happy) {
    int s = (sad) ? 1 : 0;
    int b = (happy) ? 1 : 0;
    int[] emotionArray = {s, b};
    return emotionArray;
  }

  //check if sad
  boolean dispenseIceCream(int brainwaves) {
    if(brainwaves < 38 && brainwaves > 30) {
      return true;
    }
    return false;
  }

  public static void main(string[] args) {
    //class object from other team
    //assuming its in same file location
    EEGRetrieval data = new EEGRetrieval();
    //initialization don't assume emotions
    boolean sad = false, happy = false;
    //check if user is wearing
    while(data.waves != 0) {
      //update waves(it might do this automatically)
      data = new EEGRetrieval();
      sad = dispenseIceCream(data.waves);

      //at end send info
      sendData(sad, happy);
    }
  }
}
