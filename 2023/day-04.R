
library(purrr)
library(data.table)


# Inputs ------------------------------------------------------------------

input <- readLines(con <- file("inputs/4.txt"))
input <- Filter(nchar, input)
close(con)

cards <- strsplit(input, ":", TRUE) |>
  map(2) |>
  map(\(x) unlist(strsplit(x, "|", TRUE))) |>
  map(\(x) strsplit(trimws(x), "[ ]+")) |>
  map(\(x) set_names(map(x, as.integer), c("w", "m")))


# Day 4, Part 1 -----------------------------------------------------------

sum(cards |> map_dbl(\(card) {
  n <- length(intersect(card$w, card$m))
  if (n == 0) return(0)
  2 ** (n-1)
}))


# Day 4, Part 2 -----------------------------------------------------------

counts <- cards |> map_dbl(\(card) length(intersect(card$w, card$m)))
copies <- rep(1, length(counts))

for (i in seq(1, length(counts))) {
  count <- counts[i]
  if (count == 0) next
  copies[(i + 1):(i + count)] <- copies[(i + 1):(i + count)] + copies[i]
}

sum(copies)
