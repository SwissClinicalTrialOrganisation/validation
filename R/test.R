


test <- function(pkg){

  testthat::test_dir(
    system.file(glue::glue("tests/{pkg}"), package = "sctovalidation"),
    stop_on_failure = FALSE
  )

}

