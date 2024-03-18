#' download test files from the validation_tests repo
#' @param pkg package name as a string
#' @param repo github repository to download from
#' @param dir directory to download to
#' @keywords internal
get_tests <- function(pkg, dir = tempdir(), repo = sctotests()){
  files <- try(gh::gh(repo = repo,
                      endpoint = paste0("GET /repos/:repo/contents/tests/", pkg),
                      .params = list("X-GitHub-Api-Version" = "2022-11-28")),
               silent = TRUE)
  if(all(class(files) == "try-error")){
    print(paste("No tests found for package ", pkg))
    return(FALSE)
  } else {
    files <- lapply(files, function(x) x$download_url)
    # extract filenames from the URLs
    filenames <- lapply(files, function(x) strsplit(x, "/")[[1]][length(strsplit(x, "/")[[1]])])
    mapply(function(file, filename)
      download.file(url = file, destfile = file.path(dir, filename)),
      files, filenames)
    return(invisible(TRUE))
  }
}
