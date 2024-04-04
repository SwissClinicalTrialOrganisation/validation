#' Convert number of downloads to a score
#' The score is based on the approach by the riskmetric package. It is based on a
#' simplification of the logistic curve.
#'
#' See \href{https://pharmar.github.io/riskmetric/reference/metric_score.pkg_metric_downloads_1yr.html}{riskmetric documentation} for further details.
#' @param downloads number of downloads
#' @keywords internal
#' @seealso \href{https://pharmar.github.io/riskmetric/reference/metric_score.pkg_metric_downloads_1yr.html}{riskmetric documentation}
convert_downloads_to_score <- function(downloads){
  downloads[is.na(downloads)] <- 0
  1.5 / (downloads / 1e5 + 1.5)
}
