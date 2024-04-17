#' Get the list of packages that have tests in a repository
#'
#' Tests are assumed to be in a `tests` directory in the repository.
#'
#' @param repo repository to check for tests
#'
#' @return character vector of package (directory) names
#' @export
#'
#' @examples
#' get_tested_pkgs()
get_tested_pkgs <- function(repo = sctotests()){
  files <- try(gh(repo = repo,
                  endpoint = paste0("GET /repos/:repo/contents/tests"),
                  .params = list("X-GitHub-Api-Version" = "2022-11-28")),
               silent = TRUE)

  files2 <- lapply(files, function(x) x$path)
  files2 <- unlist(files2)
  files2 <- str_replace(files2, "^tests/", "")
  packages <- files2[files2 != ".gitignore"]

  return(packages)
}


