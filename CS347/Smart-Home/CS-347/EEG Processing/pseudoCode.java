public class EEGProcessing {

    public someObj interpretData() {
	//converts from the format the data is given to a more readable format
	//for us to use
	//store in an object and return it
	//we could just check the data here... using function calls instead of
	//returning an object


	//assuming second method
	//determine which waves are the dominant and controling the mood
	//figure that out next itme
    }
    /*
     *This part of the code takes in the pre-processed brainwaves in a JSON(?) format
     *and then interprets the data in order to send the proper signals to the smart 
     *home device (The raspberry pi)
     */
    public static void main(string[] args) {
	//pseudo code since we don't have the retrieval teams class
	EEGRetrieval data = new EEGRetrieval();
	boolean iceCream = false, correctUser = false, etc = false;
	//while there are brainwaves coming in run the loop
	while(data.waves) {
	    //either they auto update or we do it manually
	    data = new EEGRetrieval();
	    interpretData(data);
	    //give data to hardware team in readable format
	    //can give a number in binary so its for them to read
	    //each digit corresponds to a function that the hardware
	    //team should run
	    //thats one possibility
	} 
	
    }
    
}
