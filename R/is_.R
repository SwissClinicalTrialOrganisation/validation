#' get all labels associated with an issue
get_labels <- function(issue){
  issue$labels |>
    purrr::map(~ .x$name) |>
    unlist()
}

#' check whether an issue has a particular label
is_ <- function(issue, what){
  issue |>
    purrr::map(get_labels) |>
    purrr::map_lgl(~ what %in% .x)
}

#' convenience function to check for a package label
is_package <- function(issues){
  issues |> is_("package")
}

#' convenience function to check for an approved label
is_approved <- function(issues){
  issues |> is_("approved")
}
