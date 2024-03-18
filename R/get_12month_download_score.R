#' Generate a 12 month downloads risk score
#'
#' The score is based on the approach by the riskmatric package. It is a
#' simplification of the logistic curve.
#'
#' See \code{?metric_score.pkg_metric_downloads_1yr} for further details.
#'
#' @param package package name
#' @param from start date
#' @param to end date
#' @return a score between 0 and 1
#' @importFrom cranlogs cran_downloads
#' @seealso \code{\link{metric_score.pkg_metric_downloads_1yr }}
#'
#' @examples
#' get_12month_download_score("ggplot2")
#' get_12month_download_score("secuTrialR")
#'
get_12month_download_score <- function(package,
                                       from = Sys.Date() - 365,
                                       to = Sys.Date()){

  if(length(package) > 1) stop("Only one package at a time...")

  downloads <- cranlogs::cran_downloads(package, from = from, to = to)
  n <- sum(downloads$count)

  # scoring formula from riskmetric :-
  fn <- function(x) 1 - 1.5 / (x / 1e5 + 1.5)

  return(fn(n))

}


