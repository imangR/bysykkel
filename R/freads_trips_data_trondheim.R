fread_trips_data_trondheim <- function(year, month) {

  base_url <- "http://data.urbansharing.com/trondheimbysykkel.no/trips/v1"
  dl_url <- glue::glue("{base_url}/{year}/{sprintf('%0.2d', month)}.csv")

  if (httr::http_error(dl_url)) stop("The download URL is invalid.")

  bike_df <- data.table::fread(input = dl_url, encoding = "UTF-8")
  bike_df <- tibble::as_tibble(bike_df)

}

