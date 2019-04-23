bysykkel_control_input <- function(year, month, city) {

# Control `year` ----------------------------------------------------------

  if (!is.numeric(year)) {

    message <-
      glue::glue("`year` must be of type `numeric`. You have input `year` ",
                 "as a `{class(year)}`.")

    stop(message, call. = FALSE)

  }

  if (length(year) > 1) {

    message <-
      glue::glue("`year` must be of length 1. You have input `year` as a ",
                 "vector of length {length(year)}.")

    stop(message, call. = FALSE)

  }

# Control `month` ---------------------------------------------------------

  if (!is.numeric(month)) {

    message <-
      glue::glue("`month` must be of type `numeric`. You have input `month` ",
                 "as a `{class(month)}`.")

    stop(message, call. = FALSE)

  }

  if (length(month) > 1) {

    message <-
      glue::glue("`month` must be of length 1. You have input `month` as a ",
                 "vector of length {length(month)}.")

    stop(message, call. = FALSE)

  }

# Control `city` ----------------------------------------------------------

  if (!is.character(city)) {

    message <-
      glue::glue("`city` must of type `character`. You have input `month` as a ",
                 "`{class(city)}`.")

    stop(message, call. = FALSE)

  }

  if (length(city) > 1) {

    message <-
      glue::glue("`city` must be of length 1. You have input `city` as a ",
                 "vector of length {length(city)}.")

    stop(message, call. = FALSE)

  }

  if (!(city %in% c("Oslo", "Bergen", "Trondheim", "OsloW"))) {

    message <-
      glue::glue("`city` must be either \"Oslo\", \"Bergen\", \"Trondheim\", ",
                 " or \"OsloW\". You have input \"{city}\" for the `city` ",
                 "argument.")

    stop(message, call. = FALSE)

  }

}
