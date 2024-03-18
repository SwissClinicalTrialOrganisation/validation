#' Get the number of dependencies for a package
#'
#' @param package package name
#' @param ... additional arguments passed to
#' \code{\link{tools::package_dependencies}}. See details for more information.
#' @details
#' The \code{recursive} and \code{reverse} arguments are perhaps of most interest.
#' \code{recursive} details the number of dependencies of the package, including
#' those that are dependencies of dependencies. \code{reverse} details the number
#' of packages that depend on the package, which may be an indicator of a high
#' quality package.
#'
#' @return integer: the number of dependencies
#' @export
#'
#' @seealso \code{\link{tools::package_dependencies}}
#'
#' @examples
#' get_n_deps("nlme")
#' get_n_deps("validation")
#' get_n_deps("dplyr", reverse = TRUE)
#'
get_n_deps <- function(package, ...){
  if(length(package) > 1) stop("Only one package at a time...")

  deps <- tools::package_dependencies(package, ...) |> unlist()

  return(length(deps))
}
