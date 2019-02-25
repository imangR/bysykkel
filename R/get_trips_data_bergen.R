get_trips_data_bergen <- function(year, month) {

  min_year <- 2018
  max_year <- 2019

  stopifnot(year  %in% c(min_year:max_year),
            month %in% c(1:12),
            is.numeric(year),
            is.numeric(month))

  base_url <- "http://data.urbansharing.com/bergenbysykkel.no/trips/v1"

  dl_url <- glue::glue("{base_url}/{year}/{sprintf('%0.2d', month)}.csv")
  download.file(url = dl_url, destfile = glue::glue("trips_bergen_{year}_{sprintf('%0.2d', month)}.csv"))

}
