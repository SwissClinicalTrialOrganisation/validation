#' Append new test data to existing tests table
#'
#' Where a package version is already in the table, the new data will replace the old data.
#'
#' @param ... options passed to gen_pkg_table e.g. a list of issues from get_pkgs
#'
#' @export
#' @importFrom dplyr bind_rows group_by slice_tail ends_with
#' @describeIn update_pkg_table Append new test data to existing tests table
update_tests_table <- function(...){

  package <- version <- issue_num <- approved <- NULL

  existing <- load_tests_table() |>
    mutate(issue_num = as.integer(issue_num),
           approved = as.logical(approved))
  new <- gen_tests_table(...) |>
    mutate(across(ends_with("date"), as.Date))

  existing |>
    mutate(across(ends_with("date"), as.Date),
           ) |>
    bind_rows(new) |>
    group_by(package, version, issue_num) |>
    slice_tail(n = 1)

}
