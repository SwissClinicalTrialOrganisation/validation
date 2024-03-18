#' SCTO repositories
#'
#' shortcuts for the SCTO package validation repositories. The validation platform
#' consists of 3 repositories: a repository for reporting the validations
#' (pkg_validation), one which contains tests for specific packages
#' (validation_tests), and one for this package itself (validation). These three
#' functions provide the names of the three repositories.
#' @return the repository name (validation)
#' @export
#' @rdname repos
sctoreports <- function() return("SwissClinicalTrialOrganisation/pkg_validation")
#' @rdname repos
#' @export
sctotests <- function() return("SwissClinicalTrialOrganisation/validation_tests")
#' @rdname repos
#' @export
sctopkg <- function() return("SwissClinicalTrialOrganisation/validation")

