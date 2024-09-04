#' Derive the location of a package's source code
#'
#' This function tries to determine where a package was installed from, e.g. CRAN,
#' GitHub, r-universe, etc. If the package comes from a git repository, it also
#' attempts to extract the repository URL and commit hash.
#'
#' If the package was installed from a r-universe, the function will return the
#' git repository URL and commit hash of the package, rather than the r-universe
#' URL. E.g. this package is installed from the CTU-Bern r-universe, but the function
#' returns the URL of the GitHub repository
#' (\code{https://github.com/SwissClinicalTrialOrganisation/validation}) and the
#' commit hash.
#'
#' @param pkg package to check the source of
#' @param ... parameters passed to other methods
#'
#' @importFrom sessioninfo package_info
#' @importFrom stringr word str_remove
#' @importFrom jsonlite read_json
get_pkg_source <- function(pkg, ...){

  package <- NULL

  base <- pkg %in% c("base", "compiler", "datasets", "graphics", "grDevices",
                     "grid", "methods", "parallel", "splines", "stats", "stats4",
                     "tcltk", "tools", "translations", "utils")

  pkginfo <- package_info(pkg, include_base = base, ...) |>
    filter(package == pkg)

  pkg_source <- pkginfo$source
  pkg_installed <- pkginfo$date

  universe <- grepl("r-universe", pkg_source)
  gh <- grepl("^Github", pkg_source)
  git2r <- grepl("^git2r", pkg_source)
  cran <- grepl("^CRAN", pkg_source)

  if(universe){
    # installed from r-universe
    pkg_source <- word(pkg_source, 1)
    path <- paste(pkg_source, "api/packages", pkg, sep = "/")
    universe_info <- jsonlite::read_json(path)
    remote_repo <- universe_info$RemoteUrl
    remote_sha <- universe_info$RemoteSha
  }
  if(gh){
    # installed via remotes?
    tmp <- str_remove(pkg_source, "^Github \\(") |>
      str_remove("\\)$") |>
      strsplit("@") |>
      unlist()
    remote_repo <- paste("https://www.github.com", tmp[1], sep = "/")
    remote_sha <- tmp[2]
  }
  if(git2r){
    # installed by groundhog?
    # stored as e.g. "git2r (C:\path\to\library/R_groundhog/groundhog_library//git_clones/github/CTU-Bern_svn@f938b7a530e04c53b51d7c30c70885c8a26ec401)"
    split <- strsplit(pkg_source, "/") |>
      unlist()
    repo <- split[length(split)]
    server <- split[length(split) - 1]
    if(server == "github"){
      server <- "https://www.github.com"
    } else {
      server <- paste("Server address unclear - please complete it:", server)
    }
    repo_info <- strsplit(repo, "@") |> unlist()
    # reconstruct repo name
    tmp <- strsplit(repo_info[1], "_") |> unlist()
    if(length(tmp) == 2){
      repo <- paste(tmp[1], tmp[2], sep = "/")
    } else {
      repo <- paste(" Check repo name: ", repo_info[1], sep = "")
    }
    remote_repo <- paste(server, repo, sep = "/")
    remote_sha <- repo_info[2] |> str_remove("\\)$")
  }
  if(cran){
    remote_repo <- pkg_source
    remote_sha <- "NA"
  }
  if(!any(universe, gh, git2r, cran)){
    remote_repo <- pkg_source
    remote_sha <- "NA"
  }

  return(
    list(
      pkg_source = remote_repo,
      sha = remote_sha
    )
  )

}



