#' Get a data frame of test reports from github issues
#'
#' @param repo repository to get issues from
#' @param approved_only only return approved packages (logical)
#'
#' @return dataframe
#' @rdname get_issue
get_test_reports <- function(repo = sctoreports(),
                             approved_only = FALSE){
  issues <- get_issues(repo)

  if(approved_only){
    issues <- issues[is_approved(issues)]
  }

  tests <- issues[is_test(issues)]
  out <- issues_to_df(tests, extract_elements_test)

  return(out)
}
