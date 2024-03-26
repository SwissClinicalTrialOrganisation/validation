#' Get comments for a particular issue
#'
#' Download any comments to a particular issue in a particular repository.
#'
#' @param issue issue number
#' @param repo repository name
#'
#' @return a list of comments
#' @keywords internal
#' @examples
get_comments <- function(issue, repo = sctoreports()){
  comments <- gh::gh(repo = repo,
                     issue = issue,
                     endpoint = "/repos/:repo/issues/:issue/comments",
                     .limit = Inf,
                     .params = list("X-GitHub-Api-Version" = "2022-11-28"))
  # The bodies of the messages then probably need taking apart...
  comments
}

# get_comments(issue = 1)

