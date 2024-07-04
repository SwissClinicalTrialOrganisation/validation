#' helpers to replace nulls with empty strings
#' @noRd
replace_null <- function(object, ...) UseMethod("replace_null", object)

#' @noRd
replace_null.default <- function(issue){
  lapply(issue, as.character) |>
    lapply(function(x) dplyr::if_else(!(is.null(x) | length(x) == 0), x, ""))
}

#' @noRd
replace_null.list <- function(x){
  lapply(x, replace_null)
}
