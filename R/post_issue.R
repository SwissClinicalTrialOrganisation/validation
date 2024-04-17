#' @param body issue body
#' @param title issue title
#' @param repo repository name
#'
#' @rdname get_issue
#' @importFrom gh gh
#' @export
#'
#' @examples
#' # post_issue("Some body text", title = "Issue title")

post_issue <- function(body, title, repo = sctoreports()){

  gh(repo = repo,
     endpoint = "POST /repos/:repo/issues",
     .send_headers = list("X-GitHub-Api-Version" = "2022-11-28"),
     body = body,
     title = title)
}

