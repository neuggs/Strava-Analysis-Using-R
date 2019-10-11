library(httr)
library(httpuv)
library(jsonlite)
library(xlsx)

# The following come from Strava. Here's a nice tutorial on how to setup the Strava API
# for use with applications.
# https://medium.com/@annthurium/getting-started-with-the-strava-api-a-tutorial-f3909496cd2d
# 
# Note that the blanks and '*' are replaced by characters from Strava.

access_token <- ''
client_secret <- ''
client_id <- '*****'

# This first step creates the object used to connect to Strava.
my_app <- oauth_app("strava",
                    key = client_id,
                    secret = client_secret)

# This next step communicates with Strava and a browser window will appear asking for authorization.
# When you authorize, a URL is returned.
my_endpoint <- oauth_endpoint(
  request = NULL,
  authorize = "https://www.strava.com/oauth/authorize",
  access = "https://www.strava.com/oauth/token"
)

# The oauth_token is the key here. Get it from the the endpoint.
oauth_token <- oauth2.0_token(my_endpoint, my_app, scope = "activity:read_all",  
                              type = NULL, use_oob = FALSE, as_header = FALSE,   
                              use_basic_auth = FALSE, cache = FALSE)

# At this point, you're connected and can make any call you want to Strava.
# HOwever, Strava normally expects pages (like a web site or mobile site) and returns
# data in a pages construct, with up to 200 activities per page. If you have more
# than 200 activities, you'll have to go through each page (as an adjusted URL in a loop).
# That's what the following code does.
all_data <- NULL

x <- 1
for(page_no in 1:15) {
  page_no = paste('page=', page_no, sep="")
  my_url <- paste("https://www.strava.com/api/v3/athlete/activities?access_token=", 
                oauth_access_token,"&per_page=200&", page_no, sep="")
  stravaData <- fromJSON(my_url, flatten = FALSE)
  stripped <- stravaData[c(
    'name',
    'distance',
    'moving_time',
    'elapsed_time',
    'total_elevation_gain',
    "type",
    "start_date",
    "trainer",
    "manual",
    "gear_id",
    "average_speed",
    "max_speed",
    "average_watts",
    "average_heartrate",
    "max_heartrate")]
  stripped_df <- as.data.frame(stripped)
  if(x > 1) {
    all_data <- rbind(all_data, stripped_df[1:200,])
  } else {
    all_data <- stripped_df
  }

  x = x + 1
}

# With all the data stored, save it to an Excel file. This is the file the
# Jupyter Notebook starts with.
write.xlsx(all_data, file = 'all_data.xlsx', 
           col.names = TRUE, row.names = TRUE, showNA=FALSE)
