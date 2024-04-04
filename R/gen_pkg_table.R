#' Generate a table with the package validation statistics
#'
#' This is intended for use by a github action to generate a table for the website
#'
#' @param pkgs NULL or a list of issues from \code{get_issues}
#' @param ... options passed to \code{get_issues}
#' @export
#' @importFrom dplyr filter select
gen_pkg_table <- function(pkgs = NULL, ...){

  package <- author_score <- nr_downloads_12_months_score <- NULL

  if(is.null(pkgs)){
    pkgs <- get_pkgs(...)
  }
  pkgs |>
    calculate_pkg_score() |>
    # remove test cases
    filter(package != "TEST") |>
    select(-(author_score:nr_downloads_12_months_score))

}

