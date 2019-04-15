#' @title Get realtime data from the City Bike APIs in Norway
#'
#' @description
#' \code{get_api_data} gets realtime data on bike availability, stations, and
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
#' The realtime data is provided in the GBFS (General Bikeshare Feed
#' Specification) format, which you can read more about on
#' \href{https://github.com/NABSA/gbfs/blob/master/gbfs.md}{GitHub}.
#'
#' The data is provided according to the Norwegian License for Open Government
#' Data 2.0 \href{https://data.norge.no/nlod/en/2.0}{NLOD 2.0}.
#'
#' @usage
#' get_api_data(client_id, data, city, return_df = FALSE)
#'
#' @param client_id
#' A character string that contains a client identifier to access the API. The
#' client identifier must be of the form \code{"myname-myapp"} or
#' \code{"mycompany-myservice"}, such that the API service knows
#' who is accessing the API and for what purpose. Please visit the website
#' of the City Bike data you want to access to learn how to correctly specify
#' the \code{client_id}.
#'
#' @param data
#' A character string that informs the function that you want to retrieve data
#' for \code{"availability"}, \code{"stations"}, or \code{"system"}.
#'
#' @param city
#' A character string that informs the function whether you want to retrieve
#' realtime data for \code{"Oslo"}, \code{"OsloW"} (for winter bike data in
#' Oslo), \code{"Bergen"}, or \code{"Trondheim"}.
#'
#' @param return_df
#' A logical that specifies whether you want the function
#' to return a \code{tibble} (i.e. a \code{dataframe}) that
#' contains the "main" data from the GET request. Defaults to \code{FALSE}.
#'
#' @return
#' If \code{return_df = FALSE}, then the function returns a \code{list} that
#' contains two elements: a dataframe with the
#' "main" data, and the datetime (POSIX) for the API request. If
#' \code{return_df = FALSE}, then the function returns a \code{tibble}
#' (i.e. a dataframe) only.
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
    warning("Something went wrong.")
  }

}
