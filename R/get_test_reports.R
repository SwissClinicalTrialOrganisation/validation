#' Get a data frame of test reports from github issues
#'
#' @param repo repository to get issues from
#' @param approved_only only return approved packages (logical)
#'
#' @return dataframe
#' @export
#' @examples
get_test_reports <- function(repo = sctoreports(),
                             approved_only = FALSE){
  issues <- get_issues(repo)

  if(approved_only){
    issues <- issues[is_approved(issues)]
  }

  tests <- issues[is_test(issues)]
  out <- issues_to_df(tests, extract_elements_test)

  # extract extra information
  out$r_version <- out$session_info |>
    stringr::str_extract("R version \\d\\.\\d\\.\\d") |>
    stringr::str_extract("\\d\\.\\d\\.\\d")
  out$os <- out$session_info |>
    stringr::str_replace_all("\\n", "   ") |>
    stringr::str_extract("Running under: .* Matrix") |>
    stringr::str_remove("Running under: ") |>
    stringr::str_remove("   Matrix")
  out$approved <- is_approved(tests)
  out$state <- sapply(tests, function(x) x$state)

  return(out)
}
