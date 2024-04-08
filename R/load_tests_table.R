#' Load the flat file of tested functions from github
#'
#' Github contains a flat file of the package validation results. This function
#' retrieves that file.
#' @importFrom readr read_csv
#' @describeIn load_pkg_table Load a dataset of test results
#' @export
load_tests_table <- function(){
  read_csv("https://raw.githubusercontent.com/SwissClinicalTrialOrganisation/pkg_validation/main/tables/package_tests.csv") |>
    suppressMessages()
}
