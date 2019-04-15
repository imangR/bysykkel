bysykkel_control_date <- function(year, month, city) {

  # Store the year and month from the system
  current.year <- lubridate::year(Sys.Date())
  current.month <- lubridate::month(Sys.Date(), label = TRUE, abbr = FALSE)

  # Store the year and month used as input in the `bysykkel` function
  function.year <- year
  function.month <- lubridate::month(month, label = TRUE, abbr = FALSE)
  function.date <- paste(function.year, "-", function.month, "-", 1, sep = "")
  function.date <- as.Date(function.date, format = "%Y-%B-%d")

  # A list that stores the minimum year for all choices of city
  min.year.list <- list(Oslo      = 2016,
                        Bergen    = 2018,
                        Trondheim = 2018,
                        OsloW     = 2018)

# Control structure -------------------------------------------------------

  # Stop if `function.year` is too low
  if (function.year < min.year.list[[city]]) {

    stop(glue::glue("There is no bike data for that year. Bike data for ",
                    "{city} is available from {min.year.list[[city]]} at ",
                    "the earliest, while you requested data for ",
                    "{function.year}."))

  # Stop if `function.year` is too high
  } else if (function.year > current.year) {

      stop(glue::glue("Bike data for {function.year} does not exist...yet."))

  # Stop if `function.month` is "NA"
  } else if (is.na(function.month)) {

      stop(glue::glue("The month number {as.integer(function.month)} does ",
                      "not exist in the Gregorian calendar."))

  # Stop if `function.month` is too high
  } else if (function.date > Sys.Date()) {

      stop(glue::glue("Bike data for {function.month}, {function.year} does ",
                      "not exist yet since the month and year is currently ",
                      "{current.month}, {current.year}."))

  }

}
