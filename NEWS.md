# validation 0.3.6

* improved support for datasets stored in the validation_tests repository via `get_test_data`

# validation 0.3.5

* where installation location is unknown, the package source as reported by sessioninfo will be returned (primarily to assist in debugging).
* export additional functions for working with issues and comments
* additional method of collecting the user (gh package insufficient)

# validation 0.3.4

* Addition of tooling to run the validation tests in a CI environment (GHA).
  - `post_issue` function to post issues to the repository.
  - `test_to_text` function to convert the test results to text strings.
* Addition of the news file to keep track of changes. 
