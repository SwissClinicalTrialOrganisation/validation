#' @param issue issue number
#' @param comment the comment to be made
#' @param repo repository name
#'
#' @rdname get_issue
#' @importFrom gh gh
#'
#' @examples
#' # post_comment(issue = 1, comment = "This is a test comment")
post_comment <- function(issue, comment, repo = sctoreports()){

  gh(repo = repo,
     issue = issue,
     endpoint = "POST /repos/:repo/issues/:issue/comments",
     .send_headers = list("X-GitHub-Api-Version" = "2022-11-28"),
     body = comment)
}

