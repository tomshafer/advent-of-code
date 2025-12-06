// Advent of Code 2025, Day 2

import { readFileSync } from "fs";

const inputs = readFileSync("inputs/02.txt", "utf8")
  .trim()
  .split(",")
  .map((x) => x.split("-").map(Number));

// https://stackoverflow.com/a/52544848
// JS doesn't have a range() function??
function* range(start: number, end: number | undefined, step = 1) {
  if (end === undefined) [end, start] = [start, 0];
  for (let n = start; n < end; n += step) yield n;
}

// Part 1
console.log("");
console.log("Part 1");

let ids: number[] = [];

for (const [s, e] of inputs) {
  for (const n of range(s, e + 1)) {
    const n_digits = Math.ceil(Math.log10(n));
    if (n_digits % 2 !== 0) continue;

    const h1 = Math.floor(n / 10 ** (n_digits / 2));
    const h2 = n - h1 * 10 ** (n_digits / 2);
    if (h1 !== h2) continue;

    ids.push(n);
  }
}

console.log(ids.reduce((x, y) => x + y, 0));

// Part 2: Now, find all repeated substrings
console.log("");
console.log("Part 2");

ids = [];
for (const [s, e] of inputs) {
  for (const n of range(s, e + 1)) {
    const n_string = n.toString();
    const n_length = n_string.length;

    // Find all substrings up to 1/2 length that work
    for (let i = 1; i <= n_length / 2; i++) {
      const nr = n_length / i;
      if (Number.isInteger(nr) === false) continue;

      const mm = n_string.substring(0, i).repeat(nr);
      if (n_string == mm) {
        ids.push(n);
        break;
      }
    }
  }
}

console.log(ids.reduce((x, y) => x + y));
