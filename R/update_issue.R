#' Update a GH issue
#' @param issue issue number to update
#' @param ... arguments passed to gh
#' @param repo repository name
#'
#' ... could be e.g. body, title, labels (should be a list), state (open or closed)
#' see https://docs.github.com/en/rest/issues/issues?apiVersion=2022-11-28#update-an-issue
#'
#' @rdname get_issue
#' @importFrom gh gh
#' @export
#'
#' @examples
#' # post_issue("Some body text", title = "Issue title")
update_issue <- function(issue, ..., repo = sctoreports()){

  gh(repo = repo,
     issue = issue,
     endpoint = "PATCH /repos/:repo/issues/:issue",
     .send_headers = list("X-GitHub-Api-Version" = "2022-11-28"),
     ...)
}
