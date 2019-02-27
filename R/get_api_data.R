#' @title Download realtime data from the City Bike APIs in Norway
#'
#' @description
#' \code{get_api_data} downloads realtime data on bike availability and
#' bike stations from the API for
#' \href{https://developer.oslobysykkel.no/}{Oslo City Bike},
#' \href{https://bergenbysykkel.no/apne-data/sanntid}{Bergen City Bike}, and
#' \href{https://trondheimbysykkel.no/apne-data/sanntid}{Trondheim City Bike}.
#' Please read the API documentation for each City
#' Bike API before using this function.
#'
#' The data is provided according to the
#' \href{https://data.norge.no/nlod/en/2.0}{Norwegian License for Open Government Data (NLOD) 2.0}.
#'
#' @usage
#' get_api_data(client_id, data, city, return_df = FALSE)
#'
#' @param client_id
#' A \code{character} string that is the client identification to access the API.
#' @param data
#' A character string that informs the function that you want to retrieve
#'  \code{"availability"} or \code{"stations"} data.
#' @param city
#' A character string that specifies whether you want to retrieve realtime data
#' for \code{"Oslo"}, \code{"Bergen"}, or \code{"Trondheim"}.
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

get_api_data <- function(client_id, data, city, return_df = TRUE) {

# Argument control --------------------------------------------------------

  # Need to check if the `city` function argument is valid, the
  # other function arguments are controlled inside each subfunction
  stopifnot(city %in% c("Oslo", "Bergen", "Trondheim"))

# Control structure -------------------------------------------------------

  if (city == "Oslo") {
    get_api_data_oslo(client_id, data, return_df)
  } else if (city == "Bergen") {
    get_api_data_bergen(client_id, data, return_df)
  } else if (city == "Trondheim") {
    get_api_data_trondheim(client_id, data, return_df)
  } else {
    warning("Choose 'Oslo', 'Bergen', or 'Trondheim' for the `city` argument.")
  }

}
