#' extract the useful text elements from an issue
#' @keywords internal
#' @importFrom tidyr pivot_wider
extract_elements_pkg <- function(issue){
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

      # !! IF QUESTION TEXT CHANGES, JUST ADD NEW LINES,
      #    DO NOT EDIT THE EXISTING ONES (backwards compatibility)

      question == "### Name" ~ "name",
      question == "### What is your relationship with the SCTO?" ~ "scto_rel",

      question == "### Name of the package you have validated" ~ "package",

      question == "### Version number of the package evaluated" ~ "version",

      question == "### Date of release of the evaluated version of the package" ~ "release_date",

      question == "### The package author has..." ~ "author",

      question == "### Is there a maintainer listed for the package and are their contact details available?" ~ "maintainer",

      question == "### Package purpose" ~ "purpose",

      question == "### Number of dependencies" ~ "n_dependencies",

      question == "### Is the package on available from CRAN or bioconductor?" ~ "on_cran",

      grepl("### Is source code available, accessible and documented", question) ~ "source_code_documented",

      question == "### Number of downloads in the last 12 months" ~ "nr_downloads_12_months",

      grepl("### Bug reporting", question) ~ "bug_reporting_active",

      question == "### Does the package have one or more vignettes?" ~ "has_vignettes",

      grepl("### Does the package have unit and/or function tests", question) ~ "has_tests",
    ))

  out <- as.list(elements$answer)
  names(out) <- elements$question
  # add other pieces of information from outside the body
  url <- issue$url |> stringr::str_replace("api.github.com/repos", "github.com")
  out$n_dependencies <- as.numeric(trimws(out$n_dependencies))
  out$nr_downloads_12_months <- as.numeric(trimws(out$nr_downloads_12_months))
  if(out$release_date != "_No response_"){
    out$release_date <- as.Date(trimws(out$release_date))
  } else {
    out$release_date <- NA
  }
  out$issue_url <- url
  out$issue_num <- issue$number
  out$user <- issue$user$login
  out$approved <- is_approved(list(issue))
  out$state <- issue$state
  # add some tags?

  return(out)
}
