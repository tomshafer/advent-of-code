
library(purrr)
library(data.table)

# Inputs ------------------------------------------------------------------

input <- readLines(con <- file("inputs/5.txt"))
close(con)

seeds <- as.numeric(unlist(strsplit(input[1], "[: ]+"))[-1])

tmp <- list()
maps <- list()
ilist <- 0
for (i in seq(2, length(input))) {
  inp <- input[i]
  if (grepl("map", inp)) next
  if (inp == "") {
    if (ilist > 0) {
      maps[[ilist]] <- rbindlist(tmp)
    }
    tmp <- list()
    ilist <- ilist + 1
    next
  }

  vals <- setNames(as.numeric(unlist(strsplit(inp, " ", TRUE))), c("a", "b", "c"))
  tmp <- c(tmp, list(as.data.table(as.list(vals))))
}

maps <- c(maps, list(rbindlist(tmp)))


# Day 5, Part 1 -----------------------------------------------------------

push <- function(.seeds, .map) {
  map_dbl(.seeds, \(s) {
    x <- between(s, .map$b, .map$b+.map$c-1)
    if (!any(x)) return(s)
    m <- .map[which(x),]
    return(m$a+s-m$b)
  })
}

x <- seeds
for (i in seq(1, 7)) {
  x <- push(x, maps[[i]])
}


# Day 5, Part 2 -----------------------------------------------------------


