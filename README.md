# Strava Analysis Using R

This project retrieves and does some basic data science on my Strava data. This can be easily ported to your own data, presuming you want to analyze cycling data (although it's pretty clear how to scrub the data for any activity).

The key element is the `Get_Strava_Data.r` file because it shows how to pull the data out of Strava to begin with. 

# Requirements

In addition to R (I used RStudio as well), you'll need the following libraries installed in R (you can do this with `install.packages("PACKAGE NAME")` inside one of the R files:

* httr
* httpuv
* jsonlite
* xlsx
* broom

## To Use

There are two main parts to this project:
1. Getting the Strava data - ` Get_Strava_data.r`. There's additional instruction on setting up Strava within that file, which is where you pull the data.
2. `working_with_strava_r.Rmd` - this produced the `.pdf` file using R Markdown. It too contains further documentation. 
