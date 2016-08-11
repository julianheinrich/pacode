# this is based on a suggestion by Hadley Wickham on stackoverflow
library(dplyr)

# list functions that are safe to call in package base
# safe_f_base <- c(
#   getGroupMembers("Math"),
#   getGroupMembers("Arith"),
#   getGroupMembers("Compare"),
#   "<-", "{", "(","cbind","$","[",":","subset","c"
# )

# a safe environment
safe_env <- new.env(parent = emptyenv())

packages <- paste("package", c("base", "stats", "utils", "dplyr", "datasets"), sep=":")
funs <- lapply(packages, function(p) {
  p_funs <- ls(p)
  for (f in p_funs) {
    safe_env[[f]] <- get(f, p)
  }
})

# safe_f_base <- ls("package:base")
# safe_f_utils <- ls("package:utils")
# safe_f_stats <- ls("package:stats")
#
# # example datasets
# safe_datasets <- ls("package:datasets")
#
# safe_dplyr <- ls("package:dplyr")



# for (f in safe_f_base) {
#   safe_env[[f]] <- get(f, "package:base")
# }
#
# for (f in safe_datasets) {
#   safe_env[[f]] <- get(f, "package:datasets")
# }
#
# for (f in safe_dplyr) {
#   safe_env[[f]] <- get(f, "package:dplyr")
# }
#
# for (f in safe_f_utils) {
#   safe_env[[f]] <- get(f, "package:utils")
# }

data("darkProteins")
safe_env[["darkProteins"]] <- darkProteins

#' @export
.val <- datasets::mtcars
#' @export
mtcars <- datasets::mtcars
#' @export
iris <- datasets::iris

safe_env[["mtcars"]] <- .val

#' @export
pacode.safe_eval <- function(x) {
  eval(substitute(x), env = safe_env)
}

# adds x to the environment then runs safe_eval
#' @export
pacode.safe_eval_x <- function(x, code) {
  safe_env[["x"]] <- x
  expr = parse(text=code)
  eval(substitute(expr), env = safe_env)
}

#pacode.safe_eval(data("darkProteins"))

# Can't access variables outside of that environment
#a <- 1
#safe_eval(a)

# But you can create in that environment
#safe_eval(a <- 2)
# And retrieve later
#safe_eval(a)
# a in the global environment is not affected
#a

# You can't access dangerous functions
#safe_eval(cat("Hi!"))

# And because function isn't included in the safe list
# you can't even create functions
#safe_eval({
#  log <- function() {
#    stop("Danger!")
#  }
#  log()
#})
