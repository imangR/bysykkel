# bysykkel 0.1.1

## Patches

### fread_trips_data()

* Moved the `data.table` package from "Imports" to "Suggests" such that
it will not automatically be installed with the `bysykkel` package.
  * As a consequence of this, `fread_trips_data()` will check if `data.table`
  is installed before running. If it is not installed, the user will receive
  a stop message.

* Repaired the function such that it correctly uses URL to read CSV-file
that contains requested trip records data.

* Updated the object documentation.

### read_trips_data()

* Repaired the function so that it properly reads special Norwegian characters
in the Norwegian language that appear in bike data.

* Updated the object documentation.

### dl_trips_data()

* Updated the object documentation.

# bysykkel 0.1.0

## Major
Package release. Functions released with the package are

* `dl_trips_data()`
* `fread_trips_data()`
* `get_api_data()`
* `read_trips_data()`
