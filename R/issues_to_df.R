#' issues are a list of items. this function converts it to a dataframe
#' @keywords internal
#' @param fun function to apply to each issue (extract_elements_pkg or extract_elements_test)
issues_to_df <- function(issues, fun = extract_elements_pkg){
  issues |>
    map(fun) |> #View()
    bind_rows()
}
