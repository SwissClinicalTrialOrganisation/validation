#' Generate a table with the function tests
#'
#' This is intended for use by a github action to generate a table for the website
#'
#' @param tests NULL or a list of issues from \code{get_issues}
#' @param ... options passed to \code{get_issues}
#' @export
#' @describeIn gen_pkg_table Generate a table of function tests
#' @importFrom dplyr filter select
gen_tests_table <- function(tests = NULL, ...){

  if(is.null(tests)){
    tests <- get_test_reports()
  }
  tests |>
    return()

}

