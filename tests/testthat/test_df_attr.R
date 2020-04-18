context("Test city bike data frame attributes")
library(bysykkel)

testthat::skip_on_cran()

# Last updated at: 2020-04-17

# Preparations ------------------------------------------------------------

# Create date variables that will be used to test package functions
system_date  <- Sys.Date()
system_year  <- lubridate::year(system.date)
system_month <- lubridate::month(system.date)

# Create objects that will be used to test on downloaded city bike data
oslo_df      <- fread_trips_data(year = system_year, month = system_month, city = "Oslo")
bergen_df    <- fread_trips_data(year = system_year, month = system_month, city = "Bergen")
trondheim_df <- fread_trips_data(year = system_year, month = system_month, city = "Trondheim")

oslo_df_alt      <- read_trips_data(year = system_year, month = 03, city = "Oslo")
bergen_df_alt    <- read_trips_data(year = system_year, month = 03, city = "Bergen")
trondheim_df_alt <- read_trips_data(year = system_year, month = 03, city = "Trondheim")

# Create object that points to vector that contains the expected column names
# in the city bike data frames
expected_col_names <-
  c("started_at", "ended_at", "duration", "start_station_id",
    "start_station_name", "start_station_description", "start_station_latitude",
    "start_station_longitude", "end_station_id", "end_station_name",
    "end_station_description", "end_station_latitude", "end_station_longitude")

# Tests -------------------------------------------------------------------

test_that("`fread_trips_data()` returns correct tibble class types", {
  expect_equal(class(test_oslo),      c("tbl_df", "tbl", "data.frame"))
  expect_equal(class(test_bergen),    c("tbl_df", "tbl", "data.frame"))
  expect_equal(class(test_trondheim), c("tbl_df", "tbl", "data.frame"))
})

test_that("`fread_trips_data()` returns expected column names", {
  expect_equal(names(test_oslo),      expected_col_names)
  expect_equal(names(test_bergen),    expected_col_names)
  expect_equal(names(test_trondheim), expected_col_names)
})

test_that("`read_trips_data()` returns correct tibble class types", {
  expect_equal(class(test_oslo_alt),      c("tbl_df", "tbl", "data.frame"))
  expect_equal(class(test_bergen_alt),    c("tbl_df", "tbl", "data.frame"))
  expect_equal(class(test_trondheim_alt), c("tbl_df", "tbl", "data.frame"))
})

test_that("`fread_trips_data()` returns expected column names", {
  expect_equal(names(test_oslo_alt),      expected_col_names)
  expect_equal(names(test_bergen_alt),    expected_col_names)
  expect_equal(names(test_trondheim_alt), expected_col_names)
})

