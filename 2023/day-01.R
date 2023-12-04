

inp <- readLines(con <- file("inputs/1.txt"))
close(con)


# Day 1, Part 1 -----------------------------------------------------------

sums <- function(v) {
  rx <- regmatches(v, gregexpr("[0-9]", v))
  sum(sapply(rx, \(x) as.integer(paste0(head(x, 1), tail(x, 1)))))
}

inp |> sums()


# Day 1, Part 2 -----------------------------------------------------------

strs <- c("one", "two", "three", "four", "five", "six", "seven", "eight", "nine")
vals <- as.character(seq(1, 9))

inp2 <- inp
for (i in seq_along(inp2)) {
  for (j in seq_len(nchar(inp2[i]))) {
    test <- substring(inp2[i], j, j + nchar(strs) - 1) == strs
    if (any(test)) {
      k <- which(test)
      inp2[i] <- paste0(
        substring(inp2[i], 1, j - 1),
        vals[k],
        # j + nchar - 1 so we can also replace 'oneight' -> '18', etc.
        substring(inp2[i], j + nchar(strs[k]) - 1, nchar(inp2[i]))
      )
    }
  }
}

inp2 |> sums()
