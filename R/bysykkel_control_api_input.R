bysykkel_control_api_input <- function(client_id, data, city, return_df) {

  # Control `client_id` -----------------------------------------------------

  if (!is.character(client_id)) {

    message <-
      glue::glue("`client_id` must be of type `character`. You have input ",
                 "`client_id` as a `{class(client_id)}`.")

    stop(message, call. = FALSE)

  }

  if (length(client_id) > 1) {

    message <-
      glue::glue("`client_id` must be of length 1. You have input ",
                 "`client_id` as a vector of length {length(client_id)}.")

    stop(message, call. = FALSE)

  }

  # Control `data` ----------------------------------------------------------

  if (!is.character(data)) {

    message <-
      glue::glue("`data` must be of type `character`. You have input ",
                 "`data` as a `{class(data)}`.")

    stop(message, call. = FALSE)

  }

  if (length(data) > 1) {

    message <-
      glue::glue("`data` must be of length 1. You have input ",
                 "`data` as a vector of length {length(data)}.")

    stop(message, call. = FALSE)

  }

  if (!(data %in% c("availability", "stations", "system"))) {

    message <-
      glue::glue("You have input \"{data}\" for the `data` argument, ",
                 "which is invalid. `data` must be either ",
                 "\"availability\", \"stations\", or \"system\".")

    stop(message, call. = FALSE)

  }

# Control `city` ----------------------------------------------------------

  if (!is.character(city)) {

    message <-
      glue::glue("`city` must be of type `character`. You have input ",
                 "`city` as a `{class(city)}`.")

    stop(message, call. = FALSE)

  }

  if (!(city %in% c("Oslo", "Bergen", "Trondheim", "OsloW"))) {

    message <-
      glue::glue("You have input \"{city}\" for the `city` argument, ",
                 "which is invalid. `city` must be either \"Oslo\", ",
                 "\"Bergen\", \"Trondheim\", or \"OsloW\".")

    stop(message, call. = FALSE)

  }

  if (length(city) > 1) {

    message <-
      glue::glue("`city` must be of length 1. You have input ",
                 "`city` as a vector of length {length(city)}.")

    stop(message, call. = FALSE)

  }

# Control `return_df` -----------------------------------------------------

  if (!is.logical(return_df) || identical(return_df, NA)) {

    message <-
      glue::glue("`return_df` must be TRUE/FALSE of type `logical`. You ",
                 "have input {return_df} of type ",
                 "`{class(return_df)}`.")

    stop(message, call. = FALSE)

  }

  if (length(return_df) > 1) {

    message <-
      glue::glue("`return_df` must be of length 1. You have input ",
                 "`return_df` as a vector of length {length(return_df)}.")

    stop(message, call. = FALSE)

  }

}
