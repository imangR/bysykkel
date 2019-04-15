dl_trips_data_oslo <- function(year, month) {

  if (year >= 2019) {

    base_url <- "http://data.urbansharing.com/oslobysykkel.no/trips/v1"
    dl_url <- glue::glue("{base_url}/{year}/{sprintf('%0.2d', month)}.csv")

    if (httr::http_error(dl_url)) {

      stop("The download URL is invalid.")

    }

    download.file(url = dl_url)

  } else if (year < 2019) {

    base_url <- "https://data-legacy.urbansharing.com/oslobysykkel.no"
    dl_url <- glue::glue("{base_url}/{year}/{sprintf('%0.2d', month)}.csv.zip")

    if (httr::http_error(dl_url)) {

      stop("The download URL is invalid.")

    }

    temp <- tempfile()
    download.file(url = dl_url, temp)
    filename <- bysykkel_control_legacy_oslo(year, month)
    unzip(temp, exdir = getwd(), overwrite = TRUE)
    unlink(temp)

  }

}
