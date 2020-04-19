# bysykkel 0.3.1

## General

* The Oslo Winter Bike service has been shut down. Hence, the interface
to this service has been removed from `fread_trips_data()`, `read_trips_data()`, and 
`dl_trips_data()`.

* Updated object documentation where the URL to the Oslo Winter Bike service 
has been removed.

* Automated testing has been added that will hopefully detect if there are any
breaking changes to the services which the bysykkel functions rely on.

* `fread_trips_data()`, `read_trips_data()`, and `dl_trips_data()` should output
a more informative error message if the user provides an invalid city name.

# bysykkel 0.2.3

## General

* Oslo City Bike updated their open data pages, including the URLs to access
the API service and to download historical bike trip data, which broke all
`dl_trips_data()` and `get_api_data()` that would interact with these pages.
These functions have been repaired.

* Added package dependency to `lubridate`.

* Removed package dependency to `magrittr`.

* Added `bysykkel_control_*` functions to improve error handling, and error
messages, so that it is (hopefully) more clear to the user what caused an 
error.

* Updated the object documentation for all functions.

* Updated README.md

## Minor Changes

* Removed `magrittr` as a dependency since the package is not used.

## Minor changes

### fread_trips_data()
* The function can now read historical bike trip data from Oslo City Bike.
* Moved the `data.table` package from "Imports" to "Suggests" such that
it will not automatically be installed with the `bysykkel` package.
  * As a consequence of this, `fread_trips_data()` will check if `data.table`
  is installed before running. If it is not installed, the user will receive
  a stop message.

### read_trips_data()
* The function can now read historical bike trip data from Oslo City Bike.

### dl_trips_data()
* For legacy data from Oslo City Bike, the function will now retrieve the 
CSV-file in the ZIP-file. In other words, to the user, the function downloads
the CSV-file of interest, and not the ZIP-file.

### get_api_data()
* The function is repaired so that it can read realtime data from 
Oslo City Bike's API service.
* The function can now retrieve system information with `data = "system"`.

## Bug fixes

### fread_trips_data()

* Repaired the function so that it correctly uses the URL to read CSV-file
that contains requested trip records data.

### read_trips_data()

* Fixed the function so that it properly reads special Norwegian characters
that appear in the bike data.

# bysykkel 0.1.0

## Major
Package release. Functions released with the package are

* `dl_trips_data()`
* `fread_trips_data()`
* `get_api_data()`
* `read_trips_data()`
