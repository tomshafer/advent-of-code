// Advent of Code 2025, Day 6

import { readFileSync } from "fs";

type Input = { op: string; numbers: string[] };

// Read columns of numbers and operations, 
// preserving whitespace so columns align.
function readInput(filePath: string): Input[] {
  const data = readFileSync(filePath, "utf8").trim().split("\n");

  // Operators at the starts of columns (+ append end of line)
  const bounds = data[data.length - 1]
    .split("")
    .map((v, i) => (["*", "+"].includes(v) ? i : null))
    .filter((v) => v !== null)
    .concat(Math.max(...data.map((v) => v.length + 1)));

  const ops = bounds
    .slice(0, bounds.length - 1)
    .map((i) => data[data.length - 1][i]);

  const cols = bounds.slice(0, bounds.length - 1).map((b, i) => {
    return data
      .slice(0, data.length - 1)
      .map((v) => v.slice(b, bounds[i + 1] - 1));
  });

  return ops.map((o, i) => {
    return { op: o, numbers: cols[i] };
  });
}

const inputs = readInput("inputs/06.txt");


// Part 1
console.log("");
console.log("Day 6");
console.log("Part 1");

// Operate on collections of numbers
function part1(inputs: Input[]): number {
  let sum = 0;
  for (const inp of inputs) {
    const mat = inp.numbers.map(Number);
    sum += mat.reduce((a, b) => (inp.op === "*" ? a * b : a + b));
  }
  return sum;
}

console.log(part1(inputs));

// Part 2
console.log("");
console.log("Part 2");

// Convert columns to digits, reading right to left, then operate
function part2(inputs: Input[]): number {
  let sum = 0;

  for (const inp of inputs) {
    const len = inp.numbers[0].length;

    let numbers = [];

    for (let p = len - 1; p >= 0; p--) {
      let digits = [];

      for (const n of inp.numbers) {
        if (n[p] == " ") continue;
        digits.push(Number(n[p]));
      }

      numbers.push(Number(digits.join("")));
    }

    sum += numbers.reduce((a, b) => (inp.op === "*" ? a * b : a + b));
  }

  return sum;
}

console.log(part2(inputs));
