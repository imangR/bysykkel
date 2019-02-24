get_trips_data_oslo <- function(year, month) {

  min_year <- 2016
  max_year <- 2018

  stopifnot(year  %in% c(min_year:max_year),
            month %in% c(1:12),
            is.numeric(year),
            is.numeric(month))

  days31 <- c(1, 3, 5, 7, 8, 10, 12)
  days30 <- c(4, 6, 9, 11)
  days28 <- 2

  base_url <- "http://oslo-city-bike-web.s3.amazonaws.com/exports/"

  if (month %in% days31) {

    dl_url <- glue::glue("{base_url}trips-{year}.{month}.1-{year}.{month}.31.csv.zip")
    download.file(url = dl_url, destfile = glue::glue("trips_oslo_{year}_{sprintf('%0.2d', month)}.zip"))

  } else if (month %in% days30) {

    dl_url <- glue::glue("{base_url}trips-{year}.{month}.1-{year}.{month}.30.csv.zip")
    download.file(url = dl_url, destfile = glue::glue("trips_oslo_{year}_{sprintf('%0.2d', month)}.zip"))

  } else if (month %in% days28) {

    dl_url <- glue::glue("{base_url}trips-{year}.{month}.1-{year}.{month}.28.csv.zip")
    download.file(url = dl_url, destfile = glue::glue("trips_oslo_{year}_{sprintf('%0.2d', month)}.zip"))

  } else {

    error <- glue::glue("Please select a valid month number (1, 2, ..., 12) or a valid year (2016, 2017, 2018).")
    print(error)

  }

}
