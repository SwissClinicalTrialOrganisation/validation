## Lookup tables of answers to categorical questions in the package validation process
##
## IF THESE NEED TO CHANGE, ADD ADDITIONAL OPTIONS TO THE EXISTING ONES. DO NOT REPLACE!
## BACKWARDS COMPATIBILITY IS IMPORTANT!

author_map <- data.frame(
  author = c("well-known or known credentials", "credentials",
             "no clear credentials or group association",
             "Well-known or known credentials", "Credentials",
             "No clear credentials or group association"),
  author_score = c(0, 0.5, 1, 0, 0.5, 1)
)
maintainer_map <- data.frame(
  maintainer = c("Available", "Unavailable"),
  maintainer_score = c(0, 1)
)
purpose_map <- data.frame(
  purpose = c("Non-statistical", "Statistical; published",
              "Statistical; non-published"),
  purpose_score = c(0, 0.5, 1)
)
has_tests_map <- data.frame(
  has_tests = c("Yes, comprehensive", "Yes, but not comprehensive", "No"),
  has_tests_score = c(0, 0.5, 1)
)
has_vignettes_map <- bug_reporting_active_map <- on_cran_map <-
  source_code_documented_map <- data.frame(
    txt = c("Yes", "No"),
    score = c(0, 1)
  )

scto_rel_map <- data.frame(
  txt = c("SCTO Stats and Methodology platform",
          "Other SCTO platform",
          "No relationship")
)
