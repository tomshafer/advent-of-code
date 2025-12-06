// Advent of Code 2025, Day 5

import { readFileSync } from "fs";

type Input = { ranges: [number, number][]; items: number[] };

function readInputs(file: string): Input {
  const lines = readFileSync(file, "utf8").trim().split("\n");
  const blank = lines.findIndex((line) => line === "");

  const items = lines.slice(blank).map(Number);
  const ranges: [number, number][] = lines.slice(0, blank).map((x) => {
    const [l, r] = x.split("-").map(Number);
    return [l, r];
  });

  return { ranges: ranges, items: items };
}

function part1(data: Input): number {
  let n_good = 0;
  for (const inp of data.items) {
    for (let i = 0; i < data.ranges.length; i++) {
      if (inp > data.ranges[i][0] && inp <= data.ranges[i][1]) {
        n_good += 1;
        break;
      }
    }
  }
  return n_good;
}

function part2(data: Input): number {
  let ranges: number[][] = [];

  for (const [l, r] of data.ranges.sort((a, b) => a[0] - b[0])) {
    let matched = false;

    for (let i = 0; i < ranges.length; i++) {
      const [rl, rr] = ranges[i];
      if (l <= rr && r >= rl) {
        ranges[i][0] = Math.min(l, rl);
        ranges[i][1] = Math.max(r, rr);
        matched = true;
      }
    }

    if (!matched) {
      ranges.push([l, r]);
    }
  }

  let n = 0;
  for (const [l, r] of ranges) {
    n += r - l + 1;
  }
  return n;
}

const inputs = readInputs("inputs/05.txt");

console.log("");
console.log("Part 1");
console.log(part1(inputs));

console.log("");
console.log("Part 2");
console.log(part2(inputs));
