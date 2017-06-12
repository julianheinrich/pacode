pacode.startServer <- function() {
  opencpu::opencpu$stop()
  opencpu::opencpu$start(5307)
}
