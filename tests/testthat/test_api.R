context("Test city bike APIs")
library(bysykkel)

testthat::skip_on_cran()

# Last updated: 2020-04-18

test_client_id <- "bysykkel.Rpackage-unit.test"

# Retrieve data from the API ----------------------------------------------

# Oslo
avail_oslo    <- get_api_data(test_client_id, data = "availability", city = "Oslo")
stations_oslo <- get_api_data(test_client_id, data = "stations",     city = "Oslo")
system_oslo   <- get_api_data(test_client_id, data = "system",       city = "Oslo")

# Bergen
avail_bergen    <- get_api_data(test_client_id, data = "availability", city = "Bergen")
stations_bergen <- get_api_data(test_client_id, data = "stations",     city = "Bergen")
system_bergen   <- get_api_data(test_client_id, data = "system",       city = "Bergen")

# Trondheim
avail_trondheim    <- get_api_data(test_client_id, data = "availability", city = "Trondheim")
stations_trondheim <- get_api_data(test_client_id, data = "stations",     city = "Trondheim")
system_trondheim   <- get_api_data(test_client_id, data = "system",       city = "Trondheim")

# Retrieve data from the API as a data frame ------------------------------

# Oslo
avail_df_oslo    <- get_api_data(test_client_id, data = "availability", city = "Oslo", return_df = TRUE)
stations_df_oslo <- get_api_data(test_client_id, data = "stations",     city = "Oslo", return_df = TRUE)
system_df_oslo   <- get_api_data(test_client_id, data = "system",       city = "Oslo", return_df = TRUE)

# Bergen
avail_df_bergen    <- get_api_data(test_client_id, data = "availability", city = "Bergen", return_df = TRUE)
stations_df_bergen <- get_api_data(test_client_id, data = "stations",     city = "Bergen", return_df = TRUE)
system_df_bergen   <- get_api_data(test_client_id, data = "system",       city = "Bergen", return_df = TRUE)

# Trondheim
avail_df_trondheim    <- get_api_data(test_client_id, data = "availability", city = "Trondheim", return_df = TRUE)
stations_df_trondheim <- get_api_data(test_client_id, data = "stations",     city = "Trondheim", return_df = TRUE)
system_df_trondheim   <- get_api_data(test_client_id, data = "system",       city = "Trondheim", return_df = TRUE)

# Test `get_api_data()` ---------------------------------------------------

 test_that("`get_api_data()` runs successfully and returns a list for `city = 'Oslo'`", {
   expect_equal(class(avail_oslo),    "list")
   expect_equal(class(stations_oslo), "list")
   expect_equal(class(system_oslo),   "list")
 })

 test_that("`get_api_data()` runs successfully and returns a list for `city = 'Bergen'`", {
   expect_equal(class(avail_bergen),    "list")
   expect_equal(class(stations_bergen), "list")
   expect_equal(class(system_bergen),   "list")
 })

 test_that("`get_api_data()` runs successfully and returns a list for `city = 'Trondheim'`", {
   expect_equal(class(avail_trondheim),    "list")
   expect_equal(class(stations_trondheim), "list")
   expect_equal(class(system_trondheim),   "list")
 })

# Test `get_api_data()` with `return_df = TRUE` ---------------------------

test_that("`get_api_data()` runs successfully and returns a tibble for `city = 'Oslo'`", {
  expect_equal(class(avail_df_oslo),    c("tbl_df", "tbl", "data.frame"))
  expect_equal(class(stations_df_oslo), c("tbl_df", "tbl", "data.frame"))
  expect_equal(class(system_df_oslo),   c("tbl_df", "tbl", "data.frame"))
})

test_that("`get_api_data()` runs successfully and returns a tibble for `city = 'Bergen'`", {
  expect_equal(class(avail_df_bergen),    c("tbl_df", "tbl", "data.frame"))
  expect_equal(class(stations_df_bergen), c("tbl_df", "tbl", "data.frame"))
  expect_equal(class(system_df_bergen),   c("tbl_df", "tbl", "data.frame"))
})

test_that("`get_api_data()` runs successfully and returns a tibble for `city = 'Trondheim'`", {
  expect_equal(class(avail_df_trondheim),    c("tbl_df", "tbl", "data.frame"))
  expect_equal(class(stations_df_trondheim), c("tbl_df", "tbl", "data.frame"))
  expect_equal(class(system_df_trondheim),   c("tbl_df", "tbl", "data.frame"))
})

# Test `get_api_data()` obvious errors ------------------------------------

test_that("get_api_data()` throws an error if `get_api_data()` arguments are incorrect", {
  expect_error(get_api_data(test_client_id, data = "avail", city = "Oslo"))
  expect_error(get_api_data(test_client_id, data = "stations", city = "oSlo"))
  expect_error(get_api_data(test_client_id, data = "stations", city = "Oslow"))
})

