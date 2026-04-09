# Tests 🧪

This folder is for storing tests, most commonly unit tests. Tests are important for ensuring that changes to code do no break existing functionality and can be run in an automated manner to check this. Tests should be stored in the "tests" directory.

## Python

For Python we use [Pytest](https://docs.pytest.org) as the testing framework. 

Test filenames should be preceded with "test_XXX.py" so that pytest can identify them. Tests can be run as part of the pre-commit GitHub Actions on pull requests.

An example command for running a test manually and gathering coverage is:

```bash
pytest --cov
```

## R 

For R we use [testthat](https://testthat.r-lib.org/) as the testing framework.

Test filenames should be preceded with "test-XXX.R" so that `testthat` can identify them. Tests can be run as part of the pre-commit GitHub Actions on pull requests.

To run tests locally, use the following command:

```bash
Rscript -e 'testthat::test_dir("tests/testthat")'
```

RStudio also has a built-in test runner that can be used to run tests.
