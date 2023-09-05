
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
#> ## Function validation
#> ### Package: 
#> <!-- TAGSTART:package -->
#> presize
#> <!-- TAGEND:package -->
#> 
#> ### Function tested:
#> <!-- TAGSTART:function -->
#> Demo tests for presize - expected confidence interval width from prec_mean
#> <!-- TAGEND:function -->
#> 
#> ### Test results:
#> Did the function pass or fail?
#> <!-- TAGSTART:result -->
#> _Fail_
#> <!-- TAGEND:result -->
#> 
#> ### Test output:
#> <!-- TAGSTART:r_output -->
#> 
#> 
#> |file           |context |test                 | nb| passed|skipped |error | warning|
#> |:--------------|:-------|:--------------------|--:|------:|:-------|:-----|-------:|
#> |test-presize.R |presize |prec_mean conf.width |  1|      1|FALSE   |FALSE |       0|
#> |test-presize.R |presize |prec_mean lwr        |  1|      1|FALSE   |FALSE |       0|
#> |test-presize.R |presize |prec_mean upr        |  1|      0|FALSE   |FALSE |       0|
#> <!-- TAGEND:r_output -->
#> ### SessionInfo:
#> <!-- TAGSTART:r_version -->
#> R version 4.2.1 (2022-06-23 ucrt)
#> <!-- TAGEND:r_version -->
#> <!-- TAGSTART:r_os -->
#> Windows 10 x64 (build 19043)
#> <!-- TAGEND:r_os -->
#> <!-- TAGSTART:r_loaded -->
#> 
#> 
#> |package     |ondiskversion |loadedversion |path                                                                 |loadedpath                                                           |attached |is_base |date       |source         |md5ok |library                                                  |
#> |:-----------|:-------------|:-------------|:--------------------------------------------------------------------|:--------------------------------------------------------------------|:--------|:-------|:----------|:--------------|:-----|:--------------------------------------------------------|
#> |brio        |1.1.3         |1.1.3         |C:/Users/haynes/AppData/Local/R/win-library/4.2/brio                 |C:/Users/haynes/AppData/Local/R/win-library/4.2/brio                 |FALSE    |FALSE   |2021-11-30 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |cli         |3.6.1         |3.6.1         |C:/Users/haynes/AppData/Local/R/win-library/4.2/cli                  |C:/Users/haynes/AppData/Local/R/win-library/4.2/cli                  |FALSE    |FALSE   |2023-03-23 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |crayon      |1.5.2         |1.5.2         |C:/Users/haynes/AppData/Local/R/win-library/4.2/crayon               |C:/Users/haynes/AppData/Local/R/win-library/4.2/crayon               |FALSE    |FALSE   |2022-09-29 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |curl        |5.0.0         |5.0.0         |C:/Users/haynes/AppData/Local/R/win-library/4.2/curl                 |C:/Users/haynes/AppData/Local/R/win-library/4.2/curl                 |FALSE    |FALSE   |2023-01-12 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |desc        |1.4.2         |1.4.2         |C:/Users/haynes/AppData/Local/R/win-library/4.2/desc                 |C:/Users/haynes/AppData/Local/R/win-library/4.2/desc                 |FALSE    |FALSE   |2022-09-08 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |digest      |0.6.31        |0.6.31        |C:/Users/haynes/AppData/Local/R/win-library/4.2/digest               |C:/Users/haynes/AppData/Local/R/win-library/4.2/digest               |FALSE    |FALSE   |2022-12-11 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |dplyr       |1.1.1         |1.1.1         |C:/Users/haynes/AppData/Local/R/win-library/4.2/dplyr                |C:/Users/haynes/AppData/Local/R/win-library/4.2/dplyr                |FALSE    |FALSE   |2023-03-22 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |evaluate    |0.20          |0.20          |C:/Users/haynes/AppData/Local/R/win-library/4.2/evaluate             |C:/Users/haynes/AppData/Local/R/win-library/4.2/evaluate             |FALSE    |FALSE   |2023-01-17 |CRAN (R 4.2.2) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |fansi       |1.0.4         |1.0.4         |C:/Users/haynes/AppData/Local/R/win-library/4.2/fansi                |C:/Users/haynes/AppData/Local/R/win-library/4.2/fansi                |FALSE    |FALSE   |2023-01-22 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |fastmap     |1.1.1         |1.1.1         |C:/Users/haynes/AppData/Local/R/win-library/4.2/fastmap              |C:/Users/haynes/AppData/Local/R/win-library/4.2/fastmap              |FALSE    |FALSE   |2023-02-24 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |generics    |0.1.3         |0.1.3         |C:/Users/haynes/AppData/Local/R/win-library/4.2/generics             |C:/Users/haynes/AppData/Local/R/win-library/4.2/generics             |FALSE    |FALSE   |2022-07-05 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |gh          |1.3.0         |1.3.0         |C:/Users/haynes/AppData/Local/Programs/R/R-4.2.1/library/gh          |C:/Users/haynes/AppData/Local/Programs/R/R-4.2.1/library/gh          |TRUE     |FALSE   |2021-04-30 |CRAN (R 4.2.0) |TRUE  |C:/Users/haynes/AppData/Local/Programs/R/R-4.2.1/library |
#> |gitcreds    |0.1.1         |0.1.1         |C:/Users/haynes/AppData/Local/Programs/R/R-4.2.1/library/gitcreds    |C:/Users/haynes/AppData/Local/Programs/R/R-4.2.1/library/gitcreds    |FALSE    |FALSE   |2020-12-04 |CRAN (R 4.2.0) |TRUE  |C:/Users/haynes/AppData/Local/Programs/R/R-4.2.1/library |
#> |glue        |1.6.2         |1.6.2         |C:/Users/haynes/AppData/Local/R/win-library/4.2/glue                 |C:/Users/haynes/AppData/Local/R/win-library/4.2/glue                 |FALSE    |FALSE   |2022-02-24 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |htmltools   |0.5.5         |0.5.5         |C:/Users/haynes/AppData/Local/R/win-library/4.2/htmltools            |C:/Users/haynes/AppData/Local/R/win-library/4.2/htmltools            |FALSE    |FALSE   |2023-03-23 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |httr        |1.4.5         |1.4.5         |C:/Users/haynes/AppData/Local/R/win-library/4.2/httr                 |C:/Users/haynes/AppData/Local/R/win-library/4.2/httr                 |FALSE    |FALSE   |2023-02-24 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |jsonlite    |1.8.4         |1.8.4         |C:/Users/haynes/AppData/Local/R/win-library/4.2/jsonlite             |C:/Users/haynes/AppData/Local/R/win-library/4.2/jsonlite             |FALSE    |FALSE   |2022-12-06 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |kappaSize   |1.2           |1.2           |C:/Users/haynes/AppData/Local/Programs/R/R-4.2.1/library/kappaSize   |C:/Users/haynes/AppData/Local/Programs/R/R-4.2.1/library/kappaSize   |FALSE    |FALSE   |2018-11-26 |CRAN (R 4.2.0) |TRUE  |C:/Users/haynes/AppData/Local/Programs/R/R-4.2.1/library |
#> |knitr       |1.42          |1.42          |C:/Users/haynes/AppData/Local/R/win-library/4.2/knitr                |C:/Users/haynes/AppData/Local/R/win-library/4.2/knitr                |FALSE    |FALSE   |2023-01-25 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |lifecycle   |1.0.3         |1.0.3         |C:/Users/haynes/AppData/Local/R/win-library/4.2/lifecycle            |C:/Users/haynes/AppData/Local/R/win-library/4.2/lifecycle            |FALSE    |FALSE   |2022-10-07 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |magrittr    |2.0.3         |2.0.3         |C:/Users/haynes/AppData/Local/R/win-library/4.2/magrittr             |C:/Users/haynes/AppData/Local/R/win-library/4.2/magrittr             |FALSE    |FALSE   |2022-03-30 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |pillar      |1.9.0         |1.9.0         |C:/Users/haynes/AppData/Local/R/win-library/4.2/pillar               |C:/Users/haynes/AppData/Local/R/win-library/4.2/pillar               |FALSE    |FALSE   |2023-03-22 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |pkgconfig   |2.0.3         |2.0.3         |C:/Users/haynes/AppData/Local/R/win-library/4.2/pkgconfig            |C:/Users/haynes/AppData/Local/R/win-library/4.2/pkgconfig            |FALSE    |FALSE   |2019-09-22 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |pkgload     |1.3.2         |1.3.2         |C:/Users/haynes/AppData/Local/R/win-library/4.2/pkgload              |C:/Users/haynes/AppData/Local/R/win-library/4.2/pkgload              |FALSE    |FALSE   |2022-11-16 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |presize     |0.3.7         |0.3.7         |C:/Users/haynes/AppData/Local/Programs/R/R-4.2.1/library/presize     |C:/Users/haynes/AppData/Local/Programs/R/R-4.2.1/library/presize     |FALSE    |FALSE   |2023-02-27 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/Programs/R/R-4.2.1/library |
#> |R6          |2.5.1         |2.5.1         |C:/Users/haynes/AppData/Local/R/win-library/4.2/R6                   |C:/Users/haynes/AppData/Local/R/win-library/4.2/R6                   |FALSE    |FALSE   |2021-08-19 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |rlang       |1.1.0         |1.1.0         |C:/Users/haynes/AppData/Local/R/win-library/4.2/rlang                |C:/Users/haynes/AppData/Local/R/win-library/4.2/rlang                |FALSE    |FALSE   |2023-03-14 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |rmarkdown   |2.21          |2.21          |C:/Users/haynes/AppData/Local/R/win-library/4.2/rmarkdown            |C:/Users/haynes/AppData/Local/R/win-library/4.2/rmarkdown            |FALSE    |FALSE   |2023-03-26 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |rprojroot   |2.0.3         |2.0.3         |C:/Users/haynes/AppData/Local/R/win-library/4.2/rprojroot            |C:/Users/haynes/AppData/Local/R/win-library/4.2/rprojroot            |FALSE    |FALSE   |2022-04-02 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |rstudioapi  |0.14          |0.14          |C:/Users/haynes/AppData/Local/R/win-library/4.2/rstudioapi           |C:/Users/haynes/AppData/Local/R/win-library/4.2/rstudioapi           |FALSE    |FALSE   |2022-08-22 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |sessioninfo |1.2.2         |1.2.2         |C:/Users/haynes/AppData/Local/Programs/R/R-4.2.1/library/sessioninfo |C:/Users/haynes/AppData/Local/Programs/R/R-4.2.1/library/sessioninfo |FALSE    |FALSE   |2021-12-06 |CRAN (R 4.2.0) |TRUE  |C:/Users/haynes/AppData/Local/Programs/R/R-4.2.1/library |
#> |testthat    |3.1.7         |3.1.7         |C:/Users/haynes/AppData/Local/R/win-library/4.2/testthat             |C:/Users/haynes/AppData/Local/R/win-library/4.2/testthat             |TRUE     |FALSE   |2023-03-12 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |tibble      |3.2.1         |3.2.1         |C:/Users/haynes/AppData/Local/R/win-library/4.2/tibble               |C:/Users/haynes/AppData/Local/R/win-library/4.2/tibble               |FALSE    |FALSE   |2023-03-20 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |tidyselect  |1.2.0         |1.2.0         |C:/Users/haynes/AppData/Local/R/win-library/4.2/tidyselect           |C:/Users/haynes/AppData/Local/R/win-library/4.2/tidyselect           |FALSE    |FALSE   |2022-10-10 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |utf8        |1.2.3         |1.2.3         |C:/Users/haynes/AppData/Local/R/win-library/4.2/utf8                 |C:/Users/haynes/AppData/Local/R/win-library/4.2/utf8                 |FALSE    |FALSE   |2023-01-31 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |validation  |0.1.0         |0.1.0         |C:/Users/haynes/AppData/Local/R/win-library/4.2/validation           |C:/Users/haynes/AppData/Local/R/win-library/4.2/validation           |TRUE     |FALSE   |2023-09-05 |local          |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |vctrs       |0.6.2         |0.6.2         |C:/Users/haynes/AppData/Local/R/win-library/4.2/vctrs                |C:/Users/haynes/AppData/Local/R/win-library/4.2/vctrs                |FALSE    |FALSE   |2023-04-19 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |withr       |2.5.0         |2.5.0         |C:/Users/haynes/AppData/Local/R/win-library/4.2/withr                |C:/Users/haynes/AppData/Local/R/win-library/4.2/withr                |FALSE    |FALSE   |2022-03-03 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |xfun        |0.38          |0.38          |C:/Users/haynes/AppData/Local/R/win-library/4.2/xfun                 |C:/Users/haynes/AppData/Local/R/win-library/4.2/xfun                 |FALSE    |FALSE   |2023-03-24 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> |yaml        |2.3.7         |2.3.7         |C:/Users/haynes/AppData/Local/R/win-library/4.2/yaml                 |C:/Users/haynes/AppData/Local/R/win-library/4.2/yaml                 |FALSE    |FALSE   |2023-01-23 |CRAN (R 4.2.3) |TRUE  |C:/Users/haynes/AppData/Local/R/win-library/4.2          |
#> 
#> <!-- TAGEND:r_loaded -->
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

`info.txt` contains a plain text description of the tests.

test-`somename`.R contains the tests themselves. Tests should be written
using `testthat` syntax, e.g.

    test_that("'1:3' creates a sequence of 1, 2, 3", 
              expect_equal(1:3, c(1,2,3)))
