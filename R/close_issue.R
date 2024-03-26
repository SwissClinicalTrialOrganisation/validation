#' Close an issue
#'
#' This function allows close on an issue.
#'
#' It's mainly to enable the automated closing of issues from github
#' actions.
#'
#' @param issue issue number
#' @param repo repository name
#'
#' @return
#' @keywords internal
#'
#' @examples
#' # post_comment(issue = 1, comment = "This is a test comment")
close_issue <- function(issue, repo = sctoreports()){

  comments <- gh::gh(repo = repo,
                     issue = issue,
                     endpoint = "POST /repos/:repo/issues/:issue",
                     .params = list("X-GitHub-Api-Version" = "2022-11-28"),
                     state = "closed")

}

