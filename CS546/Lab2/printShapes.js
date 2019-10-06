/*
 * AUTHOR: Jennifer Cafiero
 * I pledge my honor that i have abided by the Stevens Honor System
 * CS546 - Lab 2
 * September 11, 2017
 */

module.exports = {
  description: "Start module to print shapes...",
  triangle: function (lines) {
    if (typeof lines != 'number'){
      throw 'Error: Input should be a number';
    } else if (lines < 1) {
      throw 'Error: Value of lines must be greater than 0';
    } else {
      for (let i = 1; i <= lines; i++) {
        let indent = "";
        for (let j = 0; j < lines - i; j++){
          indent += " ";
        }
        let bottom = "";
        for (let j = 0; j < ((i - 1) * 2); j++) {
          bottom += "-";
        }
        let inside = "";
        for (let k = 1; k <= ((i - 1) * 2); k++) {
          inside += " ";
        }
        if ((i === lines) && (i > 1)) {
          console.log(`/${bottom}\\`);
        } else if (i === 1) {
          console.log(`${indent}/\\`);
        } else {
          console.log(`${indent}/${inside}\\`);
        }
      }
    }
  },
  square: function (lines) {
    if (typeof lines != 'number'){
      throw 'Error: Input should be a number';
    } else if (lines < 2) {
      throw 'Error: Value of lines must be greater than 1';
    }else {
      let topbot = "|";
      let row = "|";
      for (let i = 0; i < lines; i++) {
        topbot += "-";
        row += " ";
      }
      topbot += "|";
      row += "|";
      console.log(`${topbot}`);
      for (let i = 1; i < lines - 1; i++) {
        console.log(`${row}`);
      }
      console.log(`${topbot}`);
    }
  },

  rhombus: function (lines) {
    if (typeof lines !== 'number'){
      throw 'Error: Input should be a number';
    } else if (lines < 0) {
      throw 'Error: Value of lines must be greater than 0';
    }
    else if (lines % 2 !== 0) {
      throw 'Error: A rhombus must have an even number of lines';
    } else if (lines === 2) {
      console.log('/-\\');
      console.log('\\-/');
    } else {
      for (let i = 1; i <= lines / 2; i++) {
        let spacesU = "";
        for (let j = 0; j < lines / 2 - i; j++) {
          spacesU += " ";
        }
        let insideU = " ";
        for (let j = 1; j <= ((i - 1) * 2); j++) {
          insideU += " ";
        }
        if (i === lines / 2) {
          console.log(`/${insideU}\\`);
        } else if (i === 1) {
          console.log(`${spacesU}/-\\`);
        } else {
          console.log(`${spacesU}/${insideU}\\`);
        }
      }
      for (let i = lines/2; i >= 1; i--) {
        let spacesL = "";
        for (let j = 0; j < (lines / 2) - i; j++) {
          spacesL += " ";
        }
        let insideL = " ";
        for (let j = 1; j <= ((i - 1) * 2); j++) {
          insideL += " ";
        }
        if (i === lines / 2) {
          console.log(`\\${insideL}/`);
        } else if (i === 1) {
          console.log(`${spacesL}\\-/`);
        } else {
          console.log(`${spacesL}\\${insideL}/`);
        }
      }
    }
  }
}
