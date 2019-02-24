#' @title Get realtime data from the Oslo City Bike API
#'
#' @description
#' \code{get_api_data} gets realtime data on bike availability and
#' bike stations from the Oslo City Bike API. Please read the
#' API documentation on the
#' \href{https://developer.oslobysykkel.no/}{Oslo City Bike developer website}.
#' The data is provided according to the
#' \href{https://data.norge.no/nlod/en/2.0}{Norwegian License for Open Government Data (NLOD) 2.0}.
#'
#' @usage
#' get_api_data(client_id, data, return_df = TRUE)
#'
#' @param client_id
#' A \code{character} string that is the client identification to access the API.
#' @param data
#' A \code{character} string that informs the function that you want to retrieve
#'  \code{"availability"} or \code{"stations"} data.
#' @param return_df
#' A logical argument that specifies whether you want the function
#' to return a \code{tibble} (i.e. \code{dataframe}) of the data retrieved from
#' the \code{GET} request. If set to \code{FALSE}, the function returns the processed
#' \code{GET} request as a \code{list}. Defaults to \code{TRUE}.
#'
#' @return
#' Returns a \code{tibble} (i.e. \code{dataframe}) if \code{return_df = TRUE}. Returns a
#' a \code{list} if \code{return_df = FALSE}.
#'
#' @examples
#' # Get data on bike "availability"
#' get_api_data(client_id = "1234abcd", data = "availability")
#'
#' # Get data on bike "availability", but return the GET result
#' get_api_data(client_id = "1234abcd", data = "availability",
#'              return_df = TRUE)
#'
#' # Get data on bike "stations"
#' get_api_data(client_id = "1234abcd", data = "stations")
#'
#' @importFrom magrittr %>%
#' @importFrom tibble tibble
#' @importFrom httr GET
#' @importFrom httr content
#' @importFrom jsonlite fromJSON
#' @importFrom purrr pluck

get_api_data <- function(client_id, data, return_df = TRUE) {

# Argument control --------------------------------------------------------

  # Need to check that function arguments are valid
  stopifnot(is.character(client_id),
            is.logical(return_df),
            data %in% c("availability", "stations"))

# Availability ------------------------------------------------------------

  if (data == "availability") { # Get 'Availability'

    avail_result <-
      httr::GET("https://oslobysykkel.no/api/v1/stations/availability",
                add_headers("Client-Identifier" = client_id)) %>%
      httr::content("text") %>%
      jsonlite::fromJSON()

    if (return_df == FALSE) {
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
