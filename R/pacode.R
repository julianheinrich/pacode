# unsure if this is required
library(base)
library(jsonlite)

pacode.start <- function() {
  datasets::mtcars
}

#' @export
pacode.setData <- function(x) {
  as.data.frame(eval(parse(text=x)))
}

#' @export
pacode.loadFromURL <- function(x) {
  jsonlite::fromJSON(as.character(x))
}

# potential security risk
#pacode.identity <- base::identity
