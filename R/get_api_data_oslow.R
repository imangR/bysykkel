get_api_data_oslow <- function(client_id, data, return_df = FALSE) {

  # Set base URL
  base_url <- "http://gbfs.urbansharing.com/oslovintersykkel.no"

  # Availability ------------------------------------------------------------

  if (data == "availability") { # Get 'Availability'

    endpoint <- "station_status.json"

    avail_result <-
      httr::GET(glue::glue("{base_url}/{endpoint}"),
                httr::add_headers("Client-Identifier" = client_id)) %>%
      httr::content("text") %>%
      jsonlite::fromJSON()

    avail_df <- avail_result$data$stations
    avail_df[, "last_reported"] <-  as.POSIXct(avail_df$last_reported,
                                               origin = "1970-01-01",
                                               tz = "Europe/Oslo")
    avail_df <- tibble::as_tibble(avail_df)

    # Need an "if" statement to return only a dataframe
    # if the `return_df` argument is set to TRUE.
    if (return_df) {
      return(avail_df)
    }

    # Need a section that returns a list if the `return_df`
    # argument is set to FALSE.
    avail_data <- list(availability_df = avail_df,
                       last_updated    = avail_result$last_updated)

    return(avail_data)

    # Stations ----------------------------------------------------------------

  } else if (data == "stations") { # Get 'Stations'

    endpoint <- "station_information.json"

    stations_result <-
      httr::GET(glue::glue("{base_url}/{endpoint}"),
                httr::add_headers("Client-Identifier" = client_id)) %>%
      httr::content("text") %>%
      jsonlite::fromJSON()

    stations_df <- tibble::as_tibble(stations_result$data$stations)

    # Need an "if" statement to return only a dataframe
    # if the `return_df` argument is set to TRUE.
    if (return_df) {
      return(stations_df)
    }

    # Need a section that returns a list if the `return_df`
    # argument is set to FALSE.
    stations_data <- list(stations_df = stations_df,
                          last_updated = stations_result$last_updated)

    return(stations_data)

  }
}
