#' Add a new package skeleton
#'
#' This function will create the directory if it does not exist, and add a `info.txt` file with the package name, and a `setup-pkg.R` file with the necessary setup code.
#'
#' @param pkg package to be tested
#' @param funs functions to be tested
#' @param dir where to save the tests/skeleton
#'
#' @return a set of files in your working directory, which can be edited and
#'   uploaded to github
#' @export
#'
#' @examples
#' # test_skeleton(pkg = "dplyr", funs = c("select", "filter"))
test_skeleton <- function(pkg, funs, dir = getwd()){
  directory <- file.path(dir, pkg)

  if(!dir.exists(directory)){
    dir.create(directory, recursive = TRUE)
  }
  test_download <- get_tests(pkg, dir = directory)

  if(!test_download){

    write(c(paste("Tests for package", pkg)),
          file = file.path(directory, "info.txt"),
          sep = "\n")
    write(c(paste0("if(!require('", pkg, "')) install.packages('", pkg, "')"),
            paste0("library(", pkg, ")"),
            "library(testthat)",
            "withr::defer({",
            paste0("  detach(package:", pkg, ")"),
            "}, teardown_env())"),
          file = file.path(directory, paste0("setup-", pkg, ".R")),
          sep = "\n")
  }

  lapply(funs, function(f){
    file <- file.path(directory, paste0("test-", f, ".R"))
    if(!file.exists(file)){
      write(c("# Write relevent tests for the function in here",
              "# Consider the type of function:",
              "#   - is it deterministic or statistic?",
              "#   - is it worth checking for errors/warnings under particular conditions?",
              "local_edition(3)",
              "",
              ""),
            file = file,
            sep = "\n")
    } else {
      warning(paste("File", file, "already exists - edit that file instead"))
    }
    return(invisible())
  })

  return(invisible())

}


