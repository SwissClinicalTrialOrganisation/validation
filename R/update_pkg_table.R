#' Append new package data to existing package table
#'
#' Where a package version is already in the table, the new data will replace the old data.
#'
#' @param ... options passed to gen_pkg_table e.g. a list of issues from get_pkgs
#'
#' @return
#' @export
#' @importFrom dplyr bind_rows group_by slice_tail
#'
#' @examples
update_pkg_table <- function(...){

  release_date <- n_dependencies <- nr_downloads_12_months <- issue_num <-
    final_score <- package <- NULL

  existing <- load_pkg_table()
  new <- gen_pkg_table(...)

  existing |>
    mutate(release_date = as.Date(release_date),
           n_dependencies = as.numeric(n_dependencies),
           nr_downloads_12_months = as.numeric(nr_downloads_12_months),
           issue_num = as.numeric(issue_num),
           final_score = as.numeric(final_score),
           ) |>
    bind_rows(new) |>
    group_by(package, version) |>
    slice_tail(n = 1)

}
