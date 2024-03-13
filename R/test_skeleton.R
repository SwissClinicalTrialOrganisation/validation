#' Add a new package skeleton
#'
#' This function will create the directory if it does not exist, and add a `info.txt` file with the package name, and a `setup-pkg.R` file with the necessary setup code.
#'
#' @param pkg package to be tested
#' @param fun function to be tested
#'
#' @return
#' @export
#'
#' @examples
test_skeleton <- function(pkg, fun){
  directory <- file.path("inst", "tests", pkg)

  if(!dir.exists(directory)){
    dir.create(directory, recursive = TRUE)

    write(c(paste("Tests for package", pkg)),
          file = file.path(directory, "info.txt"),
          sep = "\n")
    write(c(paste0("library(", pkg, ")"),
            "library(testthat)",
            "withr::defer({",
            paste0("  detach(package:", pkg, ")"),
            "}, teardown_env())"),
          file = file.path(directory, paste0("setup-", pkg, ".R")),
          sep = "\n")
  }

  lapply(fun, function(f){
    file <- file.path(directory, paste0("test-", f, ".R"))
    if(!file.exists(file)){
      write(c("# Write relevent tests for the function in here",
              "# Consider the type of function:",
              "#   - is it deterministic or statistic?",
              "#   - is it worth checking for errors/warnings under particular conditions?"),
            file = file,
            sep = "\n")
    } else {
      warning(paste("File", file, "already exists - edit that file instead"))
    }
    return(invisible())
  })

  return(invisible())

}


