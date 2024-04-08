#' extract the useful text elements from a test issue
#' @keywords internal
#' @importFrom tidyr pivot_wider
#' @importFrom dplyr summarize mutate select rename
#' @importFrom stringr str_replace_all str_split str_extract str_remove str_replace
extract_elements_test <- function(issue){

  new <- info_n <- NULL

  # most information in the body of the issue
  body <- issue$body
  body <- str_replace_all(body, "\\r\\n", "CARRIAGERETURN")
  body <- str_replace_all(body, "\\n\\n", "CARRIAGERETURN")
  body <- str_split(body, "CARRIAGERETURN") |> unlist()
  body <- body[body != ""]
  elements <- data.frame(body = body) |>
    mutate(new = str_detect(body, "^##"),
           info_n = cumsum(new)) |>
    # concatenate multiple lines
    summarize(.by = c(new, info_n),
                     body = paste(body, collapse = "\n")) |>
    # one row per piece of information
    pivot_wider(names_from = new, values_from = body) |>
    select(-info_n) |>
    rename(question = 1,
                  answer = 2) |>
    # rename the text elements
    mutate(question = dplyr::case_when(
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
    ))
  out <- as.list(elements$answer)
  names(out) <- elements$question
  # add other pieces of information from outside the body
  url <- issue$url |> str_replace("api.github.com/repos", "github.com")
  out$issue_url <- url
  out$issue_num <- issue$number
  out$user <- issue$user$login
  out$r_version <- out$session_info |>
    str_extract("R version \\d\\.\\d\\.\\d") |>
    str_extract("\\d\\.\\d\\.\\d")
  out$os <- out$session_info |>
    str_replace_all("\\n", "   ") |>
    str_extract("Running under: .* Matrix") |>
    str_remove("Running under: ") |>
    str_remove("   Matrix")
  out$approved <- is_approved(list(issue))
  out$state <- issue$state
  out$create_date <- issue$created_at |> substr(1, 10)
  out$update_date <- issue$updated_at |> substr(1, 10)
  out$close_date <- ifelse(!is.null(issue$closed_at),
                           issue$closed_at|> substr(1, 10),
                           "")

  return(out)
}

