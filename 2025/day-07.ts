// Advent of Code 2025, Day 7

import { readFileSync } from "fs";

type Input = { start: [number, number]; splits: [number, number][] };

function readInput(file: string): Input {
  const input = readFileSync(file, "utf8").trim().split("\n");

  let start: [number, number] = [-1, -1];
  let splits: [number, number][] = [];

  for (let i = 0; i < input.length; i++) {
    const s = input[i].indexOf("S");
    if (s !== -1) start = [i, s];

    for (let j = 0; j < input[i].length; j++) {
      if (input[i][j] === "^") splits.push([i, j]);
    }
  }

  splits.sort((a, b) => 1000 * (a[0] - b[0]) + (a[1] - b[1]));
  return { start: start, splits: splits };
}

// Part 1: Count the number of splits.
// Part 2: Count the number of histories.
function day7(input: Input): { splits: number; histories: number } {
  const splits = input.splits;

  let beams = new Map();
  beams.set(input.start[1], 1);

  let currow = input.start[0];
  let n_splits = 0;
  let iters = 0;

  while (true) {
    iters += 1;
    if (iters > 1000) break;

    const avail = splits.filter(([r, _]) => r >= currow);
    if (avail.length === 0) break;

    let newbeams = new Map();

    for (const [beam, weight] of beams) {
      const s = avail.filter(([r, c]) => r == currow && c == beam);
      if (s.length === 0) continue;

      n_splits++;
      beams.delete(beam);

      newbeams.set(beam - 1, (newbeams.get(beam - 1) ?? 0) + weight);
      newbeams.set(beam + 1, (newbeams.get(beam + 1) ?? 0) + weight);
    }

    if (newbeams.size > 0) {
      for (const [beam, weight] of newbeams) {
        beams.set(beam, (beams.get(beam) ?? 0) + weight);
      }
    }

    currow += 1;
  }

  let nn = 0;
  for (const v of beams.values()) nn += v;

  return { splits: n_splits, histories: nn };
}

const inputs = readInput("inputs/07.txt");
const results = day7(inputs);

console.log("\nDay 7, Part 1");
console.log(results.splits);

console.log("\nDay 7, Part 2");
console.log(results.histories);
