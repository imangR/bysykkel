#' @title Read historical bike trips data in Norway directly into R
#'
#' @description
#' \code{read_trips_data} and \code{fread_trips_data} imports anonymized
#' historical bike trip records in Norway for the city of Oslo, Bergen,
#' and Trondheim directly into R.
#'
#' Reading the trip records CSV files from the City Bike websites can
#' take its time. To speed up the process, \code{fread_trips_data} utilizes
#' the \code{fread} function in the \code{data.table} packages. To use
#' \code{fread_trips_data} requires having \code{data.table} installed.
#'
#' To get trip records for winter bikes in each city, add a capital "W" at
#' the end of the city name (f.ex. "OsloW" for Oslo). Trip records for winter
#' bikes are currently only available for Oslo at the time of writing
#' (2019-03-04).
#'
#' The data is provided according to the Norwegian License for Open Government
#' Data 2.0 \href{https://data.norge.no/nlod/en/2.0}{NLOD 2.0}.
#'
#' @usage
#' read_trips_data(year, month, city)
#'
#' @param year
#' A numeric variable that informs the function for which year you want to
#' download data.
#'
#' @param month
#' A numeric variable that informs the function for which year you want to
#' download data.
#'
#' @param city
#' A character string that informs the function for which city you want to
#' download data from.
#'
#' @return
#' The function reads in bike trips data for the specified year and month
#' as a tibble in R.
#'
#' @examples
#' \dontrun{
#'
#' # Read bike trips data for the month of January 2019 in Bergen
#' bergen_trips <- read_trips_data(2019, 1, "Bergen")
#'
#' # Read bike trips data for the month of October 2018 in Trondheim
#' trondheim_trips <- read_trips_data(2018, 10, "Trondheim")
#'
#' # Use "lapply()" to read bike trips data for several months in Oslo
#' oslo_winter_trips <- lapply(01:02, read_trips_data, year = 2019, city = "OsloW")
#'
#' # Use "rbind()" to bind each element of the list "oslo_winter_trips" to
#' # to a dataframe
#' oslo_winter_trips <- do.call(rbind, oslo_winter_trips)
#'
#'}
#'
#' @importFrom glue glue
#' @importFrom tibble as_tibble
#' @importFrom httr http_error
#' @importFrom lubridate month
#' @importFrom lubridate year
#' @export read_trips_data

read_trips_data <- function(year, month, city) {

# Control input arguments -------------------------------------------------

  bysykkel_control_input(year, month, city)

  bysykkel_control_date(year, month, city)

  print(glue::glue("Getting bike data for ",
                   "{lubridate::month(month, label = TRUE, abbr = FALSE)}, ",
                   "{year} for {city}."))

# Control structure -------------------------------------------------------

  if (city == "Oslo") {
    read_trips_data_oslo(year, month)
  } else if (city == "OsloW") {
    read_trips_data_oslow(year, month)
  } else if (city == "Bergen") {
    read_trips_data_bergen(year, month)
  } else if (city == "Trondheim") {
    read_trips_data_trondheim(year, month)
  } else {
    warning("Something went wrong.")
  }

}
