#' Load the flat file of validated packages from github
#'
#' Github contains a flat file of the package validation results. This function
#' retrieves that file.
#' @importFrom readr read_csv
#' @export
load_pkg_table <- function(){
  read_csv("https://raw.githubusercontent.com/SwissClinicalTrialOrganisation/pkg_validation/main/res/validated_packages.csv")
}
