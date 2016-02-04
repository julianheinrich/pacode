# computes a PCA on X and returns X with
# the first 'pcs' principal components added
pacode.pca <- function(X, pcs = ncol(X)) {
  res <- prcomp(X, scale=T, center=T)
  df <- data.frame(res$x[, paste("PC", 1:pcs, sep="")])
  colnames(df) <- paste("PC", 1:pcs, sep="")
  cbind(X, df)
}
