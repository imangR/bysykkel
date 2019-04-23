#' @title Read historical bike trips data in Norway to R
#'
#' @description
#' \code{read_trips_data} imports anonymized
#' historical bike trip records in Norway for the city of Oslo, Bergen,
#' and Trondheim directly to R.
#'
#' To get bike trips data for winter bikes in each city, add a capital "W" at
#' the end of the city name (f.ex. "OsloW" for Oslo). Trip data for winter
#' bikes are currently only available for Oslo at the time of writing
#' (2019-04-16).
#'
#' The data is provided according to the Norwegian License for Open Government
#' Data 2.0 \href{https://data.norge.no/nlod/en/2.0}{NLOD 2.0}.
#'
#' The data is read from:
#'
#' \itemize{
#'   \item \href{https://oslobysykkel.no/en/open-data/historical}{Oslo City Bike}
#'   \item \href{https://oslovintersykkel.no/en/open-data/historical}{Oslo Winter Bike}
#'   \item \href{https://bergenbysykkel.no/en/open-data/historical}{Bergen City Bike}
#'   \item \href{https://trondheimbysykkel.no/en/open-data/historical}{Trondheim City Bike}
#'}
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
#' }
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

  switch(city,
    "Oslo" = read_trips_data_oslo(year, month),
    "OsloW" = read_trips_data_oslow(year, month),
    "Bergen" = read_trips_data_bergen(year, month),
    "Trondheim" = read_trips_data_trondheim(year, month),
    stop("Something went wrong.")
  )

}
