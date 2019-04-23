get_api_data_oslow <- function(client_id, data, return_df = FALSE) {

  # Set base URL
  base_url <- "http://gbfs.urbansharing.com/oslovintersykkel.no"

  # Availability ------------------------------------------------------------

  if (data == "availability") { # Get 'Availability'

    endpoint <- "station_status.json"

    avail_get <- httr::GET(glue::glue("{base_url}/{endpoint}"),
                           httr::add_headers("Client-Identifier" = client_id))

    avail_content <- httr::content(avail_get, "text", encoding = "UTF-8")

    avail_result <- jsonlite::fromJSON(avail_content)

    avail_df <- avail_result$data$stations

    avail_df$last_reported <- as.POSIXct(avail_df$last_reported,
                                         origin = "1970-01-01",
                                         tz = "Europe/Oslo")

    avail_df <- tibble::as_tibble(avail_df)

    # A control that returns only a dataframe
    # if the `return_df` argument is set to TRUE.
    if (return_df) return(avail_df)

    # Return a list if the `return_df` argument is set to FALSE.
    avail_data <- list(availability_df = avail_df,
                       last_updated = avail_result$last_updated)

    # Stations ----------------------------------------------------------------

  } else if (data == "stations") { # Get 'Stations'

    endpoint <- "station_information.json"

    stations_get <-
      httr::GET(glue::glue("{base_url}/{endpoint}"),
                httr::add_headers("Client-Identifier" = client_id))

    stations_content <- httr::content(stations_get, "text", encoding = "UTF-8")

    stations_result <- jsonlite::fromJSON(stations_content)

    stations_df <- tibble::as_tibble(stations_result$data$stations)

    # A control that returns only a dataframe
    # if the `return_df` argument is set to TRUE.
    if (return_df) return(stations_df)

    # Return a list if the `return_df` argument is set to FALSE.
    stations_data <- list(stations_df = stations_df,
                          last_updated = stations_result$last_updated)

  } else if (data == "system") { # Get 'System'

    endpoint <- "system_information.json"

    system_get <-
      httr::GET(glue::glue("{base_url}/{endpoint}"),
                httr::add_headers("Client-Identifier" = client_id))

    system_content <- httr::content(system_get, "text", encoding = "UTF-8")

    system_result <- jsonlite::fromJSON(system_content)

    system_df <- tibble::as_tibble(system_result$data)

    # A control that returns only a dataframe
    # if the `return_df` argument is set to TRUE.
    if (return_df) return(system_df)

    # Return a list if the `return_df` argument is set to FALSE.
    system_data <- list(system_df = system_df,
                        last_updated = system_result$last_updated)

  } else {

    stop("Something went wrong.")

  }

}
