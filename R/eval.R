# this is based on a suggestion by Hadley Wickham on stackoverflow

# list functions that are safe to call
safe_f <- c(
  getGroupMembers("Math"),
  getGroupMembers("Arith"),
  getGroupMembers("Compare"),
  "<-", "{", "(","cbind","$"
)

# example datasets
safe_d <- ls("package:datasets")

# a safe environment
safe_env <- new.env(parent = emptyenv())

for (f in safe_f) {
  safe_env[[f]] <- get(f, "package:base")
}

for (f in safe_d) {
  safe_env[[f]] <- get(f, "package:datasets")
}

pacode.safe_eval <- function(x) {
  eval(substitute(x), env = safe_env)
}

pacode.safe_eval_x <- function(x, code) {
  safe_env[["x"]] <- x
  expr = parse(text=code)
  eval(substitute(expr), env = safe_env)
}

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
