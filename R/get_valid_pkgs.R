#' Read validated packages from some location
get_valid_pkgs <- function(){
  # tibble::tribble(
  #   ~package, ~version, ~src, ~pkg_risk, ~pkg_risk_why, ~validated_for, ~tests, ~tests_passed,
  #   "ggplot2", "3.4.1", "CRAN", "low", "trusted source", "data viz", TRUE, TRUE,
  #   "dplyr", "1.1.1", "CRAN", "low", "trusted source", "data wrangling", TRUE, TRUE,
  # )
  # jsonlite::fromJSON("validated_packages.json")


  repo <- "aghaynes/pkg_validation"
  issues <- gh::gh(repo = repo,
                   endpoint = "/repos/:repo/issues",
                   .limit = Inf,
                   .params = list(state = "all",
                                  "X-GitHub-Api-Version" = "2022-11-28"))
  # comments <- gh::gh(repo = repo,
  #                    endpoint = "/repos/:repo/issues/comments",
  #                    .limit = Inf,
  #                    .params = list("X-GitHub-Api-Version" = "2022-11-28"))
  # The bodies of the messages then probably need taking apart...

  # issues |>
  #   purrr::map(get_labels)

  pkgs <- issues[is_package(issues)]
  pkgs <- pkgs[is_approved(pkgs)]

  out <- pkgs |> purrr::map(extract_elements_pkg) |> dplyr::bind_rows()

  return(out)
}



#' extract the useful text elements from an issue
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
    dplyr::mutate(question = dplyr::case_when(question == "### Name" ~ "name",
                                              question == "### What package have you validated?" ~ "package",
                                              question == "### What version of the package have you validated?" ~ "version",
                                              question == "### Package purpose" ~ "purpose",
                                              question == "### Package authors is/are" ~ "authors",
                                              question == "### The package has an associated publication" ~ "pub",
                                              ))
  out <- as.list(elements$answer)
  names(out) <- elements$question
  # add other pieces of information from outside the body
  url <- issue$url |> stringr::str_replace("api.github.com/repos", "github.com")
  out$issue_url <- url

  return(out)
}

# issue |> replace_null() |> tibble::as_tibble()
