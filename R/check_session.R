#' Check a sessions loaded packages against the validated packages list
#' @param attached_only logical, should all loaded packages be shown (FALSE; default), or only those that are attached (TRUE)
#' @param approved_only logical, should only validated (approved) packages be shown (TRUE; default), or also those awaiting approval (FALSE)
#' @export
#' @importFrom sessioninfo package_info
#' @importFrom dplyr filter left_join
#' @rdname check_session
#' @examples
#' \dontrun{
#' check_session()
#' }
check_session <- function(attached_only = TRUE, approved_only = TRUE){
  session <- package_info()

  attached <- package <- loadedversion <- NULL

  loaded <- session |>
    # filter(attached) |>
    as.data.frame()

  if(attached_only)
    loaded <- loaded |> filter(attached)

  validated <- get_valid_pkgs(approved_only)


  loaded |> filter(package %in% validated$package)

  paks <- loaded |>
    left_join(validated, by = "package")

  ok_paks <- paks |>
    filter(loadedversion == version)

  diff_version <- paks |>
    filter(version != loadedversion,
           !package %in% ok_paks$package)

  unvalidated <- paks |>
    filter(is.na(version))


  out <- list(
    not_validated = unvalidated,
    different_version = diff_version,
    validated = ok_paks,
    n_packages = nrow(loaded)
  )

  class(out) <- c("sctovalidity", class(out))

  return(out)
}



#' @param x output from \code{check_session}
#' @param ... options passed to methods
#' @rdname check_session
#' @export
#' @importFrom glue glue
#' @importFrom crayon yellow red
print.sctovalidity <- function(x, ...){

  n_valid <- nrow(x$validated)
  n_diff <- nrow(x$different_version)
  n_invalid <- nrow(x$not_validated)

  cat(glue("Of {x$n_packages} loaded packages, ",
           "\n  {n_valid} {pluralize_has(n_valid)} been validated, ",
           "\n  {n_diff} {pluralize_is(n_diff)} a different version of a validated package, ",
           "\n  {n_invalid} {pluralize_has(n_invalid)} not been validated to date.\n\n"))

  if(nrow(x$different_version) > 0){
    cat(yellow("Consider updating the validation on the following packages:\n"),
        paste(x$different_version$package, sep = ", "), "\n")
  }
  if(nrow(x$not_validated) > 0){
    cat(red("The following packages require validation:\n"),
      paste(x$not_validated$package, sep = ", "), "\n")
  }

  cat("\nSee xxx.xxx.xxx for further details on package validation")

  return(NULL)

}


