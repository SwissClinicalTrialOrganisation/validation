#' @keywords internal
#' extract the useful text elements from an issue
extract_elements_test <- function(issue){
  # most information in the body of the issue
  body <- issue$body
  body <- stringr::str_replace_all(body, "\\r\\n", "CARRIAGERETURN")
  body <- stringr::str_replace_all(body, "\\n\\n", "CARRIAGERETURN")
  body <- stringr::str_split(body, "CARRIAGERETURN") |> unlist()
  body <- body[body != ""]
  elements <- data.frame(body = body) |>
    dplyr::mutate(new = stringr::str_detect(body, "^##"),
                  info_n = cumsum(new)) |>
    # concatenate multiple lines
    dplyr::summarize(.by = c(new, info_n),
                     body = paste(body, collapse = "\n")) |>
    # one row per piece of information
    tidyr::pivot_wider(names_from = new, values_from = body) |>
    dplyr::select(-info_n) |>
    dplyr::rename(question = 1,
                  answer = 2) |>
    # rename the text elements
    dplyr::mutate(question = dplyr::case_when(
      question == "### Name" ~ "name",
      question == "### Name of the package you have tested" ~ "package",
      question == "### What version of the package have you tested?" ~ "version",
      question == "### When was this package tested?" ~ "test_date",
      question == "### What was tested?" ~ "tests",
      question == "### Test results" ~ "test_result",
      question == "### Test output" ~ "test_evidence",
      question == "### Session info" ~ "session_info",
      question == "### Where is the test code located for these tests?" ~ "code_location",
      question == "### Where the test code is located in a git repository, add the git commit SHA" ~ "code_sha",
      # grepl("### Is the package 'known'", question) ~ "pkg_known",
      # question == "### Where the test code is located in a git repository, add the git commit SHA" ~ "n_downloads",
      # grepl("### Bug reporting", question) ~ "bug_reports",
      # question == "### Does the package have vignettes?" ~ "pkg_vignettes",
      # question == "### Does the package have tests?" ~ "pkg_tests",
      # question == "### Final risk score" ~ "final_risk",
    ))
  out <- as.list(elements$answer)
  names(out) <- elements$question
  # add other pieces of information from outside the body
  url <- issue$url |> stringr::str_replace("api.github.com/repos", "github.com")
  out$issue_url <- url
  out$issue_num <- issue$number
  out$user <- issue$user$login

  return(out)
}

