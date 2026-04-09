# read_habits.R
# Utility functions for reading and reshaping Loop Habit Tracker CSV exports
# using the data.table package.
#
# Loop Habit Tracker (https://loophabits.org/) can export habit data as CSV.
# Two common formats are supported here:
#
#   1. Wide ("Checkmarks") format
#      - One row per habit, one column per date.
#      - The first column is the habit name.
#      - Cell values: 2 = done, 1 = skipped, 0 = missed.
#
#   2. Long ("Single habit") format
#      - Two columns: "Date" and "Value".
#      - Exported when a single habit is shared from the app.

library(data.table)

#' Read a Loop Habit Tracker CSV file in wide (Checkmarks) format.
#'
#' @param path Character. Path to the CSV file.
#' @param na_strings Character vector. Values to treat as NA. Default "".
#'
#' @return A data.table with columns:
#'   habit  (character)  – habit name
#'   date   (Date)       – observation date
#'   value  (integer)    – 0 = missed, 1 = skipped, 2 = completed
read_habits_wide <- function(path, na_strings = "") {
  raw <- fread(path, na.strings = na_strings)

  # The first column holds habit names; rename it for clarity
  setnames(raw, 1L, "habit")

  # Melt from wide to long
  date_cols <- setdiff(names(raw), "habit")
  long <- melt(
    raw,
    id.vars      = "habit",
    measure.vars = date_cols,
    variable.name = "date",
    value.name    = "value"
  )

  # Parse date strings to Date class
  long[, date := as.Date(as.character(date))]

  # Ensure value is integer
  long[, value := as.integer(value)]

  setorder(long, habit, date)
  long[]
}

#' Read a Loop Habit Tracker CSV file in long (single-habit) format.
#'
#' @param path      Character. Path to the CSV file.
#' @param habit_name Character. Name to assign to the habit column.
#'   Defaults to the file base-name (without extension).
#' @param na_strings Character vector. Values to treat as NA. Default "".
#'
#' @return A data.table with columns:
#'   habit  (character)  – habit name
#'   date   (Date)       – observation date
#'   value  (integer)    – 0 = missed, 1 = skipped, 2 = completed
read_habits_long <- function(path,
                             habit_name = tools::file_path_sans_ext(basename(path)),
                             na_strings = "") {
  dt <- fread(path, na.strings = na_strings)

  # Normalise column names to lower-case
  setnames(dt, tolower(names(dt)))

  if (!all(c("date", "value") %in% names(dt))) {
    stop(
      "Expected columns 'date' and 'value' in ", path,
      ". Found: ", paste(names(dt), collapse = ", ")
    )
  }

  dt[, date  := as.Date(as.character(date))]
  dt[, value := as.integer(value)]
  dt[, habit := habit_name]

  setcolorder(dt, c("habit", "date", "value"))
  setorder(dt, habit, date)
  dt[]
}

#' Add a human-readable completion label to a habits data.table.
#'
#' @param dt A data.table with an integer column \code{value}.
#'
#' @return The same data.table with an additional character column \code{status}.
add_status_label <- function(dt) {
  dt[, status := fcase(
    value == 2L, "completed",
    value == 1L, "skipped",
    value == 0L, "missed",
    default      = NA_character_
  )]
  dt[]
}
