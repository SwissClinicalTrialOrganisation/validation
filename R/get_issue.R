#' Interact with the GitHub API to get or set issue information
#'
#' @description
#'
#' These functions provide various ways to interact with github issues.
#'
#' Getting issues:
#'
#' \code{get_issue} downloads a single issue from a repository.
#'
#' \code{get_issues} downloads all issues from a repository.
#'
#' \code{get_test_reports} downloads all issues from a repository, filtering those with
#' test labels, and converts the issue to a dataframe.
#'
#' Labels:
#'
#' \code{add_label} adds a particular label to an issue.
#'
#' \code{remove_label} removes a particular label from an issue.
#'
#' Comments:
#'
#' \code{get_comments} downloads all comments from an issue.
#'
#' \code{post_comment} posts a comment to an issue.
#'
#' Closing an issue:
#'
#' \code{close_issue} closes an issue.
#'
#' These functions are primarily for the use in github actions rather than for
#' the standard user.
#'
#' @param issue the issue number
#' @param repo the repository to get the issue from
#' @export
#' @examples
#' # get_issue(21)
get_issue <- function(issue, repo = sctoreports()){
  issue <- gh::gh(repo = repo,
                  endpoint = paste0("/repos/:repo/issues/", issue),
                  .limit = Inf,
                  .params = list(state = "all",
                                 "X-GitHub-Api-Version" = "2022-11-28"))
  return(issue)
}
