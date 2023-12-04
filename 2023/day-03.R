
library(purrr)
library(data.table)


# Inputs ------------------------------------------------------------------

input <- readLines(con <- file("inputs/3.txt"))
close(con)

# Find all numbers with start and end coordinates
regexes <- gregexpr("[0-9]+", input)
matches <- regmatches(input, regexes)

numbers <- rbindlist(map(seq_along(regexes), \(i) {
  rx <- regexes[[i]]
  ry <- rx + attr(rx, "match.length") - 1
  mx <- matches[[i]]
  if (all(rx == -1)) return(NULL)
  data.table(n = as.integer(mx), x0 = rx, x1 = ry, y0 = i)
}))

# Find all symbols
regexes <- gregexpr("[^0-9.]", input)
matches <- regmatches(input, regexes)

symbols <- rbindlist(map(seq_along(regexes), \(i) {
  rx <- regexes[[i]]
  mx <- matches[[i]]
  if (all(rx == -1)) return(NULL)
  data.frame(symbol = mx, x = rx, y = i)
}))


# Day 3, Part 1 -----------------------------------------------------------

numbers[, y0m1 := y0 - 1]
numbers[, y0p1 := y0 + 1]

joined <- numbers[
  symbols[, yy := y],
  on = .(y0m1 <= yy, y0p1 >= yy),
  nomatch = NULL
]

joined[between(y, y0m1, y0p1) & between(x, x0 - 1, x1 + 1), sum(n)]


# Day 3, Part 2 -----------------------------------------------------------

joined[
  between(y, y0m1, y0p1) & between(x, x0 - 1, x1 + 1),
  adj := .N,
  by = .(symbol, x, y)
]

joined[adj == 2, prod(n), by = .(symbol, x, y)][, sum(V1)]
