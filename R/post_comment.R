#' Make a comment on an issue
#'
#' This function allows to make a comment on an issue.
#'
#' It's mainly to enable the automated posting of comments to issues from github
#' actions
#'
#' @param issue issue number
#' @param comment the comment to be made
#' @param repo repository name
#'
#' @return
#' @keywords internal
#'
#' @examples
#' # post_comment(issue = 1, comment = "This is a test comment")
post_comment <- function(issue, comment, repo = sctoreports()){

  comments <- gh::gh(repo = repo,
                     issue = issue,
                     endpoint = "POST /repos/:repo/issues/:issue/comments",
                     .params = list("X-GitHub-Api-Version" = "2022-11-28"),
                     body = comment)
}

