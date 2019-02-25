get_api_data_oslo <- function(client_id, data, return_df = TRUE) {

  # Argument control --------------------------------------------------------

  # Need to check that function arguments are valid
  stopifnot(is.character(client_id),
            is.logical(return_df),
            data %in% c("availability", "stations"))

  # Availability ------------------------------------------------------------

  if (data == "availability") { # Get 'Availability'

    avail_result <-
      httr::GET("https://oslobysykkel.no/api/v1/stations/availability",
                httr::add_headers("Client-Identifier" = client_id)) %>%
      httr::content("text") %>%
      jsonlite::fromJSON()

    if (return_df == FALSE) {
      return(avail_result)
    }

    avail_data <- avail_result$stations

    avail_df <-
      tibble(id                = avail_data$id,
             bikes             = avail_data$availability$bikes,
             locks             = avail_data$availability$locks,
             overflow_capacity = avail_data$availability$overflow_capacity)

    return(avail_df)

    # Stations ----------------------------------------------------------------

  } else if (data == "stations") { # Get 'Stations'

    stations_result <-
      GET("https://oslobysykkel.no/api/v1/stations",
          httr::add_headers("Client-Identifier" = client_id)) %>%
      content("text") %>%
      fromJSON()

    if (return_df == FALSE) {
      return(stations_result)
    }

    stations_data <-
      stations_result %>%
      purrr::pluck("stations")

    stations_df <-
      tibble(id         = stations_data$id,
             title      = stations_data$title,
             subtitle   = stations_data$subtitle,
             num_locks  = stations_data$number_of_locks,
             in_service = stations_data$in_service,
             longitude  = stations_data$center$longitude,
             latitude   = stations_data$center$latitude,
             bounds     = I(stations_data$bounds))

    return(stations_df)

  }
}
