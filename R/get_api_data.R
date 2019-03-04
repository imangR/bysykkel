#' @title Get realtime bike data from the City Bike APIs in Norway
#'
#' @description
#' \code{get_api_data} gets realtime data on bike availability and
#' bike stations from the API for
#' \href{https://developer.oslobysykkel.no/}{Oslo City Bike},
#' \href{https://bergenbysykkel.no/apne-data/sanntid}{Bergen City Bike}, and
#' \href{https://trondheimbysykkel.no/apne-data/sanntid}{Trondheim City Bike}.
#' Please read the API documentation for each City Bike API before using
#' this function.
#'
#' The data is provided according to the Norwegian License for Open Government
#' Data 2.0 \href{https://data.norge.no/nlod/en/2.0}{NLOD 2.0}.
#'
#' @usage
#' get_api_data(client_id, data, city, return_df = FALSE)
#'
#' @param client_id
#' A character string that contains a client identifier to access the API.
#' Please visit the City Bike's website to learn more about how to use
#' \code{client_id} to access the API.
#'
#' @param data
#' A character string that informs the function that you want to retrieve
#' \code{"availability"} or \code{"stations"} data.
#'
#' @param city
#' A character string that informs the function whether you want to retrieve
#' realtime data for \code{"Oslo"}, \code{"OsloW"} (for winter bike data in
#' Oslo, \code{"Bergen"}, or \code{"Trondheim"}.
#'
#' @param return_df
#' A logical argument that specifies whether you want the function
#' to return a \code{tibble} that contains the "main" data
#' from the GET request. Defaults to \code{FALSE}.
#'
#' @return
#' If \code{return_df = FALSE}, then the function returns a \code{list} that
#' contains two elements: a dataframe with the
#' "main" data, and the datetime (POSIX) for the API request. If
#' \code{return_df = FALSE}, then the function returns a \code{tibble}
#' (i.e. a dataframe) if \code{return_df = TRUE}.
#'
#' @examples
#' # Get data on bike "availability"
#' oslo_api_data <- get_api_data(client_id = "registered_client_id",
#'                               data = "availability",
#'                               city = "Oslo")
#'
#' # Get winter data on bike "availability"
#' oslo_winter_bike <- get_api_data(client_id = "myname-myapp",
#'                                  data = "availability",
#'                                  city = "OsloW")
#'
#' # Get data on bike "availability", but return a tibble
#' bergen_stations <- get_api_data(client_id = "mycompany-myservice",
#'                                     data = "stations",
#'                                     city = "Bergen",
#'                                     return_df = TRUE)
#'
#' @importFrom magrittr %>%
#' @importFrom tibble tibble
#' @importFrom httr GET
#' @importFrom httr content
#' @importFrom jsonlite fromJSON
#' @export get_api_data

get_api_data <- function(client_id, data, city, return_df = FALSE) {

# Argument control --------------------------------------------------------

  # Need to check if the `city` function argument is valid, the
  # other function arguments are controlled inside each subfunction
  stopifnot(is.character(client_id),
            is.logical(return_df),
            data %in% c("availability", "stations"),
            city %in% c("Oslo", "OsloW", "Bergen", "Trondheim"))

# Control structure -------------------------------------------------------

  if (city == "Oslo") {
    get_api_data_oslo(client_id, data, return_df)
  } else if (city == "OsloW") {
    get_api_data_oslow(client_id, data, return_df)
  } else if (city == "Bergen") {
    get_api_data_bergen(client_id, data, return_df)
  } else if (city == "Trondheim") {
    get_api_data_trondheim(client_id, data, return_df)
  } else {
    warning("Please choose a valid argument for `city`.")
  }

}
