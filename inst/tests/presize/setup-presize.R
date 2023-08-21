library(presize)
library(testthat)
withr::defer({
  detach(package:presize)
}, teardown_env())
