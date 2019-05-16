#' @title Get real-time data from the city bike APIs in Norway
#'
#' @description
#' \code{get_api_data} gets real-time data on bike availability, stations, and
#' system from the API for
#'
#' \itemize{
#'   \item \href{https://oslobysykkel.no/en/open-data/realtime}{Oslo City Bike},
#'   \item \href{https://oslovintersykkel.no/en/open-data/realtime}{Oslo Winter Bike},
#'   \item \href{https://bergenbysykkel.no/en/open-data/realtime}{Bergen City Bike}
#'   \item \href{https://trondheimbysykkel.no/en/open-data/realtime}{Trondheim City Bike}
#' }
#'
#' Please read the API documentation for each City Bike API before using
#' this function.
#'
#' The real-time data is provided in the GBFS (General Bikeshare Feed
#' Specification) format, which you can read more about on
#' \href{https://github.com/NABSA/gbfs/blob/master/gbfs.md}{here}.
#'
#' The data is provided according to the Norwegian License for Open Government
#' Data 2.0 \href{https://data.norge.no/nlod/en/2.0}{NLOD 2.0}.
#'
#' @usage
#' get_api_data(client_id, data, city, return_df = FALSE)
#'
#' @param client_id
#' A string. The string should represent a client identifier to access the
#' API. The client identifier must be of the form \code{"myname-myapp"} or
#' \code{"mycompany-myservice"}, such that the city bike service knows
#' who is accessing the API, and for what purpose(s). Please visit the website
#' of the API service that you want to access to learn how to correctly specify
#' the \code{client_id}.
#'
#' @param data
#' A string. The data that you want to get from the API. The options are
#' "availability", "stations", and "system".
#'
#' @param city
#' A string. The city, or city bike service API, that you want to get data
#' from. The options are "Oslo", "OsloW" (for winter bike data
#' in Oslo), "Bergen", or "Trondheim".
#'
#' @param return_df
#' Either \code{TRUE} or \code{FALSE}. Instructs the function on whether to
#' return only a tibble (if set to \code{TRUE}).
#'
#' @return
#' If \code{return_df = FALSE}, then the function returns a \code{list} that
#' contains two elements: a data frame with the
#' "main" data, and the datetime (POSIX) for the API request. If
#' \code{return_df = TRUE}, then the function returns only a tibble.
#'
#' @examples
#'\dontrun{
#'
#' # Get data on bike "availability"
#' oslo_api_data <- get_api_data(client_id = "mycompany-myservice",
#'                               data      = "availability",
#'                               city      = "Oslo")
#'
#' # Get winter data on bike "availability", but return a tibble
#' oslo_winter_bike <- get_api_data(client_id = "myname-myapp",
#'                                  data      = "availability",
#'                                  city      = "OsloW",
#'                                  return_df = TRUE)
#'
#'}
#'
#' @importFrom tibble as_tibble
#' @importFrom httr GET
#' @importFrom httr content
#' @importFrom httr add_headers
#' @importFrom jsonlite fromJSON
#' @export get_api_data

get_api_data <- function(client_id, data, city, return_df = FALSE) {

  # Control input arguments -------------------------------------------------

  bysykkel_control_api_input(client_id, data, city, return_df)

  message(glue::glue("Getting {data} data for {city}."))

  # Control structure -------------------------------------------------------

  switch(city,
    "Oslo" = get_api_data_oslo(client_id, data, return_df),
    "OsloW" = get_api_data_oslow(client_id, data, return_df),
    "Bergen" = get_api_data_bergen(client_id, data, return_df),
    "Trondheim" = get_api_data_trondheim(client_id, data, return_df),
    stop("Something went wrong.")
  )

}
