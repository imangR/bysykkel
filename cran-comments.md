## Resubmission
This is a resubmission. In this version I have:

* Changed the version number to 0.2.3 to 0.3.1

* Removed function interface to get data from the Oslo Winter Bike service,
since it has been shut down

* Updated all function help menus to account for the removal
of the interface to Oslo Winter Bike Service

* Updated package DESCRIPTION version, text, and URL to Github account because
of a change in the username

* Updated `dl_trips_data()` to allow for downloads of bike trip data in
CSV or JSON format by specifying the `filetype` argument

* Fixed a bug where `dl_trips_data()` would assign wrong filename for 
files downloaded from Trondheim Bysykkel

* Added automated testing that runs locally

## Test environments
* local Windows install, R 3.6.3
* local OS X install, R 3.6.3
* local Ubuntu 18.04.4 LTS install, R 3.6.3

## R CMD check results
There were no ERRORs, WARNINGs or NOTEs. 

## Downstream dependencies
There are no downstream dependencies.
