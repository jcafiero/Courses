/*
 * AUTHOR: Jennifer Cafiero
 * I pledge my honor that i have abided by the Stevens Honor System
 * CS546 - Lab 3 Asynchronous Code, Files and Promises
 * September 25, 2017
 */

//const fs = require('fs');
const bluebird = require('bluebird');
const Promise = bluebird.Promise;

const fs = bluebird.promisifyAll(require('fs'));
/*
async function getFileAsString(path) {
  if (!path) {
    throw "Error: No path provided to get file";
  }
  const fileAsString = await fs.readFile(path, 'utf-8', function(err, data) {
    if (err) {
      throw "Error: There was an error reading the file";
    }
    return resolve(data);
  });

}
module.exports = {getFileAsString};

async function getFileAsJSON(path) {
  if (!path) {
    throw "Error: No path provided to get file";
  }
  const fileAsJSON = await fs.readFile(path, 'utf-8', function(err, data) {
    if (err) {
      return reject("Error: There was an error reading the file");
    }
    try {
      let jsonData = JSON.parse(data);
      resolve(jsonData);
    } catch (parsingError) {
      return parsingError;
    }
  });
}
module.exports = {getFileAsJSON};

async function saveStringToFile(path, text) {
  if (!path){
    throw "Error: No path provided to get file";
  }
  const stringToFile = fs.writeFile(path, text, 'utf-8', function(err) {
    if (err) {
      return reject("Error: There was an error writing to the file");
    }
    return resolve(true);
  });
}
module.exports = {saveStringToFile};

async function saveJSONToFile(path, obj) {
  if (!path) {
    throw "Error: No path provided to get file";
  }
  module.exports.saveStringToFile(path, JSON.stringify(obj, null, 4)).then(function(result) {
    return resolve(true);
  });
}
*/
module.exports = {
  description: "This module will read and write data from and to the designated files",
  getFileAsString: (path) => {
    return new Promise(function(resolve, reject) {
      if (path == null) {
        return reject("Error: No path provided to get file");
      }
      fs.readFile(path, 'utf-8', function(err, data) {
        if (err) {
          return reject("Error: There was an error reading the file");
        }
        return resolve(data);
      });
    });
  },
  getFileAsJSON: (path) => {
    return new Promise(function(resolve, reject) {
      if (path == null) {
        return reject("Error: No path provided to get file");
      }
      fs.readFile(path, 'utf-8', function(err, data) {
        if (err) {
          return reject("Error: There was an error reading the file");
        }
        try {
          let jsonData = JSON.parse(data);
          resolve(jsonData);
        } catch (parsingError) {
          reject(parsingError);
        }
      });

    });
  },
  saveStringToFile: (path, text) => {
    return new Promise(function(resolve, reject) {
      if ((path == null) || (text == null)) {
        return reject("Error: No path provided to get file");
      }
      fs.writeFile(path, text, 'utf-8', function(err) {
        if (err) {
          return reject("Error: There was an error writing to the file");
        }
        return resolve(true);
      });
    });
  },
  saveJSONToFile: (path, obj) => {
    return new Promise(function(resolve, reject) {
      module.exports.saveStringToFile(path, JSON.stringify(obj, null, 4)).then(function(result) {
        return resolve(true);
      });
    });
  }
}
