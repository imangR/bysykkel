#' @title Download historical bike trips data in Norway
#'
#' @description
#' \code{dl_trips_data} downloads a CSV-file of anonymized historical bike
#' trips data in Norway for the city of Oslo, Bergen, and Trondheim.
#'
#' To download bike trips data for winter bikes in Oslo, add a capital "W" at
#' the end of the city name (i.e. "OsloW"). Trip records for winter
#' bikes are currently only available for Oslo at the time of writing
#' (2019-03-04).
#'
#' The data is provided according to the Norwegian License for Open Government
#' Data 2.0 \href{https://data.norge.no/nlod/en/2.0}{NLOD 2.0}.
#'
#' The data is downloaded from:
#'
#' \itemize{
#'   \item \href{https://oslobysykkel.no/en/open-data/historical}{Oslo City Bike}
#'   \item \href{https://oslovintersykkel.no/en/open-data/historical}{Oslo Winter Bike}
#'   \item \href{https://bergenbysykkel.no/en/open-data/historical}{Bergen City Bike}
#'   \item \href{https://trondheimbysykkel.no/en/open-data/historical}{Trondheim City Bike}
#'}
#'
#' @usage
#' dl_trips_data(year, month, city)
#'
#' @param year
#' A number. The year that you want to download data for.
#'
#' @param month
#' A number. The month that you want to download data for.
#'
#' @param city
#' A string. The city that you want to download data for. The options are
#' "Oslo", "OsloW", "Bergen", and "Trondheim".
#'
#' @return
#' The function downloads a CSV-file to your current working directory.
#'
#' @examples
#' \dontrun{
#'
#' # Download bike trips data for the month of January, 2019, in Bergen
#' dl_trips_data(year = 2019, month = 01, city = "Bergen")
#'
#' # Download bike trips data for the month of October, 2018, in Trondheim
#' dl_trips_data(2018, 10, "Trondheim")
#'
#' # Use "lapply()" to download bike trips data for several months in Oslo
#' lapply(06:08, dl_trips_data, year = 2018, city = "Oslo")
#'
#'}
#'
#' @importFrom glue glue
#' @importFrom httr http_error
#' @importFrom utils download.file
#' @importFrom utils unzip
#' @export dl_trips_data

dl_trips_data <- function(year, month, city) {

# Control input arguments -------------------------------------------------

  bysykkel_control_input(year, month, city)

  bysykkel_control_date(year, month, city)

  message(glue::glue("Downloading bike data for {city} for ",
                     "{lubridate::month(month, label = TRUE, abbr = FALSE)}, ",
                     "{year}."))

  # Control structure -------------------------------------------------------

  switch(city,
    "Oslo" = dl_trips_data_oslo(year, month),
    "OsloW" = dl_trips_data_oslow(year, month),
    "Bergen" = dl_trips_data_bergen(year, month),
    "Trondheim" = dl_trips_data_trondheim(year, month),
    stop("Something went wrong.")
  )

}
