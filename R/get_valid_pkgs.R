#' Get the list of validated packages from GitHub
#'
#' This function downloads issues from github and extracts relevant information from them
#' @param approved_only only return approved packages (logical)
#' @export
#' @returns dataframe including package, version, etc.
#' @importFrom dplyr bind_rows
#' @importFrom stringr str_detect
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
    pkgs <- pkgspkgs <- pkgs[is_approved(pkgs)]
  }
  out <- issues_to_df(pkgs)

  return(pkgs)
}


