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

  out <- pkgs |> purrr::map(extract_elements_pkg)
  out <- pkgs |> purrr::map(extract_elements_pkg) |> dplyr::bind_rows()

  return(out)
}

get_labels <- function(issue){
  issue$labels |>
    purrr::map(~ .x$name) |>
    unlist()
}

is_ <- function(issue, what){
  issue |>
    purrr::map(get_labels) |>
    purrr::map_lgl(~ what %in% .x)
}

is_package <- function(issues){
  issues |> is_("package")
}

is_approved <- function(issues){
  issues |> is_("approved")
}


extract_elements_pkg <- function(issue){
  body <- issue$body
  body <- stringr::str_replace_all(body, "\\r\\n", "CARRIAGERETURN")
  body <- stringr::str_replace_all(body, "\\n\\n", "CARRIAGERETURN")
  body <- stringr::str_split(body, "CARRIAGERETURN") |> unlist()
  body <- body[body != ""]
  elements <- data.frame(body = body) |>
    dplyr::mutate(new = stringr::str_detect(body, "^##"),
                  info_n = cumsum(new)) |>
    dplyr::summarize(.by = c(new, info_n),
              body = paste(body, collapse = "\n")) |>
    tidyr::pivot_wider(names_from = new, values_from = body) |>
    dplyr::select(-info_n) |>
    dplyr::rename(question = 1,
                  answer = 2) |>
    dplyr::mutate(question = dplyr::case_when(question == "### Name" ~ "name",
                                              question == "### What package have you validated?" ~ "package",
                                              question == "### What version of the package have you validated?" ~ "version",
                                              question == "### Package purpose" ~ "purpose",
                                              question == "### Package authors is/are" ~ "authors",
                                              question == "### The package has an associated publication" ~ "pub",
                                              ))
  out <- as.list(elements$answer)
  names(out) <- elements$question
  url <- issue$url |> stringr::str_replace("api.github.com/repos", "github.com")
  out$issue_url <- url

  return(out)
}

# issue |> replace_null() |> tibble::as_tibble()
