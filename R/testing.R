# GET request at 17:00

stations <- httr::GET("http://gbfs.urbansharing.com/bergenbysykkel.no/station_information.json",
                      httr::add_headers("Client-Identifier" = "imang-powerbiofficeview"))

stations_content <-
  stations %>%
  httr::content("text") %>%
  jsonlite::fromJSON()

stations_df <- stations_content$data$stations

stations_data <- list(stations_df = stations_df,
                      last_updated = as.POSIXct(stations_content$last_updated,
                                                origin = "1970-01-01",
                                                tz = Sys.timezone()))

# GET request at 17:48

avail <- httr::GET("http://gbfs.urbansharing.com/bergenbysykkel.no/station_status.json",
                   add_headers("Client-Identifier" = "imang-powerbiofficeview"))

avail_content <-
  avail %>%
  httr::content("text") %>%
  jsonlite::fromJSON()

avail_df <-
  avail_content$data$stations %>%
  mutate(last_reported = as.POSIXct(last_reported, origin = "1970-01-01", tz = "Europe/Oslo"))

library(dplyr)

test2_df_mod <- test2_df %>%
  mutate(last_reported_fix = as.POSIXct(last_reported, origin = "1970-01-01", tz = "Europe/Oslo"))
