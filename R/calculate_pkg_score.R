#' Convert the text risk metric answers to numeric values and calculate a score
#'
#' The score is the mean of the individual scores for each question.
#' @param pkgs a list of package objects
#' @importFrom dplyr rename mutate left_join
calculate_pkg_score <- function(pkgs = NULL){

  if(is.null(pkgs)) pkgs <- get_pkgs()

  pkg_df <- pkgs |>
    issues_to_df(extract_elements_pkg)

  # map values to text
  # see the lookup tables in lookup_maps.R
  pkg_df |>
    left_join(author_map, by = "author") |>
    left_join(maintainer_map, by = "maintainer") |>
    left_join(purpose_map, by = "purpose") |>
    left_join(on_cran_map |> rename(on_cran_score = score),
              by = c("on_cran" = "txt")) |>
    left_join(has_vignettes_map |> rename(has_vignettes_score = score),
              by = c("has_vignettes" = "txt")) |>
    left_join(bug_reporting_active_map |> rename(bug_reporting_active_score = score),
              by = c("bug_reporting_active" = "txt")) |>
    left_join(source_code_documented_map |> rename(source_code_documented_score = score),
              by = c("source_code_documented" = "txt")) |>
    left_join(has_tests_map, by = "has_tests") |>
    mutate(
      n_dependencies_score = convert_deps_to_score(n_dependencies),
      nr_downloads_12_months_score = convert_downloads_to_score(nr_downloads_12_months),
    ) |>
    mutate(final_score = (purpose_score + author_score + maintainer_score +
                           n_dependencies_score + on_cran_score +
                            source_code_documented_score +
                            nr_downloads_12_months_score +
                            bug_reporting_active_score +
                            has_vignettes_score +
                            has_tests_score
                                ) / 10,
           final_score_cat = cut(final_score, c(0, .25, .75, 1),
                                 labels = c("Low", "Medium", "High")))


}

