library(testthat)
library(data.table)

# Source relative to the project root when run via devtools::test() or testthat::test_dir()
source("R/read_habits.R")

# ---------------------------------------------------------------------------
# Helper: build a minimal in-memory long-format habits data.table
# ---------------------------------------------------------------------------
make_habits_dt <- function() {
  data.table(
    habit = c("Exercise", "Exercise", "Exercise", "Read", "Read", "Read"),
    date  = as.Date(c(
      "2024-01-01", "2024-01-02", "2024-01-03",
      "2024-01-01", "2024-01-02", "2024-01-03"
    )),
    value = c(2L, 0L, 2L, 2L, 2L, 1L)
  )
}

# ---------------------------------------------------------------------------
# read_habits_wide
# ---------------------------------------------------------------------------
test_that("read_habits_wide returns expected long-format structure", {
  tmp <- tempfile(fileext = ".csv")
  on.exit(unlink(tmp))

  # Write a minimal wide CSV
  wide <- data.table(
    Name       = c("Exercise", "Read"),
    `2024-01-01` = c(2L, 0L),
    `2024-01-02` = c(0L, 2L)
  )
  fwrite(wide, tmp)

  result <- read_habits_wide(tmp)

  expect_s3_class(result, "data.table")
  expect_true(all(c("habit", "date", "value") %in% names(result)))
  expect_equal(nrow(result), 4L)
  expect_s3_class(result$date, "Date")
  expect_type(result$value, "integer")
})

# ---------------------------------------------------------------------------
# read_habits_long
# ---------------------------------------------------------------------------
test_that("read_habits_long returns expected structure", {
  tmp <- tempfile(fileext = ".csv")
  on.exit(unlink(tmp))

  long_csv <- data.table(
    Date  = c("2024-01-01", "2024-01-02", "2024-01-03"),
    Value = c(2L, 0L, 2L)
  )
  fwrite(long_csv, tmp)

  result <- read_habits_long(tmp, habit_name = "MyHabit")

  expect_s3_class(result, "data.table")
  expect_true(all(c("habit", "date", "value") %in% names(result)))
  expect_equal(nrow(result), 3L)
  expect_true(all(result$habit == "MyHabit"))
  expect_s3_class(result$date, "Date")
})

test_that("read_habits_long errors if required columns are missing", {
  tmp <- tempfile(fileext = ".csv")
  on.exit(unlink(tmp))

  fwrite(data.table(foo = 1:3, bar = 4:6), tmp)

  expect_error(read_habits_long(tmp), "Expected columns")
})

# ---------------------------------------------------------------------------
# add_status_label
# ---------------------------------------------------------------------------
test_that("add_status_label adds correct status labels", {
  dt <- make_habits_dt()
  result <- add_status_label(dt)

  expect_true("status" %in% names(result))
  expect_equal(result[value == 2L, unique(status)], "completed")
  expect_equal(result[value == 0L, unique(status)], "missed")
  expect_equal(result[value == 1L, unique(status)], "skipped")
})
