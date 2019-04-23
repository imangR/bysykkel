fread_trips_data_oslo <- function(year, month) {

  if (year >= 2019) {

    base_url <- "http://data.urbansharing.com/oslobysykkel.no/trips/v1"
    dl_url <- glue::glue("{base_url}/{year}/{sprintf('%0.2d', month)}.csv")

    if (httr::http_error(dl_url)) stop("The download URL is invalid.")

    bike_df <- data.table::fread(input = dl_url, encoding = "UTF-8")
    bike_df <- tibble::as_tibble(bike_df)

  } else if (year < 2019) {

    base_url <- "https://data-legacy.urbansharing.com/oslobysykkel.no"
    dl_url <- glue::glue("{base_url}/{year}/{sprintf('%0.2d', month)}.csv.zip")

    if (httr::http_error(dl_url)) stop("The download URL is invalid.")

    # The code below was implemented as a solution to the problem of
    # downloading a zip-file that contains bike trip data, create a
    # connection to the zip-file, and read the underlying CSV-file
    # in the zip-file to R
    temp <- tempfile()
    download.file(dl_url, temp)
    filename <- bysykkel_control_legacy_oslo(year, month)
    bike_df <- read.csv(unz(temp, filename),
                        header = TRUE,
                        stringsAsFactors = FALSE,
                        check.names = FALSE,
                        encoding = "UTF-8")
    unlink(temp)
    bike_df <- tibble::as_tibble(bike_df)

  }

}
