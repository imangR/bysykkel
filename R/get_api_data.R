#' @title Get realtime data from City Bike API
#'
#' @description \code{get_api_data} gets realtime data from the
#' City Bike API for Oslo, Bergen or Trondheim in Norway.
#'
#' @usage
#'
#'
#' @param client_id
#' A character string that is the client identification to access the API.
#' @param data
#' A character string that informs the function that you want to retrieve
#'  \code{"availability"} or \code{"stations"} data.
#' @param returnOriginal
#' Optional. A logical argument that specifies if you want to retrieve
#'  the original \code{GET} request instead of a dataframe.
#'  Defaults to \code{FALSE}.
#'
#' @return
#' Returns a dataframe if \code{returnOriginal = FALSE}. Returns a
#' a list if \code{returnOriginal = TRUE}.
#'
#' @importFrom magrittr %>%
#' @importFrom tibble tibble
#' @importFrom httr GET
#' @importFrom httr content
#' @importFrom jsonlite fromJSON
#' @importFrom purrr pluck

get_api_data <- function(client_id, data, returnOriginal = FALSE) {


# Argument control --------------------------------------------------------

  # Need to check that function arguments are valid
  stopifnot(is.character(client_id),
            is.logical(returnOriginal),
            data %in% c("availability", "stations"))

# Availability ------------------------------------------------------------

  if (data == "availability") { # Get 'Availability'

    avail_result <-
      httr::GET("https://oslobysykkel.no/api/v1/stations/availability",
                add_headers("Client-Identifier" = client_id)) %>%
      httr::content("text") %>%
      jsonlite::fromJSON()

    if (returnOriginal) {
      return(avail_result)
    }

    avail_data <-
      avail_result %>%
      purrr::pluck("stations")

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
          add_headers("Client-Identifier" = client_id)) %>%
      content("text") %>%
      fromJSON()

    if (returnOriginal) {
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
