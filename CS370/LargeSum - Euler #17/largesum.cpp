#include <iostream>
#include <cstring>
#include <stdio.h>
#include <cstdlib>
#include <fstream>
using namespace std;

#define toDigit(c) (c-'0')

int main() {
	int linecount = 0;
	string val;
	int valLength = 0;
	int maxLen = 50;
	char numbers[200][50];
	char sum[52];

	ifstream myfile ("input.txt");
	if(myfile.is_open()) {
		while(getline(myfile,val)) {
			valLength = val.length();

			// moves string input value to a char array
			// of size 50 with
			for(int i=0, j=0; i < maxLen; i++){
				if(i < 50-valLength){
					numbers[linecount][i]= '0';
				}
				else{
					numbers[linecount][i] = val[j++];
				}
			}
			linecount++;
		}
		myfile.close();
	} else {
		cout << "Unable to open file";
	}

	// addition using carry over method
	string totalSum = "";
	int smallSum = 0;
	int carry = 0;
	int currDigit;

	//iterate through digits 49 through 0
	for(int i=maxLen-1; i >=0; i--){
		smallSum = 0;
		//iterate through each number
		for(int j=0; j < linecount; j++){
			smallSum += toDigit(numbers[j][i]);
		}
		smallSum += carry;
		currDigit = smallSum % 10;
		carry = (smallSum-currDigit)/10;

		if(i == 0){
			totalSum = to_string(smallSum) + totalSum;
		} else {
			totalSum = to_string(currDigit) + totalSum;
		}
	}

	//remove '0' padding from totalSum
	string firstTenDigits = "";
	bool hasPadding = false;
	if(totalSum[0] == '0'){
		hasPadding = true;
	}
	while(hasPadding && totalSum.length() > 1){
		totalSum = totalSum.substr(1);
		if(totalSum[0] != '0'){
			hasPadding = false;
		}
	}

	firstTenDigits = totalSum.substr(0,10);

	cout << "Full sum: " << totalSum << endl;
	cout << "First 10 digits: " << firstTenDigits << endl;

	return 0;
}
