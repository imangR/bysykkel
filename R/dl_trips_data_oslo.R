dl_trips_data_oslo <- function(year, month, filetype = "CSV") {

  filetype <- tolower(filetype)

  if (year >= 2019) {

    base_url <- "http://data.urbansharing.com/oslobysykkel.no/trips/v1"
    dl_url <- glue::glue("{base_url}/{year}/{sprintf('%0.2d', month)}.{filetype}")

    if (httr::http_error(dl_url)) {

      stop("The download URL is invalid.")

    }

    output_file <- glue::glue("trips_oslo_{year}_{sprintf('%0.2d', month)}.{filetype}")
    download.file(url = dl_url, destfile = output_file)

  } else if (year < 2019) {

    base_url <- "https://data-legacy.urbansharing.com/oslobysykkel.no"
    dl_url <- glue::glue("{base_url}/{year}/{sprintf('%0.2d', month)}.{filetype}.zip")

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
