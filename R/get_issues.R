#' get issues from github
#' @param issue the issue number
#' @param repo the repository to get the issues from
#' @rdname get_issue
get_issues <- function(repo = sctoreports()){
  issues <- gh(repo = repo,
               endpoint = "/repos/:repo/issues",
               .limit = Inf,
               .params = list(state = "all",
                              "X-GitHub-Api-Version" = "2022-11-28"))
  return(issues)
}
