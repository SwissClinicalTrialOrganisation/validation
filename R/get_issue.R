#' get a specific issue from github
#' @param issue the issue number
#' @param repo the repository to get the issue from
#' @keywords internal
get_issue <- function(issue, repo = sctoreports()){
  issue <- gh::gh(repo = repo,
                  endpoint = paste0("/repos/:repo/issues/", issue),
                  .limit = Inf,
                  .params = list(state = "all",
                                 "X-GitHub-Api-Version" = "2022-11-28"))
  return(issue)
}
