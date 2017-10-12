# EEG Processing Sub Team
## Information
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Hello, we are a team of four people dedicated to
interpreting the data and running code to interpret the
users mood. Our names are Matt Colozzo, Khanh Nguyen,
Jonathan Pavlik, and Zeke Zhao. Some goals of our team is to be able to identify the brain wave data given to us by the EEG Retrieval team's code. With that data with
then intend to do some tasks such as dispense ice cream
if the user was sad.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Some limiting factors of our team are that our code cannot be 100% tested till the EEG Retrieval teams has their setup ready to go for us. As such we have communicated closely with that team to understand how we will be receiving data from them and getting as close as we possibly can. We can still manually send data to test, and hopefully this allows us to mitigate the amount of changes we need to make at a later date.

## User Stories
<table border="1px solid black">
  <tr>
    <th colspan="3" style="font-size:24px; color:DarkBlue;">Ice Cream Mood</th>
  </tr>
  <tr>
    <td><b>Acceptance Test:</b> IceCreamDispenseMoodTest</td>
    <td><b>Priority:</b> 3 <br>
    Because this was a customer requested feature</td>
    <td><b>Story Points:</b> 1 <br>
    As this is a relatively easy feature to implement </td>
  </tr>
  <tr>
    <td colspan="3">
      <b>User:</b> Is in a sad mood<br>
      <b>Given:</b> The data from the EEG Reading <br>
      <b>Do:</b> Determine the mood is sad</td>
  </tr>
</table>

## Use Cases
##### Use Case 1
- <b>Name:</b> Sad Mood(dispense ice cream)
- <b>Description:</b> User is in a sad mood
- <b>Actors:</b> Customer
- <b>Flow:</b> The customer is wearing the EEG sensor which is connected to the smart home who receives the reading then runs our code to determine mood, then sends signal to dispense ice cream.
- <b>Alt Flow:</b> The user is no longer sad and no longer needs ice cream or more ice cream

## Test Stories
<table border="1px solid black">
  <tr>
    <th colspan="3" style="font-size:24px; color:DarkCyan;">Ice Cream Dispense</th>
  </tr>
  <tr>
    <td><b>Acceptance Test:</b> IceCreamDispenseTest </td>
    <td><b>Priority:</b> 3 <br>
    Because this was a customer requested feature</td>
    <td><b>Story Points:</b> 3 <br>
    As this requires several pieces of hardware to properly communicate to get the ice cream dispensed </td>
  </tr>
  <tr>
    <td colspan="3">
      <b>User:</b> Is in a sad mood<br>
      <b>Given:</b> The data from the EEG Reading <br>
      <b>Do:</b> Determine the mood is sad and send a signal to hardware side who would make sure ice cream is dispensed </td>
  </tr>
</table>
## Source Code
```java
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
```

## Testing Results

#### Test Code
```java
import org.junit.Test;
import static org.junit.Assert.assertEquals;
import org.junit.runner.JUnitCore;
import org.junit.runner.Result;
import org.junit.runner.notification.Failure;

public class TestEEG {

   String emotionalBaggage = [true, false];
   int low_alpha_waves = 35;
   EEGProcessing emotional = new EEGProcessing(emotionalBaggage);

   @Test
   public void testEmotion() {
      assertEquals(emotionalBaggage,emotional.sendData());
      assertEquals(low_alpha_waves, emotional.dispenseIceCream());

   }
}

public class TestRunner {
   public static void main(String[] args) {
      Result result = JUnitCore.runClasses(TestEEG.class);

      for (Failure failure : result.getFailures()) {
         System.out.println(failure.toString());
      }

      System.out.println(result.wasSuccessful());
   }
}

```
#### Test Results
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Issue: Cannot actually test full operation. This is due to needing other teams to be finished before we can fully implement and test our features.
