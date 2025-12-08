// Advent of Code, Day 8

import { readFileSync } from "fs";

type Triple = [number, number, number];

// Inputs are coordinate triples
function readInputs(file: string): Triple[] {
  const boxes = readFileSync(file, "utf8")
    .trim()
    .split("\n")
    .map((v) => v.split(","));

  // Do it this way to get exactly three items
  let out: Triple[] = [];
  for (const [x, y, z] of boxes) {
    out.push([Number(x), Number(y), Number(z)]);
  }

  return out;
}

// Euclidean distance
function l2dist(a: Triple, b: Triple): number {
  let x = 0;
  for (let i = 0; i < 3; i++) {
    x += (a[i] - b[i]) ** 2;
  }
  return Math.sqrt(x);
}

type Out = {
  circuits: Array<Set<Triple>>;
  last: [Triple, Triple];
};

function iterate(inputs: Triple[], n: number = 10): Out {
  // Distance matrix
  let dist = new Array(inputs.length)
    .fill(0)
    .map(() => new Array(inputs.length).fill(0));

  for (let i = 0; i < inputs.length; i++) {
    for (let j = 0; j < inputs.length; j++) {
      dist[i][j] = l2dist(inputs[i], inputs[j]);
      if (dist[i][j] === 0) dist[i][j] = Infinity;
    }
  }

  // Build the circuits iteratively
  let circuits = new Array<Set<Triple>>();
  let last: [Triple, Triple] = [inputs[0], inputs[0]];

  for (let cycle = 0; cycle < n; cycle++) {
    // Minimum distance remaining
    let mindist = Infinity;
    let pair = [-1, -1];
    for (let i = 0; i < inputs.length; i++) {
      for (let j = 0; j < inputs.length; j++) {
        if (dist[i][j] < mindist) {
          mindist = dist[i][j];
          pair = [i, j];
        }
      }
    }

    // Triples
    const i0 = inputs[pair[0]];
    const i1 = inputs[pair[1]];

    // Circuit membership
    let c0 = circuits.findIndex((v) => v.has(inputs[pair[0]]));
    let c1 = circuits.findIndex((v) => v.has(inputs[pair[1]]));

    if (c0 === -1 && c1 === -1) {
      // New circuit
      let s = new Set<Triple>();
      s.add(inputs[pair[0]]);
      s.add(inputs[pair[1]]);
      circuits.push(s);
    } else if (c0 === -1) {
      // One or the other is in a circuit
      circuits[c1].add(i0);
    } else if (c1 === -1) {
      circuits[c0].add(i1);
    } else {
      // Bridge 2 circuits
      for (const x of circuits[c1]) circuits[c0].add(x);
      if (c0 !== c1) circuits.splice(c1, 1);
    }

    dist[pair[0]][pair[1]] = Infinity;
    dist[pair[1]][pair[0]] = Infinity;

    last = [i0, i1];

    if (circuits.length === 1 && circuits[0].size === inputs.length) break;
    if (pair[0] === -1 && pair[1] === -1) break;
  }

  return { circuits: circuits, last: last };
}

// Part 1
const inputs = readInputs("inputs/08.txt");

// Build the matrix and accumulate the first N circuits.
// Return the product of the top 3 sizes.
function part1(inputs: Triple[], cycles: number = 10): number {
  const out = iterate(inputs, cycles);
  return out.circuits
    .map((v) => v.size)
    .sort((a, b) => b - a)
    .slice(0, 3)
    .reduce((a, b) => a * b);
}

console.log(`\nDay 8\nPart 1: ${part1(inputs, 1000)}`);

function part2(inputs: Triple[]): number {
  const out = iterate(inputs, Infinity);
  return out.last.map((x) => x[0]).reduce((a, b) => a * b);
}

console.log(`Part 2: ${part2(inputs)}`);
