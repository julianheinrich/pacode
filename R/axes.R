# Returns a vector of indexes
#' @export
axis.order <- function(x, by = "random") {
  if (!is.data.frame(x)) {
    x <- as.data.frame(x)
  }
  n <- ncol(x)
  ret <- colnames(x)

  if (by == "random") {
    ret <- sample(ret, n)
  } else if (by == "type") {
    numeric <- sapply(x, is.numeric)
    ret <- ret[order(numeric)]
  } else if (by == "correlation") {
    permutation <- PairViz::hamiltonian(as.dist(cor(x)))
    ret <- ret[permutation]
  } else if (by == "euclidean") {
    permutation <- PairViz::hamiltonian(dist(t(x)))
    ret <- ret[permutation]
  } else if (by == "all") {
    permutation <- PairViz::hpaths(n, F)
    ret <- ret[permutation]
  } else if (by == "matrix") {
    permutation <- PairViz::zigzag(n)
    ret <- t(apply(permutation, 1, function(p) {ret[p]}))
  }
  ret
}

hamiltonian <- function(dist) {
  weighted.hamiltonians <- PairViz::weighted_hpaths(dist)
  # pick only first
  indexes <- weighted.hamiltonians[1,]
}


# TODO
dist.matrix <- function(x, fun) {
  n <- nrow(x)
  cmb <- expand.grid(i=1:n, j=1:n)
  C <- matrix(apply(cmb,1,fun),n,n)
}
