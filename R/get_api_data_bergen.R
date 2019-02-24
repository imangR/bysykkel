get_api_data_bergen <- function(client_id, data, return_df = FALSE) {

  # Argument control --------------------------------------------------------

  # Need to check that function arguments are valid
  stopifnot(is.character(client_id),
            is.logical(return_df),
            data %in% c("availability", "stations"))

  # Set base URL
  base_url <- "http://gbfs.urbansharing.com/bergenbysykkel.no"

  # Availability ------------------------------------------------------------

  if (data == "availability") { # Get 'Availability'

    endpoint <- "station_status.json"

    avail_result <-
      httr::GET(glue::glue("{base_url}/{endpoint}"),
                httr::add_headers("Client-Identifier" = client_id)) %>%
      httr::content("text") %>%
      jsonlite::fromJSON()

    # Need an "if" statement to return only a dataframe
    # if the `return_df` argument is set to TRUE.
    if (return_df) {
      avail_df <-
        avail_result$data$stations %>%
        dplyr::mutate(last_reported = as.POSIXct(last_reported,
                                          origin = "1970-01-01",
                                          tz = "Europe/Oslo"))
      return(avail_df)
    }

    # Need a section that returns a list if the `return_df`
    # argument is set to FALSE.
    avail_data <- list(availability_df = avail_result$data$stations,
                       last_updated    = as.POSIXct(avail_result$last_updated,
                                                    origin = "1970-01-01",
                                                    tz = Sys.timezone()))

    return(avail_data)

  # Stations ----------------------------------------------------------------

  } else if (data == "stations") { # Get 'Stations'

    endpoint <- "station_information.json"

    stations_result <-
      httr::GET(glue::glue("{base_url}/{endpoint}"),
          httr::add_headers("Client-Identifier" = client_id)) %>%
      httr::content("text") %>%
      jsonlite::fromJSON()

    # Need an "if" statement to return only a dataframe
    # if the `return_df` argument is set to TRUE.
    if (return_df) {
      stations_df <- stations_result$data$stations
      return(stations_df)
    }

    # Need a section that returns a list if the `return_df`
    # argument is set to FALSE.
    stations_last_updated <- stations_result$last_updated
    stations_df <- stations_result$data$stations
    stations_data <- list(stations_df = stations_df,
                         last_updated = as.POSIXct(stations_last_updated,
                                                   origin = "1970-01-01",
                                                   tz = Sys.timezone()))

    return(stations_data)

  }
}
