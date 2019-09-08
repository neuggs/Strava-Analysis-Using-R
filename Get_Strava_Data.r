library(httr)
library(httpuv)
library(jsonlite)
library(xlsx)

athlete_id <- '******'
access_token <- ''
client_secret <- ''
client_id <- '*****'

my_app <- oauth_app("strava",
                    key = client_id,
                    secret = client_secret)

my_endpoint <- oauth_endpoint(
  request = NULL,
  authorize = "https://www.strava.com/oauth/authorize",
  access = "https://www.strava.com/oauth/token"
)

oauth_token <- oauth2.0_token(my_endpoint, my_app, scope = "activity:read_all",  
                              type = NULL, use_oob = FALSE, as_header = FALSE,   
                              use_basic_auth = FALSE, cache = FALSE)

creds <- oauth_token[['credentials']]
oauth_access_token <- creds['access_token']
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

write.xlsx(all_data, file = 'all_data.xlsx', 
           col.names = TRUE, row.names = TRUE, showNA=FALSE)
