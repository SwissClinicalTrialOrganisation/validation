#' Check whether an issue has a particular label
#'
#' @description
#' These functions provide a way to check whether an issue has a particular label.
#'
#' \code{is_} is the main function. The others are wrappers around this one.
#'
#' \code{is_package} checks for a package label.
#'
#' \code{is_test} checks for a test label.
#'
#' \code{is_approved} checks for an approved label.
#'
#' \code{is_triage} checks for a triage label.
#'
#' \code{get_labels} gets all labels associated with an issue.
#'
#'
#' @param issue a specific issue
#' @param issues a list of issues
#' @param what the label to check for
#' @importFrom purrr map map_lgl
#'
#' @export
#' @examples
#' # issues <- get_issues()
#' # is_package(issues)
#'
#' # issue <- get_issue(21)
#' # is_package(list(issue))
is_ <- function(issues, what){
  issues |>
    map(get_labels) |>
    map_lgl(~ what %in% .x)
}

#' convenience function to check for a package label
#' @rdname is_
is_package <- function(issues){
  issues |> is_("package")
}

#' convenience function to check for a test label
#' @rdname is_
is_test <- function(issues){
  issues |> is_("test")
}

#' convenience function to check for an approved label
#' @rdname is_
is_approved <- function(issues){
  issues |> is_("approved")
}

#' convenience function to check for a triage label
#' @rdname is_
is_triage <- function(issues){
  issues |> is_("triage")
}

#' get all labels associated with an issue
#' @rdname is_
get_labels <- function(issue){
  issue$labels |>
    purrr::map(~ .x$name) |>
    unlist()
}
