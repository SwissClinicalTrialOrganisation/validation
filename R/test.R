#' Run all tests for a given package
#'
#' This function runs all predefined tests for a given package.
#'
#' The print method supports the creation of a new issue in the package's
#' repository by presenting the information in a format that can be copied and
#' pasted in the issue template.
#'
#' @param pkg package name as a string
#' @param download whether to download a fresh set of tests
#' @param cleanup whether to delete testing folder
#' @param dir directory to download tests to. This should have \code{pkg} at the
#'   end. If not present, it will be created.
#' @param repo storing the tests
#' @param testthat_colours include coloured testthat output (the colours are
#'   implemented as particular characters in the output, which make it harder to
#'   read in some circumstances)
#'
#' @return Object of class \code{validate_result}
#' @export
#' @importFrom utils sessionInfo
#'
#' @examples
#' if(FALSE) test("stats")
test <- function(pkg,
                 download = TRUE,
                 cleanup = FALSE,
                 dir = getwd(),
                 repo = sctotests(),
                 testthat_colours = TRUE){

  package <- NULL

  if(!testthat_colours){
    options(crayon.enabled = FALSE)
    on.exit(options(crayon.enabled = TRUE))
  }

  if(!grepl(paste0(pkg, "$"), dir)) dir <- file.path(dir, pkg)
  if(!dir.exists(dir)) dir.create(dir, recursive = TRUE)

  if(download){
    get_tests(pkg, dir = dir, repo = repo)
    sha <- get_repo_sha(repo)
  }

  testres <- testthat::test_dir(
    dir,
    stop_on_failure = FALSE
  ) |> as.data.frame()

  pkg_info <- get_pkg_source(pkg)

  pkgdat <- sessioninfo::package_info(pkg, include_base = TRUE) |>
    subset(package == pkg)
  pkgversion <- pkgdat$loadedversion

  user <- gh::gh_whoami()$login
  now <- Sys.time()
  info <- readLines(file.path(dir, "info.txt"))

  overall_result <- all(testres$failed == 0)
  warnings <- any(testres$warning > 0)

  sysinfo <- sessionInfo()
  # OS <- glue::glue("{sysinfo[['sysname']]} {sysinfo[['release']]} ({sysinfo[['version']]})")
  Rvers <- R.Version()$version.string

  out <- list(who = user,
              pkg = pkg,
              pkg_version = pkgversion,
              pkg_source = pkg_info$pkg_source,
              pkg_sha = pkg_info$sha,
              when = now,
              what = info,
              # details = pkg_reference(pkg),
              result = overall_result,
              warnings = warnings,
              evidence = testres,
              session = sysinfo,
              repo = ifelse(download, repo, "please enter manually"),
              repo_sha = ifelse(download, sha, "please enter manually, if relevant")
              )

  class(out) <- c("validate_result", class(out))
  return(out)

  if(cleanup) unlink(dir, recursive = TRUE)
}

#' @export
#' @param ... additional arguments (not used)
#' @importFrom crayon blue bold
print.validate_result <- function(x, ...){
  cat(blue$bold("## Copy and paste the following output into the indicated sections of a new issue\n\n"))
  cat(blue$bold("ISSUE NAME: \n"))
  cat(paste0("[Package test]: ", x$pkg, " version ", x$pkg_version, " \n\n"))

  cat(blue$bold("### Name \n"))
  cat(x$who, "\n\n")

  cat(blue$bold("### Name of the package you have validated \n"))
  cat(x$pkg, "\n\n")

  cat(blue$bold("### What version of the package have you validated? \n"))
  cat(x$pkg_version, "\n\n" )

  cat(blue$bold("### Where was the package from? \n"))
  cat(x$pkg_source, "\n\n" )

  cat(blue$bold("### Package repository version reference\n"))
  cat(x$pkg_sha, "\n\n" )

  cat(blue$bold("### When was this package tested? \n"))
  cat(format(Sys.Date(), format = "%Y-%m-%d"), "\n\n")

  cat(blue$bold("### What was tested? \n"))
  cat(paste(x$what, collape = "\n"), "\n\n")

  cat(blue$bold("### Test results \n"))
  cat(ifelse(x$result, "PASS", "FAIL"), "\n\n")


  cat(blue$bold("### Test output:\n"))
  print(knitr::kable(x$evidence[,
                                c("file", "context", "test", "nb", "passed",
                                  "skipped", "error", "warning")],
                     format = "pipe", row.names = FALSE))

  if(!x$result){
    cat("\n\nTHE FOLLOWING ERRORS AND/OR WARNINGS WERE GENERATED:\n")
    print(x$evidence$result[x$evidence$failed > 0 | x$evidence$warning > 0])
  }
  if(x$warnings & x$result){
    cat("\n\nTHE FOLLOWING WARNINGS WERE GENERATED:\n")
    print(x$evidence$result[x$evidence$warning > 0])
  }

  cat(blue$bold("\n### SessionInfo:\n"))
  print(x$session)
  # cat(x$session$R)
  # cat(x$session$OS)
  # cat(x$session$loaded)
  # print(knitr::kable(x$session$loaded, format = "pipe", row.names = FALSE))

  cat("\n\n")
  cat(blue$bold("### Where is the test code located for these tests?\n"))
  cat(x$repo)

  cat("\n\n")
  cat(blue$bold("### Where the test code is located in a git repository, add the git commit SHA\n"))
  cat(x$repo_sha)

}


#
# ses <- sessionInfo()
# z <- list(session = ses)
# print(z$session)



