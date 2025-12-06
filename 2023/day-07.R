

# Inputs ------------------------------------------------------------------

inputs <- Filter(nchar, readLines(con <- file("inputs/7-ex.txt")))
inputs <- strsplit(inputs, " ", TRUE)
close(con)


# Day 7, Part 1 -----------------------------------------------------------

hands <- map(inputs, \(x) table(strsplit(x[1], "")))
bids <- map(inputs, 2) |> map_int(as.integer)

values <- map_int(hands, \(x) {
  if (length(x) == 1) {
    6
  }
  else if (max(x) == 4) {
    5
  }
  else if (length(x) == 2) {
    4
  }
  else if (length(x) == 3 & max(x) == 3) {
    3
  }
  else if (length(x) == 3 & max(x) == 2) {
    2
  }
  else if (length(x) == 4 & max(x) == 2) {
    1
  }
  else {
    0
  }
})

map_int(hands, \(x) sum(cards[names(x)] * x)) + values * 10

hands

cards <- set_names(seq(1, 14, 1), c("A", "K", "Q", "J", "T", seq(9, 1, -1)))

cards[hands[[1]]]

hands[order(50*values+map_int(hands, \(x) sum(cards[names(x)] * x)))]



sort.int()

bids[order(values)]

