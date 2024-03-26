
<!-- README.md is generated from README.Rmd. Please edit that file -->

# validation

<!-- badges: start -->
<!-- badges: end -->

The goal of validation is to provide an easy approach for the
documentation and implementation of package and function tests for the
SCTO R validation project. Package validations themselves can be found
in the [pkg_validation
repository](https://github.com/SwissClinicalTrialOrganisation/pkg_validation).

## Installation

You can install the development version of validation from
[GitHub](https://github.com/SwissClinicalTrialOrganisation/validation)
with:

``` r
# install.packages("devtools")
devtools::install_github("SwissClinicalTrialOrganisation/validation")
```

## Testing

The package contains a `test` function which is used to run all tests
for a named package.

``` r
library(validation)
## basic example code

# test("presize")
```

<!-- The output of this function is a string which can be copied and pasted into an appropriate issue on the GitHub `pkg_validation` repository. -->

### Implementing new tests

All tests are stored in the [`validation_tests`
repository](https://github.com/SwissClinicalTrialOrganisation/validation_tests)
in package specific folders. E.g. the `tests/presize` folder contains
tests relevant to the `presize` package.

(At least) three files are required. The test_skeleton function can be
used to create these files.

1.  setup-`package`.R
2.  info.txt
3.  test-`function`.R

The `setup-package.R` file installs, updates and/or loads the package
being tested and any other relevant steps (e.g. loading a dataset).

`info.txt` contains a plain text description of the tests.

test-`function`.R contains the tests themselves. Tests should be written
using `testthat` syntax, e.g.

    test_that("'1:3' creates a sequence of 1, 2, 3", 
              expect_equal(1:3, c(1,2,3)))
