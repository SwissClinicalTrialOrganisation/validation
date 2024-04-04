#' Convert test evidence table back to a data frame
#'
#' In order to print nicely in GitHub, tables are formatted using markdown syntax.
#'
#' This function can read that syntax and convert it back to a normal data frame.
#'
#' @param tab a string containing the markdown table
#'
#' @return a data frame
#' @importFrom utils read.delim
#' @export
#'
#' @examples
#' tab <- c("|file      |context |test      | nb| passed|skipped |error | warning|",
#'          "|:---------|:-------|:---------|--:|------:|:-------|:-----|-------:|",
#'          "|test-lm.R |lm      |message 1 |  8|      4|FALSE   |FALSE |       4|",
#'          "|test-lm.R |lm      |message 2 |  3|      3|FALSE   |FALSE |       0|")
#' parse_evidence_tab(tab)
parse_evidence_tab <- function(tab){
  con <- textConnection(tab)
  lines <- readLines(con)
  close(con)
  lines <- lines[!grepl('^[\\:\\s\\+\\-\\=\\_\\|]*$', lines, perl = TRUE)]
  lines <- gsub('(^\\s*?\\|)|(\\|\\s*?$)', '', lines)
  read.delim(text = paste(lines, collapse = '\n'),
             sep = "|",
             stringsAsFactors = FALSE,
             strip.white = TRUE)
}

