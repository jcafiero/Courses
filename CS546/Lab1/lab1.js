/****
Author: Jennifer Cafiero
Date: September 3, 2017
CS546 - Web Programming
Lab 1 - An Intro to Node

I pledge my honor that I have abided by the Stevens Honor System.
****/

function sumOfSquares(num1, num2, num3) {
  /* Given three integers, this function will compute and return the sum of the three inputs squared */
  if ((!Number.isInteger(num1)) || (!Number.isInteger(num2)) || (!Number.isInteger(num3))){
    throw "Error: one of the arguments is not an integer";
  }
  return num1 * num1 + num2 * num2 + num3 * num3;
}

function sayHelloTo(firstName, lastName, title){
  /* Given up to three string inputs, this function will take the input and greet the user accordingly*/
  if ((typeof firstName =='string') && (typeof lastName == 'string') && (typeof title == 'string')) {
    console.log('Hello, ${title} ${firstName} ${lastName}! Have a good evening!');
  }
  else if ((typeof lastName != 'undefined')) {
    if ((typeof firstName == 'string') && (typeof lastName == 'string')) {
      console.log('Hello, ${firstName} ${lastName}. I hope you are having a good day!');
    }
    else {
      throw "Error: either the last name is not a string";
    }
  }
  else if ((typeof firstName != 'undefined')) {
    if (typeof firstName == 'string') {
      console.log('Hello, ${firstName}!');
    }
    else {
      throw "Error: the first name is not a string";
    }
  }
  else {
    throw "Error: the function must have at least a first or a last name";
  }
}


function cupsOfCoffee(howManyCups) {
  /*Given an input number, this function will sing(return) a song for the user decrementing the value of the cupsofCoffee and adjusting grammar accordingly*/
  var output = 0;
  if (!Number.isInteger(howManyCups)) {
    throw "Error: the argument is not an integer";
  }
  if (howManyCups < 1) {
    throw "Error: the argument must be an integer greater than 1";
  }
  for (i = howManyCups; i > 0; i--) {
    if (i == 1) {
      output = output + i + " cup of coffee on the desk! " + i + " cup of coffee!\n" + "Pick it up, drink the cup, no more coffee left on the desk!";
    }
    else {
      if (i - 1 == 1) {
        output = output + i + " cups of coffee on the desk! " + i + " cups of coffee!\n" + "Pick one up, drink the cup, " + (i - 1) + " cup of coffee on the desk!\n\n";
      }
      else{
        output = output + i + " cups of coffee on the desk! " + i + " cups of coffee!\n" + "Pick one up, drink the cup, " + (i - 1) + " cups of coffee on the desk!\n\n";
      }
    }
  }
  return output;
}

function occurrencesOfSubstring(fullString, substring) {
  /*Given an input string and a desired substring, this function will calculate and return how many times the substring is found in the main string */
  if ((typeof fullString != 'string') || (typeof substring != 'string')) {
    throw "Error: at least one of the arguments is not a string";
  }
  var i = 0;
  var occurrences = 0;
  while (true) {
    i = fullString.indexOf(substring, i);
    if (i >= 0) {
      occurrences++;
      i++;
    }
    else {
      break;
    }
  }
  return occurrences;
}

var paragraph = " Hello, world! I am a paragraph. You can tell that I am a paragraph because there are multiple sentences that are split up by punctuation marks. Grammar can be funny, so I will only put in paragraphs with periods, exclamation marks, and question marks -- no quotations.";

function randomizeSentences(paragraph){
  /*Given a paragraph, this function will randomize the order of the sentences and return the randomized paragraph*/
  if (typeof paragraph != 'string') {
    throw "Error: The argument is not a string";
  }
  if (paragraph.length < 1) {
    throw "Error: The argument needs at least one sentence in order to randomize";
  }

  var sentences = [];
  var index = 0;
  var randomized = "";
  for (var i = 0; i < paragraph.length; i++){
    if ((paragraph[i] == '.') || (paragraph[i] =='?') || (paragraph[i] == '!')) {
      sentences.push(paragraph.substring(index, ++i));
      index = i;
    }
  }
  while (sentences.length > 0) {
    var temp = Math.floor(Math.random() * sentences.length - 1) + 1;
    randomized = randomized.concat(sentences[temp]);
    sentences.splice(temp, 1);
  }
  return randomized;
}
console.log(randomizeSentences(paragraph));
/* TEST CASES
console.log(sumOfSquares(12, 6, 2)); // 184
console.log(sumOfSquares(5, 3, 10)); // 134
console.log(sumOfSquares(1, 2, 3)); // 14
console.log(sumOfSquares(10, 3, "yo")); // throws
sayHelloTo(); // throws
sayHelloTo("Phil"); // "Hello, Phil!"
sayHelloTo("Phil", "Barresi"); // "Hello, Phil Barresi. I hope you are having a good day!"
sayHelloTo("Phil", "Barresi", "Mr."); // "Hello, Mr. Phil Barresi! Have a good evening!"
console.log(cupsOfCoffee(1));
console.log(cupsOfCoffee(4));
console.log(cupsOfCoffee(0)); //throws
console.log(cupsOfCoffee("word")); //throws
console.log(occurrencesOfSubstring("hello world", "o")); // 2
console.log(occurrencesOfSubstring("Helllllllo, class!", "ll")); // 6
randomizeSentences(paragraph);
*/
