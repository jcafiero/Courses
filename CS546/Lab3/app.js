/*
 * AUTHOR: Jennifer Cafiero
 * I pledge my honor that i have abided by the Stevens Honor System
 * CS546 - Lab 3 Asynchronous Code, Files and Promises
 * September 25, 2017
 */

const fileData = require('./fileData');
const textMetrics = require('./textMetrics');
const fs = require('fs');

fs.access('chapter1.result.json', fs.constants.R_OK | fs.constants.W_OK, (error) => {
  if (error) {
    var chapter = "";
    chapter = fileData.getFileAsString("chapter1.txt");
    chapter.then(function(result) {
      var debug = textMetrics.simplify(result);
      fileData.saveStringToFile("chapter1.debug.txt", debug).then((data) => {
        if (data) {
          var results = "chapter1.result.json";
          var resultMetrics = textMetrics.createMetrics(result);
          fileData.saveJSONToFile("chapter1.result.json", resultMetrics).then((data) => {
            if (data) {
              console.log(JSON.stringify(resultMetrics, null, 4));
            }
          })
        }

      });
  }).catch((error) => {
    console.log(error);
  });
} else {
  let JSONresult = fileData.getFileAsJSON("chapter1.result.json");
  JSONresult.then((jsonObj) => {
    console.log(JSON.stringify(jsonObj, null, 4));
  }).catch((error) => {
    console.log(error);
  });
}
});

fs.access('chapter2.result.json', fs.constants.R_OK | fs.constants.W_OK, (error) => {
  if (error) {
    var chapter = "";
    chapter = fileData.getFileAsString("chapter2.txt");
    chapter.then(function(result) {
      var debug = textMetrics.simplify(result);
      fileData.saveStringToFile("chapter2.debug.txt", debug).then((data) => {
        if (data) {
          var results = "chapter2.result.json";
          var resultMetrics = textMetrics.createMetrics(result);
          fileData.saveJSONToFile("chapter2.result.json", resultMetrics).then((data) => {
            if (data) {
              console.log(JSON.stringify(resultMetrics, null, 4));
            }
          })
        }

      });
  }).catch((error) => {
    console.log(error);
  });
} else {
  let JSONresult = fileData.getFileAsJSON("chapter2.result.json");
  JSONresult.then((jsonObj) => {
    console.log(JSON.stringify(jsonObj, null, 4));
  }).catch((error) => {
    console.log(error);
  });
}
});

fs.access('chapter3.result.json', fs.constants.R_OK | fs.constants.W_OK, (error) => {
  if (error) {
    var chapter = "";
    chapter = fileData.getFileAsString("chapter3.txt");
    chapter.then(function(result) {
      var debug = textMetrics.simplify(result);
      fileData.saveStringToFile("chapter3.debug.txt", debug).then((data) => {
        if (data) {
          var results = "chapter3.result.json";
          var resultMetrics = textMetrics.createMetrics(result);
          fileData.saveJSONToFile("chapter3.result.json", resultMetrics).then((data) => {
            if (data) {
              console.log(JSON.stringify(resultMetrics, null, 4));
            }
          })
        }

      });
  }).catch((error) => {
    console.log(error);
  });
} else {
  let JSONresult = fileData.getFileAsJSON("chapter3.result.json");
  JSONresult.then((jsonObj) => {
    console.log(JSON.stringify(jsonObj, null, 4));
  }).catch((error) => {
    console.log(error);
  });
}
});
