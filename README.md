
<!-- README.md is generated from README.Rmd. Please edit that file -->

# validation

<!-- badges: start -->
<!-- badges: end -->

The goal of validation is to provide an easy approach for the
documentation and implementation of package and function tests for the
SCTO R validation project.

## Installation

You can install the development version of validation from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("aghaynes/validation")
```

## Testing

The package contains a `test` function which is used to run all tests
for a named package.

``` r
library(validation)
## basic example code

test("presize")
#> Warning: package 'testthat' was built under R version 4.2.3
#> Warning: package 'presize' was built under R version 4.2.3
#> ✔ | F W S  OK | Context
#> ⠏ |         0 | presize                                                         ✖ | 1       2 | presize
#> ────────────────────────────────────────────────────────────────────────────────
#> Failure ('test-presize.R:14:3'): prec_mean upr
#> x$lwr not equal to 1.468.
#> 1/1 mismatches
#> [1] 0.532 - 1.47 == -0.936
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> ══ Results ═════════════════════════════════════════════════════════════════════
#> Duration: 0.3 s
#> 
#> [ FAIL 1 | WARN 0 | SKIP 0 | PASS 2 ]
#> Loading required package: gh
#> $who
#> [1] "aghaynes"
#> 
#> $pkg
#> [1] "presize"
#> 
#> $when
#> [1] "2023-09-05 11:55:07 CEST"
#> 
#> $what
#> [1] "Demo tests for presize"                             
#> [2] "- expected confidence interval width from prec_mean"
#> 
#> $result
#> [1] FALSE
#> 
#> $evidence
#>             file context                 test nb failed skipped error warning
#> 1 test-presize.R presize prec_mean conf.width  1      0   FALSE FALSE       0
#> 2 test-presize.R presize        prec_mean lwr  1      0   FALSE FALSE       0
#> 3 test-presize.R presize        prec_mean upr  1      1   FALSE FALSE       0
#>   user system real passed
#> 1 0.01      0 0.01      1
#> 2 0.02      0 0.02      1
#> 3 0.01      0 0.01      0
#>                                                                                                                       result
#> 1                            x$conf.width not equal to 0.936.\nEqual, 8, 3, 8, 54, 3, 54, 8, 8, 58, 59, prec_mean conf.width
#> 2                                      x$lwr not equal to 0.531.\nEqual, 11, 3, 11, 47, 3, 47, 11, 11, 58, 59, prec_mean lwr
#> 3 x$lwr not equal to 1.468.\n1/1 mismatches\n[1] 0.532 - 1.47 == -0.936, 14, 3, 14, 47, 3, 47, 14, 14, 58, 59, prec_mean upr
#> 
#> $session
#> $session$R
#> [1] "R version 4.2.1 (2022-06-23 ucrt)"
#> 
#> $session$OS
#> Windows 10 x64 (build 19043)
#> 
#> $session$loaded
#>  package     * version date (UTC) lib source
#>  brio          1.1.3   2021-11-30 [1] CRAN (R 4.2.3)
#>  cli           3.6.1   2023-03-23 [1] CRAN (R 4.2.3)
#>  crayon        1.5.2   2022-09-29 [1] CRAN (R 4.2.3)
#>  curl          5.0.0   2023-01-12 [1] CRAN (R 4.2.3)
#>  desc          1.4.2   2022-09-08 [1] CRAN (R 4.2.3)
#>  digest        0.6.31  2022-12-11 [1] CRAN (R 4.2.3)
#>  dplyr         1.1.1   2023-03-22 [1] CRAN (R 4.2.3)
#>  evaluate      0.20    2023-01-17 [1] CRAN (R 4.2.2)
#>  fansi         1.0.4   2023-01-22 [1] CRAN (R 4.2.3)
#>  fastmap       1.1.1   2023-02-24 [1] CRAN (R 4.2.3)
#>  generics      0.1.3   2022-07-05 [1] CRAN (R 4.2.3)
#>  gh          * 1.3.0   2021-04-30 [2] CRAN (R 4.2.0)
#>  gitcreds      0.1.1   2020-12-04 [2] CRAN (R 4.2.0)
#>  glue          1.6.2   2022-02-24 [1] CRAN (R 4.2.3)
#>  htmltools     0.5.5   2023-03-23 [1] CRAN (R 4.2.3)
#>  httr          1.4.5   2023-02-24 [1] CRAN (R 4.2.3)
#>  jsonlite      1.8.4   2022-12-06 [1] CRAN (R 4.2.3)
#>  kappaSize     1.2     2018-11-26 [2] CRAN (R 4.2.0)
#>  knitr         1.42    2023-01-25 [1] CRAN (R 4.2.3)
#>  lifecycle     1.0.3   2022-10-07 [1] CRAN (R 4.2.3)
#>  magrittr      2.0.3   2022-03-30 [1] CRAN (R 4.2.3)
#>  pillar        1.9.0   2023-03-22 [1] CRAN (R 4.2.3)
#>  pkgconfig     2.0.3   2019-09-22 [1] CRAN (R 4.2.3)
#>  pkgload       1.3.2   2022-11-16 [1] CRAN (R 4.2.3)
#>  presize       0.3.7   2023-02-27 [2] CRAN (R 4.2.3)
#>  R6            2.5.1   2021-08-19 [1] CRAN (R 4.2.3)
#>  rlang         1.1.0   2023-03-14 [1] CRAN (R 4.2.3)
#>  rmarkdown     2.21    2023-03-26 [1] CRAN (R 4.2.3)
#>  rprojroot     2.0.3   2022-04-02 [1] CRAN (R 4.2.3)
#>  rstudioapi    0.14    2022-08-22 [1] CRAN (R 4.2.3)
#>  sessioninfo   1.2.2   2021-12-06 [2] CRAN (R 4.2.0)
#>  testthat    * 3.1.7   2023-03-12 [1] CRAN (R 4.2.3)
#>  tibble        3.2.1   2023-03-20 [1] CRAN (R 4.2.3)
#>  tidyselect    1.2.0   2022-10-10 [1] CRAN (R 4.2.3)
#>  utf8          1.2.3   2023-01-31 [1] CRAN (R 4.2.3)
#>  validation  * 0.1.0   2023-09-05 [1] local
#>  vctrs         0.6.2   2023-04-19 [1] CRAN (R 4.2.3)
#>  withr         2.5.0   2022-03-03 [1] CRAN (R 4.2.3)
#>  xfun          0.38    2023-03-24 [1] CRAN (R 4.2.3)
#>  yaml          2.3.7   2023-01-23 [1] CRAN (R 4.2.3)
#> 
#>  [1] C:/Users/haynes/AppData/Local/R/win-library/4.2
#>  [2] C:/Users/haynes/AppData/Local/Programs/R/R-4.2.1/library
#> 
#> 
#> attr(,"class")
#> [1] "validate_result" "list"
```

The output of this function is a string which can be copied and pasted
into an appropriate issue on the GitHub `pkg_validation` repository.

### Implementing new tests

All tests are stored in `inst/tests` in package specific folders. E.g.
the `inst/tests/presize` folder contains tests relevant to the `presize`
package.

(At least) three files are required.

1.  setup-`package`.R
2.  info.txt
3.  test-`somename`.R

The `setup-package.R` file installs, updates and/or loads the package
being tested and any other relevant steps (e.g. loading a dataset).

`info.txt` contains a plain text description of the tests

test-`somename`.R contains the tests themselves. Tests should be written
using `testthat` syntax, e.g.

    test_that("'1:3' creates a sequence of 1, 2, 3", 
              expect_equal(1:3, c(1,2,3)))
