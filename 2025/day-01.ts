// Advent of Code 2025, Day 1
// Learning TypeScript/JavaScript.

import { readFileSync } from "fs";

const input: number[] = readFileSync("inputs/01.txt", "utf8")
  .trim()
  .split("\n")
  .map((x) => Number(x.slice(1)) * (x.charAt(0) == "L" ? -1 : 1));

// Part 1
console.log("");
console.log("Part 1");

// Cumulative sum over modulo, starting at 50
function modcumsum(inputs: number[]): number[] {
  const out: number[] = [50];

  for (const i of inputs) {
    let sum = (out[out.length - 1] + i) % 100;
    out.push(sum);
  }

  return out;
}

const parts = modcumsum(input);
console.log(parts.filter((x) => x == 0).length);

// Part 2
console.log("");
console.log("Part 2");

let crosses: number = 0;
let cur: number = 50;

for (let i = 0; i < input.length; i++) {
  const crs =
    Math.floor(Math.abs(input[i]) / 100) +
    (cur + (input[i] % 100) >= 100 ? 1 : 0) +
    (cur + (input[i] % 100) <= 0 && cur > 0 ? 1 : 0);

  cur = (cur + input[i]) % 100;
  cur = cur >= 0 ? cur : 100 + cur;
  crosses += crs;
}

console.log(crosses);
