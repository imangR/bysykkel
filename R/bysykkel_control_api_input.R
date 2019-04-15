bysykkel_control_api_input <- function(client_id, data, city, return_df) {

  if (!is.character(client_id)) {

    stop(glue::glue("You have input `client_id` as a `{class(client_id)}`, ",
                    "which is not of data type `character`. Please input ",
                    "`client_id` as a character string."))

  } else if (!is.character(data)) {

    stop(glue::glue("You have input `data` as a `{class(data)}`, ",
                    "which is not of data type `character`. Please input ",
                    "`data` as a character string."))

  } else if (!(data %in% c("availability", "stations", "system"))) {

    stop(glue::glue("You have input \"{data}\" for the `data` argument, ",
                    "which is invalid. `data` must be either ",
                    "\"availability\", \"stations\", or \"system\"."))

  } else if (!is.character(city)) {

    stop(glue::glue("You have input `city` as a `{class(city)}`, ",
                    "which is not of data type `character`. Please input ",
                    "`city` as a character string."))

  } else if (!(city %in% c("Oslo", "Bergen", "Trondheim", "OsloW"))) {

    stop(glue::glue("You have input \"{city}\" for the `city` argument, ",
                    "which is invalid. `city` must be either \"Oslo\", ",
                    "\"Bergen\", \"Trondheim\", or \"OsloW\"."))

  } else if (!is.logical(return_df)) {

    stop(glue::glue("You have input `return_df` as a `{class(return_df)}`, ",
                    "which is not of data type `logical`. Please input ",
                    "`return_df` as `TRUE` or `FALSE`."))

  }

}
