#' get all labels associated with an issue
#' @noRd
get_labels <- function(issue){
  issue$labels |>
    purrr::map(~ .x$name) |>
    unlist()
}

#' check whether an issue has a particular label
#' @noRd
is_ <- function(issue, what){
  issue |>
    purrr::map(get_labels) |>
    purrr::map_lgl(~ what %in% .x)
}

#' convenience function to check for a package label
#' @noRd
is_package <- function(issues){
  issues |> is_("package")
}

#' convenience function to check for a package label
#' @noRd
is_test <- function(issues){
  issues |> is_("test")
}

#' convenience function to check for an approved label
#' @noRd
is_approved <- function(issues){
  issues |> is_("approved")
}

#' convenience function to check for a triage label
#' @noRd
is_triage <- function(issues){
  issues |> is_("triage")
}
