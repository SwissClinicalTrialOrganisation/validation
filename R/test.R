


test <- function(pkg){

  testres <- testthat::test_dir(
    system.file(glue::glue("tests/{pkg}"), package = "validation"),
    stop_on_failure = FALSE
  ) |> as.data.frame()

  pkgversion <- sessioninfo::package_info(pkg) |>
    subset(package == pkg) |>
    {\(x) x[1, "loadedversion"]}()

  user <- if(require(gh)){
    gh::gh_whoami()$login
  } else {
    sessionInfo() |> str()
  }
  now <- Sys.time()
  info <- readLines(system.file(glue::glue("tests/{pkg}/info.txt"), package = "validation"))

  overall_result <- all(testres == 1)

  sysinfo <- Sys.info()
  OS <- glue::glue("{sysinfo[['sysname']]} {sysinfo[['release']]} ({sysinfo[['version']]})")
  Rvers <- R.Version()$version.string

  out <- list(who = user,
              pkg = pkg,
              when = now,
              what = info,
              # details = pkg_reference(pkg),
              result = overall_result,
              evidence = testres,
              session = list(
                R = Rvers,
                OS = OS,
                loaded = sessioninfo::package_info()
                )
              )

  class(out) <- c("validate_result", class(out))
  return(out)
}

print.validate_result <- function(x){
  cat("## Function validation\n")

  cat("### Package: \n")
  cat("<!-- TAGSTART:package -->\n")
  cat(x$pkg)
  cat("\n<!-- TAGEND:package -->\n\n")

  cat("### Function tested:\n")
  cat("<!-- TAGSTART:function -->\n")
  cat(x$what)
  cat("\n<!-- TAGEND:function -->\n\n")

  cat("### Test results:\nDid the function pass or fail?\n")
  cat("<!-- TAGSTART:result -->\n_")
  cat(ifelse(x$result, "Pass", "Fail"))
  cat("_\n<!-- TAGEND:result -->\n\n")

  cat("### Test output:\n")
  cat("<!-- TAGSTART:r_output -->\n")
  print(knitr::kable(x$evidence[, c("file", "context", "test", "nb", "passed", "skipped", "error", "warning")], format = "pipe", row.names = FALSE))
  cat("<!-- TAGEND:r_output -->\n")


  cat("### SessionInfo:\n")
  cat("<!-- TAGSTART:r_version -->\n")
  cat(x$session$R)
  cat("\n<!-- TAGEND:r_version -->\n")
  cat("<!-- TAGSTART:r_os -->\n")
  cat(x$session$OS)
  cat("\n<!-- TAGEND:r_os -->\n")
  cat("<!-- TAGSTART:r_loaded -->\n")
  print(knitr::kable(x$session$loaded, format = "pipe", row.names = FALSE))
  cat("\n<!-- TAGEND:r_loaded -->\n")

}
