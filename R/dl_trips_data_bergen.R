dl_trips_data_bergen <- function(year, month, filetype = "CSV") {

  filetype <- tolower(filetype)
  base_url <- "http://data.urbansharing.com/bergenbysykkel.no/trips/v1"
  dl_url <- glue::glue("{base_url}/{year}/{sprintf('%0.2d', month)}.{filetype}")

  if (httr::http_error(dl_url)) {

    stop("The download URL is invalid.")

  }

  output_file <- glue::glue("trips_bergen_{year}_{sprintf('%0.2d', month)}.{filetype}")
  download.file(url = dl_url, destfile = output_file)

}
