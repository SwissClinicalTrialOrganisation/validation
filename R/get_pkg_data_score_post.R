#' download an issue, calculate the score, post it back to GH
#'
#' This function is intended for use by github actions.
#'
#' @param issue_num the issue number
#' @export
get_pkg_data_score_post <- function(issue_num){

  if(length(issue_num) > 1) stop("Only one issue at a time")

  issue <- get_issue(issue_num)

  if(!is_package(list(issue))) stop("Issue is not a package validation")

  score <- calculate_pkg_score(list(issue))

  val <- validate_pkg_issue(score)

  if(val$score_ok){
    gh_message <- paste0("Package ", score$package, " has a score of ",
                         round(score$final_score, 3), " which makes it a **",
                         as.character(score$final_score_cat),
                         "** risk package.", "\n\n",
                         ":sparkles: Thank you for your contribution! :sparkles:")
  } else {
    gh_message <- val$message
  }

  post_comment(issue_num, gh_message)

}

# get_pkg_data_score_post(16)

