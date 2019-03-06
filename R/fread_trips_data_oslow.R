fread_trips_data_oslow <- function(year, month) {

  min_year <- 2018
  max_year <- 2019

  stopifnot(year %in% c(min_year:max_year))

  base_url <- "http://data.urbansharing.com/oslovintersykkel.no/trips/v1"

  dl_url <- glue::glue("{base_url}/{year}/{sprintf('%0.2d', month)}.csv")
  bike_df <- data.table::fread(file = dl_url, encoding = "UTF-8")
  bike_df <- tibble::as_tibble(bike_df)

  return(bike_df)
}
