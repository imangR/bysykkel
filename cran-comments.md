## Resubmission
This is a resubmission. In this version I have:

* Shortened the DESCRIPTION title

* Improved the DESCRIPTION description of the package

* Updated README.md

* Moved "data.table" from "Imports" to "Suggests" in DESCRIPTION

* Removed "magrittr" from "Imports"

* Removed web references to each city bike website in Norway in DESCRIPTION
description because I think it made the description ugly. To compensate, I 
have added web references to each City Bike website in the object 
documentation for each function, and also in README.md, which I hope is
acceptable.
  * The web reference for the license, NLOD 2.0, stays.

* Changed the version number to 0.1.1 from 0.2.1 as I have fixed some
bugs, and made minor changes to the package as mentioned above.
  * The changes do not break any existing code for R users who have
  already installed the package.
  
* Repaired bysykkel functions that broke due to website and API changes
at Oslo City Bike.

* Added `bysykkel_control_*` functions to better detect errors, and
provide better more clear error messages that will (hopefully) better 
inform the user of what errors were made.

## Test environments
* local Windows  install, R 3.5.2
* local OS X install, R 3.5.2

## R CMD check results
There were no ERRORs, WARNINGs or NOTEs. 

## Downstream dependencies
There are no downstream dependencies.
