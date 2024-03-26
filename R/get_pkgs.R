#' get packages from github, or filter a list of issues for packages
#' @keywords internal
get_pkgs <- function(issues = NULL, ...){
  if(is.null(issues)){
    issues <- get_issues(...)
  }
  pkgs <- issues[is_package(issues)]
  pkgs
}
