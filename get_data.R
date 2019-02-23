get_bike_data <- function(client_identifier, data, returnOriginal = FALSE) {

  # Argument control
  stopifnot(is.character(client_identifier),
            is.logical(returnMeta),
            data %in% c("availability", "stations"))

  # Required libraries
  stopifnot(require(httr,     warn.conflicts = FALSE),
            require(jsonlite, warn.conflicts = FALSE),
            require(magrittr, warn.conflicts = FALSE),
            require(purrr,    warn.conflicts = FALSE),
            require(dplyr,    warn.conflicts = FALSE))

# Availability ------------------------------------------------------------

  if (data == "availability") { # Get 'Availability'.

    bike_availability_data <-
      GET("https://oslobysykkel.no/api/v1/stations/availability",
          add_headers("Client-Identifier" = client_identifier)) %>%
      content("text") %>%
      fromJSON()

    if (returnOriginal) {
      return(bike_availability_data)
    }

    bike_availability <-
      bike_availability_data %>%
      purrr::pluck("stations")

    df <-
      tibble(id                = bike_availability$id,
             bikes             = bike_availability$availability$bikes,
             locks             = bike_availability$availability$locks,
             overflow_capacity = bike_availability$availability$overflow_capacity)

    return(df)

# Stations ----------------------------------------------------------------

  } else if (data == "stations") { # Get 'Stations'.

    bike_stations_data <-
      GET("https://oslobysykkel.no/api/v1/stations",
          add_headers("Client-Identifier" = client_identifier)) %>%
      content("text") %>%
      fromJSON()

    if (returnOriginal) {
      return(bike_stations_data)
    }

    bike_stations <-
      bike_stations_data %>%
      purrr::pluck("stations")

    df <-
      tibble(id         = bike_stations$id,
             title      = bike_stations$title,
             subtitle   = bike_stations$subtitle,
             num_locks  = bike_stations$number_of_locks,
             in_service = bike_stations$in_service,
             longitude  = bike_stations$center$longitude,
             latitude   = bike_stations$center$latitude,
             bounds     = I(bike_stations$bounds))

    return(df)

  }
}
