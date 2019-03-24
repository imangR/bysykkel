# bysykkel 0.1.1.0

## Minor

### `fread_trips_data()`

* Removed call to `print()` in the function. `print()` was used to inform the
user for which year, month, and city the user requested to download
trip records data. The function is redundant, and the information is now
printed with `glue()`.

### `dl_trips_data()`

* Removed call to `print()` in the function. The change is equivalent to the 
case above with `print()` replaced with `glue()` in `fread_trips_data()`.

## Patches

### `fread_trips_data()`

* Repaired function so that it correctly uses URL to read CSV-file that 
contains requested trip records data.

# bysykkel 0.1.0.0

## Major
Package release. Functions released with the package are

* `dl_trips_data()`
* `fread_trips_data()`
* `get_api_data()`
* `read_trips_data()`
