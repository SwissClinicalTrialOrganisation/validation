#' Convert number of dependencies to a score
#' The score is based on the approach by the riskmetric package. It is based on
#' a logistic curve.
#'
#' See \href{https://pharmar.github.io/riskmetric/reference/metric_score.pkg_metric_dependencies.html}{riskmetric documentation} for further details.
#' @param downloads number of downloads
#' @keywords internal
#' @seealso \href{https://pharmar.github.io/riskmetric/reference/metric_score.pkg_metric_dependencies.html}{riskmetric documentation}
convert_deps_to_score <- function(deps){
  s <- 1/(1 + exp(-0.5 * (deps - 4)))
  min_original <- 1/(1 + exp(-0.5 * (0 - 4)))
  domain_mapper(s, min_original = min_original)
}
