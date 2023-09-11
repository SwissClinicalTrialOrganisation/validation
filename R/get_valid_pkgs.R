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



# issue |> replace_null() |> tibble::as_tibble()
