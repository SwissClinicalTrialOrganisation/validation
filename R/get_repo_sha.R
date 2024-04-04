#' get the most recent commit SHA for a repo
#' @param repo github repository to download from
#' @param branch branch to get the SHA from
#' @keywords internal
get_repo_sha <- function(repo = sctotests(), branch = "main"){
  resp <- gh(repo = repo,
             endpoint = paste0("GET /repos/:repo/commits/", branch),
             .params = list("X-GitHub-Api-Version" = "2022-11-28"))
  return(resp$sha)
}
