/*
 * AUTHOR: Jennifer Cafiero
 * I pledge my honor that i have abided by the Stevens Honor System
 * CS546 - Lab 3 Asynchronous Code, Files and Promises
 * September 25, 2017
 */

module.exports = {
  description: "This module will take a string of text and convert to lowercase, remove all non-alphanumeric characters, convert all whitespaces to simple, single spaces, and return the result. This method will also scan the text, simplify it, and return the metrics of the text",
  simplify: function (text) {
    if (typeof text != 'string') {
      throw "Error: Text argument must be a string";
    } else {
      var alphaNum = /^[0-9a-zA-Z]+$/;
      var result = "";
      try {
        result = text.toLowerCase();
        var nonAlphaNum = /[^a-z0-9\s]/g;
        var spaces = /[\n\t\s]+/g;
        result = result.replace(nonAlphaNum, '');
        result = result.replace(spaces, ' ');
        return result;
      } catch (error) {
        console.error(error);
      }


    }
  },
  createMetrics: function (text) {
    if (!text) {
      throw "Error: No input was given";
    }
    if (typeof text != 'string') {
      throw "Error: Text argument must be a string";
    } else {
      var result = module.exports.simplify(text);
      var alphaNum = /[a-z0-9]/g;
      var eachWord = /(\w+)/g;
      var totalNumLetters = result.match(alphaNum).length;
      var totalNumWords = result.match(eachWord).length;
      var allWords = result.split(/\s/);
      var uniWords = 0;
      var longWords = 0;

      var wordOccurs = {};
      allWords.forEach(function(w) {
        if (!wordOccurs[w]) {
          wordOccurs[w] = 0;
        }
        wordOccurs[w] += 1;
      });
      for (var key in wordOccurs) {
           if (wordOccurs[key] === 1) {
               uniWords++;
           }
       }

       // how many UNIQUE long words can there be?
       for (var key in wordOccurs) {
           if (key.length >= 6 && wordOccurs[key] === 1) {
               longWords++;
           }
       }
      var avgWordLen = totalNumLetters / totalNumWords;

      var metricsObj = new Object();
      metricsObj.fileName = text[0]+text[1]+text[2]+text[3]+text[4]+text[5]+text[6]+text[7]+text[8];
      metricsObj.totalLetters = totalNumLetters;
      metricsObj.totalWords = totalNumWords;
      metricsObj.uniqueWords = uniWords;
      metricsObj.longWords = longWords;
      metricsObj.averageWordLength = avgWordLen;
      metricsObj.wordOccurrences = wordOccurs;
      return metricsObj;
    }
  }
}
