#' @title Fast read historical bike trips data in Norway directly into R
#'
#' @description
#' \code{fread_trips_data} imports anonymized
#' historical bike trip records in Norway for the city of Oslo, Bergen,
#' and Trondheim directly into R.
#'
#' Reading the trip records CSV files from the City Bike websites can
#' take its time using \code{read_trips_data}. To speed up the process,
#' \code{fread_trips_data} utilizes the \code{fread} function in the
#' \code{data.table} packages. To use \code{fread_trips_data} requires
#' having \code{data.table} installed.
#'
#' To get trip records for winter bikes in each city, add a capital "W" at
#' the end of the city name (f.ex. "OsloW" for Oslo). Trip records for winter
#' bikes are currently available for Oslo only at the time of writing
#' (2019-03-04).
#'
#' The data is provided according to the Norwegian License for Open Government
#' Data 2.0 \href{https://data.norge.no/nlod/en/2.0}{NLOD 2.0}.
#'
#' @usage
#' fread_trips_data(year, month, city)
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
#' # Read bike trips data for the month of January 2019 in Bergen
#' bergen_trips <- fread_trips_data(2019, 1, "Bergen")
#'
#' # Read bike trips data for the month of October 2018 in Trondheim
#' trondheim_trips <- fread_trips_data(2018, 10, "Trondheim")
#'
#' # Use "lapply" to read bike trips data for several months in Oslo
#' oslo_winter_trips <- lapply(01:02, fread_trips_data, year = 2019, city = "OsloW")
#'}
#'
#' @importFrom data.table fread
#' @importFrom glue glue
#' @export fread_trips_data

fread_trips_data <- function(year, month, city) {

  glue::glue("Getting data for {year}-{sprintf('%0.2d', month)} for the city of {city}.")

  # Argument control --------------------------------------------------------

  stopifnot(is.character(city),
            is.numeric(month),
            is.numeric(year),
            city %in% c("OsloW", "Bergen", "Trondheim"),
            month %in% c(1:12))

  # Control structure -------------------------------------------------------

  if (city == "OsloW") {
    fread_trips_data_oslow(year, month)
  } else if (city == "Bergen") {
    fread_trips_data_bergen(year, month)
  } else if (city == "Trondheim") {
    fread_trips_data_trondheim(year, month)
  } else {
    warning("Please choose a valid argument for `city`.")
  }

}
