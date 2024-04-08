#' Get the release date of a CRAN package
#'
#' CRAN packages have a release date associated with them. This function downloads
#' that date and returns it as a date object.
#'
#' If the package does not exist on CRAN, the function asks the user to search
#' elsewhere for the information.
#'
#' @param pkg a package name
#' @importFrom pkgsearch cran_package
#' @export
#' @return character string containing either the date or a message to check elsewhere
#' @examples
#'
#' get_release_date("dplyr")
#'

get_release_date <- function(pkg){
  if(length(pkg) > 1) stop("Only one package at a time...")

  cran_details <- try(pkgsearch::cran_package(pkg), silent = TRUE)

  if(inherits(cran_details, "try-error")) {
    out <- "Package not found on CRAN. \nPlease check the package name or another location (BioC, github, etc)"
  } else {
    out <- cran_details$date |>
      substr(1, 10)
  }

  return(out)
}
