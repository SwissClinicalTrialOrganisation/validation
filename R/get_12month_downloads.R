#' Get number of downloads in the last 12 months
#'
#' Note: this is only available for CRAN packages
#'
#' @param package package name
#' @param from start date
#' @param to end date
#' @return integer number of downloads
#' @importFrom cranlogs cran_downloads
#' @importFrom lubridate ymd
#'
#' @examples
#' get_12month_download("ggplot2")
#' get_12month_download("secuTrialR")
#'
get_12month_downloads <- function(package,
                                  from = Sys.Date() - 365,
                                  to = Sys.Date()){

  if(length(package) > 1) stop("Only one package at a time...")
  if(!is.character(package)) stop("Package must be a character string")

  # CRAN downloads
  downloads <- cranlogs::cran_downloads(package, from = from, to = to)
  n <- sum(downloads$count)

  if(n == 0){
    message("No downloads found for ", package,
            " in the last 12 months on CRAN.\nChecking Bioconductor...")

    # Bioconductor downloads
    bc <- read.table("https://bioconductor.org/packages/stats/bioc/bioc_pkg_stats.tab",
                     sep = "\t", header = TRUE)
    # bioconductor downloads are on year/month level
    # construct date
    bc <- bc[bc$Package == package,]
    if(nrow(bc) > 0) {
      bc <- bc[bc$Month != "all",]
      bc$date <- lubridate::ymd(paste0(bc$Year, "-", bc$Month, "-01"))
      bc <- bc[bc$date > from & bc$date < to,]
      n_bc <- sum(bc$Nb_of_downloads)
    } else {
      message("No downloads found for ", package,
              " in the last 12 months on Bioconductor either.")
      n_bc <- 0
    }

    n <- n + n_bc
  }

  return(n)

}



