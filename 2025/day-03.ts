// Advent of Code 2025, Day 3

import { readFileSync } from "fs";

const inputs = readFileSync("inputs/03.txt", "utf8")
  .trim()
  .split("\n")
  .map((x) => x.split("").map(Number));

// Part 1
console.log("");
console.log("Part 1");

// Find first occurrence of max value: https://stackoverflow.com/a/30850912
function firstmaxindex(arr: number[]): number {
  return arr.reduce((m, x, i, a) => (x > a[m] ? i : m), 0);
}

let numbers: number[] = [];
for (const arr of inputs) {
  const i1 = firstmaxindex(arr.slice(0, -1));
  const i2 = 1 + i1 + firstmaxindex(arr.slice(i1 + 1));
  numbers.push(10 * arr[i1] + arr[i2]);
}

console.log(numbers.reduce((x, y) => x + y, 0));

// Part 2
console.log("");
console.log("Part 2");

// Now we need to find the best *twelve* digits. Procedure is the
// same, but find the best digit in each window.
numbers = [];
for (const arr of inputs) {
  let lhs = 0;
  let digits: number[] = [];

  for (let i = 0; i < 12; i++) {
    const rhs = arr.length - (12 - i) + 1;
    const offset = firstmaxindex(arr.slice(lhs, rhs));
    digits.push(arr[lhs + offset]);
    lhs += 1 + offset;
  }

  numbers.push(parseInt(digits.join("")));
}

console.log(numbers.reduce((x, y) => x + y, 0));
