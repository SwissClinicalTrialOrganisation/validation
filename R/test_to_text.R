#' Convert a test result object to a text string for posting to GitHub
#'
#' @param x test result object
#' @return a list of character strings
#' @export
#' @importFrom utils capture.output
#' @examples
#' # texts <- test_to_text(x)
#' # issue <- post_issue(texts$issue_body, texts$issue_title)
#' # map(texts$issue_tags, ~ add_label(issue$number, .x))


test_to_text <- function(x){



  issue_title <- paste0("[Package test]: ", x$pkg, " version ", x$pkg_version, " \n\n")



  issue_body <- paste0(
    "### Name\n\n",
    x$who, "\n\n",
    "### Name of the package you have tested\n\n",
    x$pkg, "\n\n",
    "### What version of the package have you tested?\n\n",
    x$pkg_version,
    "\n\n",
    "### Where was the package installed from?\n\n",
    x$pkg_source,
    "\n\n",
    "### If the package was installed from GitHub or similar (including r-universe), please provide a commit reference\n\n",
    x$pkg_sha,
    "\n\n",
    "### When was this package tested?\n\n",
    format(Sys.Date(), format = "%Y-%m-%d"),
    "\n\n",
    "### What was tested?\n\n",
    paste0(x$what, collapse = "\n"), "\n\n",
    "### Test results\n\n",
    ifelse(x$result, "PASS", "FAIL"), "\n\n",
    "### Test output\n\n")

  evidence_tab <- knitr::kable(x$evidence[,
                                          c("file", "context", "test", "nb", "passed",
                                            "skipped", "error", "warning")],
                               format = "pipe", row.names = FALSE)

  issue_body <- paste0(issue_body, paste0(evidence_tab, collapse = "\n"))

  if(!x$result){
    issue_body <- paste0(issue_body,
                         "\n\nTHE FOLLOWING ERRORS AND/OR WARNINGS WERE GENERATED:\n",
                         x$evidence$result[x$evidence$failed > 0 | x$evidence$warning > 0] |>
                           print() |>
                           capture.output() |>
                           paste(collapse = "\n"), "\n\n")
  }
  if(x$warnings & x$result){
    issue_body <- paste0(issue_body,
                         "\n\nTHE FOLLOWING WARNINGS WERE GENERATED:\n",
                         x$evidence$result[x$evidence$warning > 0] |>
                           print() |>
                           capture.output() |>
                           paste(collapse = "\n"), "\n\n")

  }

  issue_body <- paste0(
    issue_body,
    "\n\n",
    "### Session info\n\n",
    x$session |> capture.output() |> paste(collapse = "\n"),
    "\n\n",
    "### Where is the test code located for these tests?\n\n",
    x$repo,
    "\n\n",
    "### Where the test code is located in a git repository, add the git commit SHA\n\n",
    x$repo_sha
  )

  tags <- c("test", ":alarm_clock: triage :alarm_clock:")


  return(
    list(
      issue_title = issue_title,
      issue_body = issue_body,
      issue_tags = tags
    )
  )

}

# texts <- test_to_text(x)
# issue <- post_issue(texts$issue_body, texts$issue_title)
# add_label(issue$number, texts$issue_tags[1])
# add_label(issue$number, texts$issue_tags[2])
