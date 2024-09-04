#' Get the number of dependencies for a package
#'
#' @param package package name
#' @param fields list of fields to check for dependencies.
#'   Defaults to \code{c("Depends", "Imports")}
#' @param ... additional arguments passed to \code{packageDescription}.
#' @details
#' The \code{recursive} and \code{reverse} arguments are perhaps of most interest.
#' \code{recursive} details the number of dependencies of the package, including
#' those that are dependencies of dependencies. \code{reverse} details the number
#' of packages that depend on the package, which may be an indicator of a high
#' quality package. This function uses the
#' function from the tools package.
#'
#' @return integer: the number of dependencies
#' @importFrom utils packageDescription
#' @export
#'
#' @seealso
#' \code{\link[utils]{packageDescription}}
#'
#' For CRAN packages, \code{\link[tools]{package_dependencies}} may be of interest.
#' @examples
#' \dontrun{
#' get_n_deps("nlme")
#' get_n_deps("validation")
#' get_n_deps("dplyr", reverse = TRUE)
#' }
#'
get_n_deps <- function(package, fields = c("Depends", "Imports"), ...){
  if(length(package) > 1) stop("Only one package at a time...")

  dsc <- packageDescription(package, fields = fields, ...)
  deps <- lapply(dsc, strsplit, split = ",") |>
    unlist() |>
    trimws()

  deps <- deps[!grepl("^R ", deps)]

  length(deps)

  return(length(deps))
}
