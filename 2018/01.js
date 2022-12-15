"use strict";

const fs = require("fs");
const arr = fs.readFileSync("inputs/01.txt").toString().split("\n").filter(Number);

// Part 1
console.log(arr.reduce((a, b) => Number(a) + Number(b)));

// Part 2
let iter = 0, total = 0, seen = new Set(), check = false;

while (iter < 1000) {
    for (let i = 0; i < arr.length; i++) {
        if (arr[i] === "") {
            continue;
        }

        total += Number(arr[i]);
        if (seen.has(total)) {
            console.log(total);
            check = true;
            break;
        }
        seen.add(total);
    }
    if (check) {
        break;
    }
}
