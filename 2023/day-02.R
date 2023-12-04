
# Inputs ------------------------------------------------------------------

inp <- readLines(con <- file("inputs/2.txt"))
close(con)

inp <- Filter(\(x) nchar(x), inp)
inp <- lapply(strsplit(inp, ":", TRUE), \(x) trimws(x[2]))


# Day 2, Part 1 -----------------------------------------------------------

games <- do.call(rbind,lapply(inp, \(input) {
  games <- unlist(strsplit(input, ";", TRUE))

  sets <- do.call(rbind, lapply(
    strsplit(games, ",", TRUE),
    \(game) {
      game <- trimws(game)
      vls <- as.integer(sapply(strsplit(game, " ", TRUE), \(x) x[1]))
      nms <- sapply(strsplit(game, " ", TRUE), \(x) x[2])

      out <- c(red = 0, green = 0, blue = 0)
      for (i in seq_along(nms)) {
        out[nms[i]] <- out[nms[i]] + vls[i]
      }

      out
  }))

  apply(sets, 2, max)
}))

sum(which(games[,"red"] <= 12 & games[, "green"] <= 13 & games[, "blue"] <= 14))


# Day 2, Part 2 -----------------------------------------------------------

sum(apply(runs, 1, \(r) Reduce(prod, r)))
