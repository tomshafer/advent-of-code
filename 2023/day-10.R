
library(purrr)

# Inputs ------------------------------------------------------------------

inputs <- Filter(nchar, readLines(con <- file("inputs/10-ex2.txt")))
inputs <- matrix(unlist(strsplit(inputs, "")), ncol = nchar(inputs[[1]]), byrow = TRUE)
close(con)

pipes <- list(
  "|" = c(0, 1),
  "-" = c(1, 0),
  "L" = c(1, 1),
  "J" = c(-1, 1),
  "7" = c(1, 1),
  "F" = c(-1, -1),
)


# Day 10, Part 1 ----------------------------------------------------------

# Find S
lst <- "?"
val <- "S"
prv <- c(0, 0)
cur <- as.vector(which(inputs==val, arr.ind=T))
path <- list(val)
pcrd <- list()

while (TRUE) {
  neighbors <- c()
  coords <- list()
  if ((cur[1] - 1) >= 1 && inputs[cur[1]-1,cur[2]] %in% c("|","F", "7", "S") && val %in% c("|", "L", "J", "S")) {
    neighbors <- c(neighbors, inputs[cur[1]-1,cur[2]])
    coords <- c(coords, list(c(cur[1]-1,cur[2])))
  }
  if ((cur[1] + 1) <= nrow(inputs) && inputs[cur[1]+1,cur[2]] %in% c("|","J", "L", "S") && val %in% c("|", "7", "F", "S")) {
    neighbors <- c(neighbors, inputs[cur[1]+1,cur[2]])
    coords <- c(coords, list(c(cur[1]+1,cur[2])))
  }
  if ((cur[2] - 1) >= 1 && inputs[cur[1],cur[2]-1] %in% c("-","F", "L", "S") && val %in% c("-", "J", "7", "S")) {
    neighbors <- c(neighbors, inputs[cur[1],cur[2]-1])
    coords <- c(coords, list(c(cur[1],cur[2]-1)))
  }
  if ((cur[2] + 1) <= ncol(inputs) && inputs[cur[1],cur[2]+1] %in% c("-","J", "7", "S") && val %in% c("-", "L", "F", "S")) {
    neighbors <- c(neighbors, inputs[cur[1],cur[2]+1])
    coords <- c(coords, list(c(cur[1],cur[2]+1)))
  }

  message(paste(lst, "->", val, "|", length(neighbors), "|"))

  mask <- map_lgl(coords, \(x) any(x!=prv))
  if (length(mask)==0) stop("X")
  if (length(neighbors)>2) stop("y")

  prv <- cur
  lst <- val

  val <- neighbors[mask][[1]]
  cur <- coords[mask][[1]]
  path <- c(path, list(val))
  pcrd <- c(pcrd, list(cur))

  if (val == "S") break
}

ceiling((length(path) - 2) /2)


# Day 10, Part 2 ----------------------------------------------------------

# Find dots enclosed by pipes
# 7|J

# LR

# TB

# Overlap




pipes <- c(
  "|",
  "-",
  "L",
  "J",
  "7",
  "F",
  "S"
)

sum(inputs == ".")


cs1 = apply(inputs, 1, \(x) cumsum(x %in% pipes))
cs1=ifelse(inputs==".", cs1, 0 )
cs2 = apply(inputs, 2, \(x) cumsum(x %in% pipes))
cs2=ifelse(inputs==".", cs2, 0 )

cs1=ifelse(cs1 %% 2==1,1,0)
cs2=ifelse(cs2 %% 2==1,1,0)

sum(cs1 & cs2)




