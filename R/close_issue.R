#' @param issue issue number
#' @param repo repository name
#'
#' @rdname get_issue
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

