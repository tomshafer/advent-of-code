
library(purrr)
library(data.table)


# Inputs ------------------------------------------------------------------

input <- readLines(con <- file("inputs/6.txt"))
input <- Filter(nchar, input)
close(con)

dt <- as.data.table(map(strsplit(input, "[: ]+"), \(x) as.integer(x[-1])))
setnames(dt, c("time", "distance"))


# Day 6, Part 1 -----------------------------------------------------------

bounds <- dt[, .(
  a = floor(time / 2 - sqrt(time ** 2 - 4 * distance) / 2) + 1,
  b = ceiling(time / 2 + sqrt(time ** 2 - 4 * distance) / 2) - 1
)]

bounds[, prod(b - a + 1)]


# Day 6, Part 2 -----------------------------------------------------------

# Modify the input
dt2 <- as.data.table(map(dt, function(col) {
  as.numeric(paste0(as.character(col), collapse = ""))
}))

bounds2 <- dt2[, .(
  a = floor(time / 2 - sqrt(time ** 2 - 4 * distance) / 2) + 1,
  b = ceiling(time / 2 + sqrt(time ** 2 - 4 * distance) / 2) - 1
)]

bounds2[, prod(b - a + 1)]
