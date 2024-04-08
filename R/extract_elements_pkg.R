#' extract the useful elements from an issue about a package
#' @keywords internal
#' @importFrom tidyr pivot_wider
#' @importFrom dplyr summarize mutate select rename
#' @importFrom stringr str_replace_all str_split str_extract str_remove str_replace
extract_elements_pkg <- function(issue){

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
      question == "### Is the package available from CRAN or bioconductor?" ~ "on_cran",

      grepl("### Is source code available, accessible and documented", question) ~ "source_code_documented",

      question == "### Number of downloads in the last 12 months" ~ "nr_downloads_12_months",

      grepl("### Bug reporting", question) ~ "bug_reporting_active",

      question == "### Does the package have one or more vignettes?" ~ "has_vignettes",

      grepl("### Does the package have unit and/or function tests", question) ~ "has_tests",
    ))

  out <- as.list(elements$answer)
  names(out) <- elements$question
  # add other pieces of information from outside the body
  url <- issue$url |> str_replace("api.github.com/repos", "github.com")
  out$n_dependencies <- as.numeric(trimws(out$n_dependencies))
  out$nr_downloads_12_months <- as.numeric(trimws(out$nr_downloads_12_months))
  if(out$release_date != "_No response_"){
    out$release_date <- trimws(out$release_date)
  } else {
    out$release_date <- ""
  }
  out$issue_url <- url
  out$issue_num <- issue$number
  out$user <- issue$user$login
  out$approved <- is_approved(list(issue))
  out$state <- issue$state
  out$create_date <- issue$created_at |> substr(1, 10)
  out$update_date <- issue$updated_at |> substr(1, 10)
  out$close_date <- ifelse(!is.null(issue$closed_at),
                            issue$closed_at|> substr(1, 10),
                            "")
  # add some tags?

  return(out)
}
