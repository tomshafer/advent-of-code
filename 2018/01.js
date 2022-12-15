"use strict";

const fs = require("fs");
const input = fs.readFileSync("inputs/01.txt").toString().split("\n").filter(Number);

// Part 1
console.log("Part 1:", input.reduce((a, b) => Number(a) + Number(b)));

// Part 2
let total = 0, seen = new Set();
let iter = 0;

mainloop: while (iter < 1000) {
    for (let i = 0; i < input.length; i++) {
        if (input[i] === "") {
            continue;
        }

        total += Number(input[i]);
        if (seen.has(total)) {
            break mainloop;
        }
        seen.add(total);
    }
}
console.log("Part 2:", total);
