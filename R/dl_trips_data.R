#' @title Download historical bike trips data in Norway
#'
#' @description
#' \code{dl_trips_data} downloads a file of anonymized historical bike
#' trips data in Norway for the city of Oslo, Bergen, and Trondheim.
#'
#' The data is provided according to the Norwegian License for Open Government
#' Data 2.0 \href{https://data.norge.no/nlod/en/2.0}{NLOD 2.0}.
#'
#' The data is downloaded from:
#'
#' \itemize{
#'   \item \href{https://oslobysykkel.no/en/open-data/historical}{Oslo City Bike}
#'   \item \href{https://bergenbysykkel.no/en/open-data/historical}{Bergen City Bike}
#'   \item \href{https://trondheimbysykkel.no/en/open-data/historical}{Trondheim City Bike}
#'}
#'
#' @usage
#' dl_trips_data(year, month, city, filetype = "CSV")
#'
#' @param year
#' A number. The year that you want to download data for.
#'
#' @param month
#' A number. The month that you want to download data for.
#'
#' @param city
#' A string. The city that you want to download data for. The options are
#' "Oslo", "Bergen", and "Trondheim".
#'
#' @param filetype
#' A string. The filetype that you want to download data for. The options are
#' "CSV" (default) and "JSON".
#'
#' @return
#' The function downloads a CSV-file to your current working directory.
#'
#' @examples
#' \dontrun{
#'
#' # Download bike trip data for the month of January, 2019, in Bergen
#' # as CSV or JSON
#' dl_trips_data(year = 2019, month = 01, city = "Bergen", filetype = "CSV)
#'
#' dl_trips_data(year = 2019, month = 01, city = "Bergen", filetype = "JSON)
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

dl_trips_data <- function(year, month, city, filetype = "CSV") {

  # Control input arguments -------------------------------------------------

  filetype <- tolower(filetype)

  if (filetype != "csv" & filetype != "json") {

    stop(glue::glue("`filetype` must be set to \"CSV\" or \"JSON\". You input ",
                    "\"{filetype}\" for the `filetype` argument."))

  }

  bysykkel_control_input(year, month, city)

  bysykkel_control_date(year, month, city)

  message(glue::glue("Downloading bike data for {city} for ",
                     "{lubridate::month(month, label = TRUE, abbr = FALSE)}, ",
                     "{year}."))

  # Control structure -------------------------------------------------------

  switch(city,
    "Oslo" = dl_trips_data_oslo(year, month, filetype),
    "Bergen" = dl_trips_data_bergen(year, month, filetype),
    "Trondheim" = dl_trips_data_trondheim(year, month, filetype),
    stop(paste0("\"", city, "\" is an invalid city name."))
  )

}
