bysykkel_control_input <- function(year, month, city) {

  if (!is.numeric(year)) {

    stop(glue::glue("You have input `year` as a `{class(year)}`, ",
                    "which is not of data type `numeric`. Please input ",
                    "`year` as a numeric variable."))

  } else if (!is.numeric(month)) {

    stop(glue::glue("You have input `month` as a `{class(month)}`, ",
                    "which is not of data type `numeric`. Please input ",
                    "`month` as a numeric variable."))

  } else if (!is.character(city)) {

    stop(glue::glue("You have input `city` as a `{class(city)}`, ",
                    "which is not of data type `character`. Please input ",
                    "`city` as a character string."))

  } else if (!(city %in% c("Oslo", "Bergen", "Trondheim", "OsloW"))) {

    stop(glue::glue("You have input \"{city}\" for the `city` argument, ",
                    "which is invalid. `city` must be either \"Oslo\", ",
                    "\"Bergen\", \"Trondheim\", or \"OsloW\"."))

  }
}
