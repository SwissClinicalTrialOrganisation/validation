#' Hook for collecting user-defined chunk risk level in markdown documents
#'
#' This is a function that can be used with Rmarkdown or quarto to collect the
#' risk associated with a particular chunk. The risk level can then be tabulated
#' towards the end of the document to give an overview of the risk associated
#' with the product.
#'
#' @param options chunk options
#' @param before whether the hook is called before or after the chunk (only
#' before does anything)
#'
#' @export
#'
#' @examples
#' # in e.g. setup chunk
#' knitr::knit_hooks$set(risk = validation::risk_hook)
#' RISKENV <- new.env()
#'
#' # as a chunk option
#' #```{r highriskchunk, echo=FALSE, risk = "high"}
#' #```{r mediumriskchunk, echo=FALSE, risk = "medium"}
#' #```{r lowriskchunk, echo=FALSE, risk = "low"}
#'
#' # towards the end of the script, tabulate RISKENV$chunk_risk for an overview
risk_hook <- function(options, before){
  chunk_risk <- options$risk
  if(!chunk_risk %in% c("low", "medium", "high"))
    stop("unknown risk level")
  if(!exists("chunk_risk", envir = RISKENV)){
    RISKENV$chunk_risk <- NULL
  }
  if(before) RISKENV$chunk_risk <- c(RISKENV$chunk_risk, chunk_risk)
  return(invisible(NULL))
}
