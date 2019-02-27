get_api_data_oslo <- function(client_id, data, return_df = FALSE) {

  # Argument control --------------------------------------------------------

  # Need to check that function arguments are valid
  stopifnot(is.character(client_id),
            is.logical(return_df),
            data %in% c("availability", "stations"))

  # Availability ------------------------------------------------------------

  if (data == "availability") { # Get 'Availability'

    avail_request <-
      httr::GET("https://oslobysykkel.no/api/v1/stations/availability",
                httr::add_headers("Client-Identifier" = client_id))

    avail_last_updated <- as.numeric(avail_request$date)

    avail_result <-
      avail_request %>%
      httr::content("text") %>%
      jsonlite::fromJSON()

    avail_df <- tibble::as_tibble(avail_result$stations)

    if (return_df) {
      return(avail_df)
    }

    avail_data <- list(availability_df = avail_df,
                       last_updated    = avail_last_updated)

    return(avail_data)

  # Stations ----------------------------------------------------------------

  } else if (data == "stations") { # Get 'Stations'

    stations_request <-
      httr::GET("https://oslobysykkel.no/api/v1/stations",
          httr::add_headers("Client-Identifier" = client_id))

    stations_last_updated <- as.numeric(stations_request$date)

    stations_result <-
      stations_request %>%
      httr::content("text") %>%
      jsonlite::fromJSON()

    stations_df <- tibble::as_tibble(stations_result$stations)

    if (return_df) {
      return(stations_df)
    }

    stations_data <- list(stations_df  = stations_df,
                          last_updated = stations_last_updated)

    return(stations_data)

  }
}
