# presize tests



x <- prec_mean(1, 1, n = 20)

test_that("prec_mean conf.width",{
  expect_equal(x$conf.width, 0.936, tolerance = 0.001)
})
test_that("prec_mean lwr",{
  expect_equal(x$lwr, 0.531, tolerance = 0.001)
})
test_that("prec_mean upr",{
  expect_equal(x$lwr, 1.468, tolerance = 0.001)
})

