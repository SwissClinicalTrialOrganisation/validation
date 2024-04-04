#' @param issue a single function test issue
#' @return list wit two elements: ok (logical) and message (character)
#' @rdname validate_pkg_issue
validate_test_issue <- function(issue){
  message <- NULL
  if(is.na(issue$package)){
    message <- c(message, "Please enter a package name")
  }
  if(is.na(issue$version)){
    message <- c(message, "Please enter a package version")
  }
  if(is.na(issue$test_date)){
    message <- c(message, "Please enter a test date")
  }
  if(is.na(issue$tests)){
    message <- c(message, "Please enter a test description")
  }
  if(is.na(issue$test_result)){
    message <- c(message, "Please enter a test results (PASS or FAIL)")
  }
  if(is.na(issue$test_evidence)){
    message <- c(message, "Please enter evidence of test results")
  }
  if(is.na(issue$session_info)){
    message <- c(message, "Please enter session info")
  }
  if(is.na(issue$session_info)){
    message <- c(message, "Please provide a location where code is saved")
  }

  if(is.null(message)){
    list(ok = TRUE,
         message = "")

  } else {
    list(ok = FALSE,
         message = paste(message, collapse = "\n\n"))
  }
}
