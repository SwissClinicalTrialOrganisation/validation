#' Append new issue data to existing tables
#'
#' Where an issue is already in the table, the new data will replace the old data.
#'
#' @param ... options passed to gen_pkg_table e.g. a list of issues from get_pkgs
#'
#' @export
#' @importFrom dplyr bind_rows group_by slice_tail ends_with
#'
#' @examples
#' # update_pkg_table()
update_pkg_table <- function(...){

  release_date <- n_dependencies <- nr_downloads_12_months <- issue_num <-
    final_score <- package <- NULL

  existing <- load_pkg_table()
  new <- gen_pkg_table(...) |>
    mutate(across(ends_with("date"), as.Date))

  existing |>
    mutate(across(ends_with("date"), as.Date),
           n_dependencies = as.numeric(n_dependencies),
           nr_downloads_12_months = as.numeric(nr_downloads_12_months),
           issue_num = as.numeric(issue_num),
           final_score = as.numeric(final_score),
           ) |>
    bind_rows(new) |>
    group_by(package, desc(version), issue_num) |>
    slice_tail(n = 1)

}
