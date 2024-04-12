#' Validate the inputs for package or function tests
#'
#' @description
#' These functions validate the inputs from package or function tests.
#'
#' Both functions return a list with two elements - an indicator of whether the
#' validation passed without any errors and a character indicating what the error(s)
#' was/were. The character string is formated as if it were a comment to a GitHub
#' issue.
#'
#' The functions are not intended to be used directly by the user, but are called
#' by a github action with the results posted as a comment to github.
#'
#' `validate_pkg_issue` checks the values from a package issue.
#'
#' `validate_test_issue` checks the values from a function test issue.
#'
#' @param score the output from calculate_pkg_score for a single package
#' @return list wit two elements: score_ok (logical) and message (character)
#' @export
validate_pkg_issue <- function(score){
  if(is.na(score$final_score)){
    prefixes <- c("The package author", "The package maintainer", "The package purpose",
                  "Whether the package is on CRAN", "Whether the package has vignettes",
                  "Whether the package has bug reporting", "How well code is documented",
                  "Whether the package has tests")

    questions <- c("author", "maintainer", "purpose", "on_cran", "has_vignettes",
                   "bug_reporting_active", "source_code_documented", "has_tests")

    message <- mapply(function(prefix, question){
      question2 <- question
      map <- get(paste0(question, "_map"))
      if(!question %in% names(map)) question2 <- "txt"
      if(is.na(score[[paste0(question, "_score")]])){
        paste0(prefix, " seems to be invalid. Available options are '",
               paste(map[[question2]], collapse = "', '"), "'.")
      }
    }, prefixes, questions)

    if(is.na(score$n_dependencies_score)){
      message <- c(message, "The number of dependencies seems to be invalid. Please provide a number.")
    }

    if(is.na(score$not_cran_source) & score$on_cran == "No"){
      message <- c(
        message,
        "The source of the package is not CRAN or Bioconductor, but the source is missing. Please provide one."
        )
    }

    message <- message[sapply(message, function(x) !is.null(x))]

    if(length(message) == 0){
      message <- "@aghaynes... please investigate. Something is wrong, but I dont know what..."
    } else {
      message <- paste(message[!sapply(message, is.null)], collapse = "\n\n")
      message <- paste(message, "Please edit your issue above and correct the errors.",
                       collapse = "\n\n")
    }

    list(score_ok = FALSE,
         message = message)
  } else {
    list(score_ok = TRUE,
         message = "")
  }
}
