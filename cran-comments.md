## Resubmission
This is a resubmission. In this version I have:

* Shortened the DESCRIPTION title

* Improved the DESCRIPTION description of the package

* Created a vignette for the function. [must be done]

* Updated README.md

* Moved "data.table" from "Imports" to "Suggests" in DESCRIPTION

* Removed web references to each City Bike website in Norway in DESCRIPTION
description because it made the description ugly. 
  * To compensate, I have added web references to each City Bike website in 
  the object documentation for each function, and also in the vignette.
  * The web reference for the license, NLOD 2.0, stays.

* Changed the version number to 0.1.1.0 from 0.1.0.0 as I have fixed some
bugs, and made minor changes to the package as mentioned above.
  * I do not perceive any of the mentioned changes to break
  any existing code for R users who have already installed
  the package.

## Test environments
* local Windows  install, R 3.5.2
* local OS X install, R 3.5.2

## R CMD check results
There were no ERRORs, WARNINGs or NOTEs. 

## Downstream dependencies
There are no downstream dependencies.
