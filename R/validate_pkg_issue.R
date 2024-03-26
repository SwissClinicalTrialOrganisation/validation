#' validate the inputs for a package validation report
#' @param score the output from calculate_pkg_score for a single package
#' @return list wit two elements: score_ok (logical) and message (character)
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
