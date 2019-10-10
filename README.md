# Strava Analysis Using R

This project retrieves and does some basic data science on my Strava data. This can be easily ported to your own data, presuming you want to analyze cycling data (although it's pretty clear how to scrub the data for any activity).

The key element is the `Get_Strava_Data.r` file because it shows how to pull the data out of Strava to begin with. 

# THE PROJECT ISN'T QUITE DONE

# Requirements

In addition to R (I used RStudio as well), you'll need the following libraries installed in R (you can do this with `install.packages("PACKAGE NAME")` inside one of the R files:

* httr
* httpuv
* jsonlite
* xlsx
* broom

## Hints and Tips

You need to use your Strava account information. 
