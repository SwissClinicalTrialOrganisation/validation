#' Download datasets from the SCTO validation tests repository
#'
#' Tests sometimes require specific datasets. Where a built-in dataset is insufficient,
#' a dataset that exists within the SCTO validation tests repository can be downloaded.
#'
#' This function can be used in the setup-pkg.R file so that the datasets are available
#' to the tests.
#'
#' @param dataset The filename of the dataset to download
#' @param repo the repository to download from
#' @param dir the directory to save the dataset to (purely for testing purposes
#' - this option should not be used in everyday use)
#'
#' @details
#' The function will download the dataset from the SCTO validation tests repository
#' to the working directory, which testthat sets to the directory containing the
#' test files. Therefore, the dataset can be downloaded and saved and used without
#' referring to any other directory. The setup-pkg.R file might then contain:
#'
#' \preformatted{
#' ...
#' library(testthat)
#'
#' get_test_data("mtcars.csv")
#' dat <- read.csv("mtcars.csv")
#'
#' withr::defer({
#' ...
#' }
#'
#'
#' @return TRUE if the dataset is downloaded successfully
#' @export
#'
#' @examples
#' # download the file to a temporary directory
#' tempdir <- tempdir()
#' get_test_data("mtcars.csv", dir = tempdir)
#' dat <- read.csv(file.path(tempdir, "mtcars.csv"))
#' unlink(tempdir)
#'
#' \dontrun{
#' # within the setup-pkg.R file
#' get_test_data("mtcars.csv")
#' # then load the data using an appropriate function
#' dat <- read.csv("mtcars.csv")
#' }
#'
get_test_data <- function(dataset, repo = sctotests(), dir = getwd()){
  if(length(dataset) > 1) stop("One dataset at a time please")

  files <- try(gh(repo = repo,
         endpoint = paste0("GET /repos/:repo/contents/datasets/", dataset),
         .params = list("X-GitHub-Api-Version" = "2022-11-28")),
      silent = TRUE)

  if(all(class(files) == "try-error")){
    cat(paste(dataset, "not found in repo ", repo, "\n"))
    return(FALSE)
  } else {
    file <- files$download_url
    # extract filenames from the URLs
    filename <- lapply(file, function(x) strsplit(x, "/")[[1]][length(strsplit(x, "/")[[1]])])
    download.file(url = file, destfile = file.path(dir, filename))
    return(invisible(TRUE))
  }

}



