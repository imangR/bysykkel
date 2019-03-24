#' @title Download historical bike trips data in Norway
#'
#' @description
#' \code{dl_trips_data} downloads anonymized historical bike trip records in
#' Norway for the city of Oslo, Bergen, and Trondheim.
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
#' dl_trips_data(year, month, city)
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
#' The function downloads a CSV-file to your current working directory.
#'
#' @examples
#' \dontrun{
#' # Download bike trips data for the month of January, 2019, in Bergen
#' dl_trips_data(2019, 01, "Bergen")
#'
#' # Download bike trips data for the month of October, 2018, in Trondheim
#' dl_trips_data(2018, 10, "Trondheim")
#'
#' # Use "lapply" to get bike trips data for several months in Oslo
#' lapply(06:12, dl_trips_data, year = 2018, city = "Oslo")
#'}
#'
#' @importFrom magrittr %>%
#' @importFrom glue glue
#' @importFrom utils download.file
#' @export dl_trips_data

dl_trips_data <- function(year, month, city) {

  glue::glue("Downloading data for {year}-{sprintf('%0.2d', month)} for the city of {city}.")

  stopifnot(is.character(city),
            is.numeric(month),
            is.numeric(year),
            city %in% c("Oslo", "OsloW", "Bergen", "Trondheim"),
            month %in% c(1:12))

  if (city == "Oslo") {
    dl_trips_data_oslo(year, month)
  } else if (city == "OsloW") {
    dl_trips_data_oslow(year, month)
  } else if (city == "Bergen") {
    dl_trips_data_bergen(year, month)
  } else if (city == "Trondheim") {
    dl_trips_data_trondheim(year, month)
  } else {
    warning("Please choose a valid argument for `city`.")
  }

}
