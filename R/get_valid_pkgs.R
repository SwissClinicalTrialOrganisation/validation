#' Get the list of validated packages from GitHub
#'
#' This function downloads issues from github and extracts relevant information from them
#' @param approved_only only return approved packages (logical)
#' @export
#' @returns dataframe including package, version, etc.
#' @examples
#' # only approved packages
#' get_valid_pkgs()
#' # all packages, regardless of status
#' get_valid_pkgs(FALSE)
get_valid_pkgs <- function(approved_only = TRUE){
  # tibble::tribble(
  #   ~package, ~version, ~src, ~pkg_risk, ~pkg_risk_why, ~validated_for, ~tests, ~tests_passed,
  #   "ggplot2", "3.4.1", "CRAN", "low", "trusted source", "data viz", TRUE, TRUE,
  #   "dplyr", "1.1.1", "CRAN", "low", "trusted source", "data wrangling", TRUE, TRUE,
  # )
  # jsonlite::fromJSON("validated_packages.json")


  # issues |>
  #   purrr::map(get_labels)

  pkgs <- get_pkgs()
  if(approved_only){
    pkgs <- pkgs[is_approved(pkgs)]
  }
  out <- issues_to_df(pkgs)

  return(out)
}

#' get packages from github, or filter a list of issues for packages
#' @keywords internal
get_pkgs <- function(issues = NULL, ...){
  if(is.null(issues)){
    issues <- get_issues(...)
  }
  pkgs <- issues[is_package(issues)]
}

#' issues are a list of items. this function converts it to a dataframe
#' @keywords internal
issues_to_df <- function(issues){
  issues |>
    purrr::map(extract_elements_pkg) |> #View()
    dplyr::bind_rows()
}
