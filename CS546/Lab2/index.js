/*
 * AUTHOR: Jennifer Cafiero
 * I pledge my honor that i have abided by the Stevens Honor System
 * CS546 - Lab 2 Modules and Basic Node
 * September 11, 2017
 */

const printShapes = require('./printShapes.js');

for (let i = 1; i <= 10; i++) {
  printShapes.triangle(i);
  console.log();
}

for (let i = 2; i <= 11; i++) {
  printShapes.square(i);
  console.log();
}
for (let i = 1; i <= 10; i++){
  printShapes.rhombus(i*2);
  console.log();
}
