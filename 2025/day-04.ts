// Advent of Code 2025, Day 4

import { readFileSync } from "fs";

const inputs = readFileSync("inputs/04.txt", "utf8")
  .trim()
  .split("\n")
  .map((x) => x.split(""));

let positions: number[][] = [];
for (let ir = 0; ir < inputs.length; ir++) {
  for (let ic = 0; ic < inputs.length; ic++) {
    if (inputs[ir][ic] == "@") {
      positions.push([ir, ic]);
    }
  }
}

// Part 1: How many adjacent rolls are there?
console.log("");
console.log("Part 1");

let part1 = 0;

// ChatGPT
function includes(arr: number[][], el: number[]): boolean {
  return arr.some(
    (a) => a.length == el.length && a.every((v, i) => v === el[i])
  );
}

function indexOfValue(arr: number[][], el: number[]): number {
  for (let i = 0; i < arr.length; i++) {
    if (arr[i].length !== el.length) continue;
    if (arr[i].every((v, i) => v === el[i])) return i;
  }
  return -1;
}

for (const [y, x] of positions) {
  let n = 0;

  for (const dy of [-1, 0, 1]) {
    for (const dx of [-1, 0, 1]) {
      if (dy == 0 && dx == 0) continue;
      if (indexOfValue(positions, [y + dy, x + dx]) !== -1) n += 1;
    }
  }

  if (n < 4) part1 += 1;
}

console.log(part1);

// Part 2: How many rolls can we remove?
console.log("");
console.log("Part 2");

let part2 = 0;

while (true) {
  let round: number[] = [];

  for (let i = 0; i < positions.length; i++) {
    const [y, x] = positions[i];
    let n = 0;

    for (const dy of [-1, 0, 1]) {
      for (const dx of [-1, 0, 1]) {
        if (dy == 0 && dx == 0) continue;

        const ai = indexOfValue(positions, [y + dy, x + dx]);
        if (ai !== -1) n += 1;
      }
    }

    if (n < 4) round.push(i);
  }

  if (round.length === 0) break;

  round = round.reverse();
  for (const i of round) {
    positions.splice(i, 1);
  }

  part2 += round.length;
}

console.log(part2);
