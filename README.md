
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bysykkel <img src='https://res.cloudinary.com/climb/image/upload/c_fill,f_auto,h_800,q_80/v1498809170/ximadvmr9aolkqkaqgmf' align="right" height="100" />

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/bysykkel)](https://cran.r-project.org/package=bysykkel)
<!-- badges: end -->

## Overview

bysykkel provides functions to easily process Norwegian city bike data,
either by reading it directly to R or downloading it to your R session’s
working directory.

  - `read_trips_data()` reads bike trip data to R as a dataframe.
  - `fread_trips_data()` fast reads bike trip data to R as a dataframe
    by utilizing `fread()` from the data.table package.
  - `dl_trips_data()` downloads bike trip data to your working directory
    as a CSV-file.
  - `get_api_data()` gets realtime data from the city bike API service.

bysykkel lets you, the user, focus on data exploration, visualization,
statistical analysis, and building machine learning models on Norwegian
city bike data, by simplifying the task of getting the data. Indeed, the
purpose of bysykkel is to minimize time spent on getting Norwegian city
bike data.

## Installation

You can install the released version of bysykkel from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("bysykkel")
```

### Development version

Alternatively, you can install a development version of bysykkel from
GitHub to get bug fixes, or new features, before the package is released
on CRAN. To install the development version, you can use devtools to
install bysykkel from GitHub.

``` r
# install.packages("devtools")
devtools::install_github("PersianCatsLikeToMeow/bysykkel")
```

## Cheatsheet

<a href="https://github.com/rstudio/cheatsheets/blob/master/data-transformation.pdf"><img src="https://raw.githubusercontent.com/rstudio/cheatsheets/master/pngs/thumbnails/data-transformation-cheatsheet-thumbs.png" width="630" height="252"/></a>

## Usage

``` r
library(dplyr)
starwars %>%
  filter(species == "Droid")
#> # A tibble: 5 x 13
#>   name  height  mass hair_color skin_color eye_color birth_year gender
#>   <chr>  <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> 
#> 1 C-3PO    167    75 <NA>       gold       yellow           112 <NA>  
#> 2 R2-D2     96    32 <NA>       white, bl~ red               33 <NA>  
#> 3 R5-D4     97    32 <NA>       white, red red               NA <NA>  
#> 4 IG-88    200   140 none       metal      red               15 none  
#> 5 BB8       NA    NA none       none       black             NA none  
#> # ... with 5 more variables: homeworld <chr>, species <chr>, films <list>,
#> #   vehicles <list>, starships <list>
starwars %>%
  select(name, ends_with("color"))
#> # A tibble: 87 x 4
#>   name           hair_color skin_color  eye_color
#>   <chr>          <chr>      <chr>       <chr>    
#> 1 Luke Skywalker blond      fair        blue     
#> 2 C-3PO          <NA>       gold        yellow   
#> 3 R2-D2          <NA>       white, blue red      
#> 4 Darth Vader    none       white       yellow   
#> 5 Leia Organa    brown      light       brown    
#> # ... with 82 more rows
starwars %>%
  mutate(name, bmi = mass / ((height / 100)  ^ 2)) %>%
  select(name:mass, bmi)
#> # A tibble: 87 x 4
#>   name           height  mass   bmi
#>   <chr>           <int> <dbl> <dbl>
#> 1 Luke Skywalker    172    77  26.0
#> 2 C-3PO             167    75  26.9
#> 3 R2-D2              96    32  34.7
#> 4 Darth Vader       202   136  33.3
#> 5 Leia Organa       150    49  21.8
#> # ... with 82 more rows
starwars %>%
  arrange(desc(mass))
#> # A tibble: 87 x 13
#>   name  height  mass hair_color skin_color eye_color birth_year gender
#>   <chr>  <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> 
#> 1 Jabb~    175  1358 <NA>       green-tan~ orange         600   herma~
#> 2 Grie~    216   159 none       brown, wh~ green, y~       NA   male  
#> 3 IG-88    200   140 none       metal      red             15   none  
#> 4 Dart~    202   136 none       white      yellow          41.9 male  
#> 5 Tarf~    234   136 brown      brown      blue            NA   male  
#> # ... with 82 more rows, and 5 more variables: homeworld <chr>,
#> #   species <chr>, films <list>, vehicles <list>, starships <list>
starwars %>%
  group_by(species) %>%
  summarise(
    n = n(),
    mass = mean(mass, na.rm = TRUE)
  ) %>%
  filter(n > 1,
         mass > 50)
#> # A tibble: 8 x 3
#>   species      n  mass
#>   <chr>    <int> <dbl>
#> 1 Droid        5  69.8
#> 2 Gungan       3  74  
#> 3 Human       35  82.8
#> 4 Kaminoan     2  88  
#> 5 Mirialan     2  53.1
#> # ... with 3 more rows
```

## Getting help

If you encounter a clear bug, please file a minimal reproducible example
on [github](https://github.com/tidyverse/dplyr/issues). For questions
and other discussion, please use
[community.rstudio.com](https://community.rstudio.com/), or the
[manipulatr mailing list](https://groups.google.com/group/manipulatr).

-----

Please note that this project is released with a [Contributor Code of
Conduct](.github/CODE_OF_CONDUCT.md). By participating in this project
you agree to abide by its terms.
