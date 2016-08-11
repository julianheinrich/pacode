# computes a PCA on X and returns X with
# the first 'pcs' principal components added.
# X must be a data.frame
#' @export
pacode.pca <- function(X, pcs = ncol(X)) {
  x <- X[,sapply(X,is.numeric)]
  res <- prcomp(x, scale=T, center=T)
  df <- data.frame(res$x[, paste("PC", 1:pcs, sep="")])
  colnames(df) <- paste("PC", 1:pcs, sep="")
  df
}
