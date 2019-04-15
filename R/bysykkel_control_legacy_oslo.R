bysykkel_control_legacy_oslo <- function(year, month) {

  days31 <- c(1, 3, 5, 7, 8, 10, 12)
  days30 <- c(4, 6, 9, 11)
  days28 <- 2

  if (month %in% days31) {

    filename <- glue::glue("trips-{year}.{month}.1-{year}.{month}.31.csv")
    return(filename)

  } else if (month %in% days30) {

    filename <- glue::glue("trips-{year}.{month}.1-{year}.{month}.30.csv")
    return(filename)

  } else if (month %in% days28) {

    filename <- glue::glue("trips-{year}.{month}.1-{year}.{month}.28.csv")
    return(filename)

  }

}
