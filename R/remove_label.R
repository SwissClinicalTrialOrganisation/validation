#' @param issue issue number
#' @param label label to remove
#' @param repo repository name
#' @rdname get_issue
#' @export
#' @examples
#' # remove_label(issue = 1, label = "test")
#'
remove_label <- function(issue, label, repo = sctoreports()){

  gh(repo = repo,
     issue = issue,
     endpoint = "DELETE /repos/:repo/issues/:issue/labels/:label",
     .send_headers = list("X-GitHub-Api-Version" = "2022-11-28"),
     label = label)
}

