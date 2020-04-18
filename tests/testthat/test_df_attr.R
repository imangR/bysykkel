context("Test city bike data frame attributes")
library(bysykkel)

testthat::skip_on_cran()

# Last updated at: 2020-04-17

# Preparations ------------------------------------------------------------

# Create date variables that will be used to test package functions
system_date  <- Sys.Date()
system_year  <- lubridate::year(system_date)
system_month <- lubridate::month(system_date)

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
  expect_equal(class(oslo_df),      c("tbl_df", "tbl", "data.frame"))
  expect_equal(class(bergen_df),    c("tbl_df", "tbl", "data.frame"))
  expect_equal(class(trondheim_df), c("tbl_df", "tbl", "data.frame"))
})

test_that("`fread_trips_data()` returns expected column names", {
  expect_equal(names(oslo_df),      expected_col_names)
  expect_equal(names(bergen_df),    expected_col_names)
  expect_equal(names(trondheim_df), expected_col_names)
})

test_that("`read_trips_data()` returns correct tibble class types", {
  expect_equal(class(oslo_df_alt),      c("tbl_df", "tbl", "data.frame"))
  expect_equal(class(bergen_df_alt),    c("tbl_df", "tbl", "data.frame"))
  expect_equal(class(trondheim_df_alt), c("tbl_df", "tbl", "data.frame"))
})

test_that("`fread_trips_data()` returns expected column names", {
  expect_equal(names(oslo_df_alt),      expected_col_names)
  expect_equal(names(bergen_df_alt),    expected_col_names)
  expect_equal(names(trondheim_df_alt), expected_col_names)
})

