read_trips_data_oslo <- function(year, month) {

  if (year >= 2019) {

    base_url <- "http://data.urbansharing.com/oslobysykkel.no/trips/v1"
    dl_url <- glue::glue("{base_url}/{year}/{sprintf('%0.2d', month)}.csv")

    if (httr::http_error(dl_url)) {

      stop("The download URL is invalid.")

    }

    bike_df <- read.csv(dl_url,
                        header = TRUE,
                        stringsAsFactors = FALSE,
                        encoding = "UTF-8")

    bike_df <- tibble::as_tibble(bike_df)

    return(bike_df)

  } else if (year < 2019) {

    base_url <- "https://data-legacy.urbansharing.com/oslobysykkel.no"
    dl_url <- glue::glue("{base_url}/{year}/{sprintf('%0.2d', month)}.csv.zip")

    if (httr::http_error(dl_url)) {

      stop("The download URL is invalid.")

    }

    # Download trip data to a temporary file, and read it
    # directly to R
    #! Problems with utilizing `data.table::fread()` for this purpose,
    #! which must be solved in a future version of the `bysykkel`package
    temp <- tempfile()
    download.file(dl_url, temp)
    filename <- bysykkel_control_legacy_oslo(year, month)
    bike_df <- read.csv(unz(temp, filename),
                        header = TRUE,
                        stringsAsFactors = FALSE,
                        encoding = "UTF-8")
    unlink(temp)

    bike_df <- tibble::as_tibble(bike_df)

    return(bike_df)

  }

}
