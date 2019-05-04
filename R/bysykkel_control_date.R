bysykkel_control_date <- function(year, month, city) {

  # Store the year and month from the system
  current.year <- lubridate::year(Sys.Date())
  current.month <- lubridate::month(Sys.Date(), label = TRUE, abbr = FALSE)

  # Store the year and month used as input in the `bysykkel` function
  function.year <- year
  function.month <- lubridate::month(month, label = TRUE, abbr = FALSE)
  function.month.num <- month

  ## Convert function input to a `date` object to make date comparisons
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

    message <-
      glue::glue("There is no bike data for that year. Bike data for ",
                 "{city} is available from {min.year.list[[city]]} at ",
                 "the earliest, while you requested data for ",
                 "{function.year}.")

    stop(message, call. = FALSE)

  }

  # Stop if `function.year` is too high
  if (function.year > current.year) {

    message <-
      glue::glue("Bike data for {function.year} does not exist...yet.")

    stop(message, call. = FALSE)

  }

  # Stop if `function.month` is "NA"
  if (is.na(function.month)) {

    message <-
      glue::glue("The month number {function.month.num} does not exist in ",
                 "the Gregorian calendar. Please enter `month` as a number ",
                 "in the [1, 12] range.")

    stop(message, call. = FALSE)

  }

  # Stop if `function.date` is too high
  if (function.date > Sys.Date()) {

    message <-
      glue::glue("Bike data for {function.year}-{function.month} does ",
                 "not exist yet since the year and month is currently ",
                 "{current.year}-{current.month}.")

    stop(message, call. = FALSE)

  }

}
