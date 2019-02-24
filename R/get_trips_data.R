get_trips_data <- function(year, month, city) {

  print(glue("Getting data for {year}-{sprintf('%0.2d', month)} for the city of {city}."))

  stopifnot(month %in% c(1:12),
            is.numeric(year),
            is.numeric(month))

  if (city == "Oslo") {
    get_trips_data_oslo(year, month)
  } else if (city == "Bergen") {
    get_trips_data_bergen(year, month)
  } else if (city == "Trondheim") {
    get_trips_data_trondheim(year, month)
  } else {
    warning("Choose either 'Oslo', 'Bergen', or 'Trondheim' for the `city` argument.")
  }

}
