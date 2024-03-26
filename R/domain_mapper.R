#' Map a domain from one range to another
#'
#' @param value value to map from
#' @param min_original minimum of the original domain
#' @param max_original maximum of the original domain
#' @param min_range minimum of the desired domain
#' @param max_range maximum of the desired domain
#'
#' @return
#' @keywords internal
#'
#' @examples
#' domain_mapper(0.5, 0, 1, 0, 100)
domain_mapper <- function(value,
                          min_original = 0,
                          max_original = 1,
                          min_range = 0,
                          max_range = 1){

  # Perform linear normalization
  (value - min_original) / (max_original - min_original) * (max_range - min_range) + min_range

}
