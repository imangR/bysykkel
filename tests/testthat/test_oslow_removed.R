context("Test that functions gracefully fail when retrieving data from \"OsloW\", which has been removed.")
library(testthat)

testthat::skip_on_cran()

# Last updated: 2020-04-18


# Test "OsloW" as city argument in all functions --------------------------

test_that("fread_trips_data() produces an error when city = 'OsloW'", {
  expect_error(fread_trips_data(year = 2019, month = 01, city = "OsloW"))
  }
)

test_that("read_trips_data() produces an error when city = 'OsloW'", {
  expect_error(read_trips_data(year = 2019, month = 01, city = "OsloW"))
  }
)

test_that("dl_trips_data() produces an error when city = 'OsloW'", {
  expect_error(dl_trips_data(year = 2019, month = 01, city = "OsloW"))
  }
)
