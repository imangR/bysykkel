read_trips_data_oslow <- function(year, month) {

  base_url <- "http://data.urbansharing.com/oslovintersykkel.no/trips/v1"
  dl_url <- glue::glue("{base_url}/{year}/{sprintf('%0.2d', month)}.csv")

  if (httr::http_error(dl_url)) {

    stop("The download URL is invalid.")

  }

  bike_df <- read.csv(file = dl_url,
                      header = TRUE,
                      stringsAsFactors = FALSE,
                      encoding = "UTF-8")

  bike_df <- tibble::as_tibble(bike_df)

  return(bike_df)
}
