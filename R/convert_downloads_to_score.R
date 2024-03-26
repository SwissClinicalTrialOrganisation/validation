#' Convert number of downloads to a score
#' The score is based on the approach by the riskmetric package. It is a
#' simplification of the logistic curve.
#'
#' See \code{?metric_score.pkg_metric_downloads_1yr} for further details.
#' @param downloads number of downloads
#' @keywords internal
#' @seealso \code{\link{metric_score.pkg_metric_downloads_1yr }}
convert_downloads_to_score <- function(downloads){
  downloads[is.na(downloads)] <- 0
  1.5 / (downloads / 1e5 + 1.5)
}
