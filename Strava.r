# Basic script to open the activities excel file and mess with it.
library(xlsx)
library(broom)
library(psych)

library("ggplot2")

# All data
data_types <- c('character', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'character', 
                'character', 'character', 'character', 'character', 'character', 'numeric', 'numeric', 'numeric',
                'numeric', 'numeric', 'numeric')

strava_data <- read.xlsx("./all_data.xlsx", 1, colClasses = data_types, header=TRUE)

# Only ride data
ride_data <- subset(strava_data, type == 'VirtualRide' | type == 'Ride')

assumptions <- function(field_label, data, field, bins) {
  # gg <- ggplot(data, aes(field)) + geom_histogram(bins=bins) + 
  #   stat_function(fun=dnorm, args=list(mean = mean(field, na.rm=TRUE), sd = sd(field, na.rm=TRUE)), 
  #                 color='black', size=1) +
  #   ggtitle(field_label) + xlab(field_label) + ylab('Count')
  gg <- ggplot(data, aes(field)) + geom_histogram()
  print(gg)
  # qq <- qplot(sample=field)
  # print(qq)
  # 
  # d <- describe(field)
  # print(d)
  # 
  # kurtosis <- d$kurtosis
  # if (round(kurtosis, 2) > 0) {
  #   print(paste('Kurtosis is', round(kurtosis, 2),  '. Since it\'s greater than zero, there may be',
  #               'a heavily-tailed distribution. Ideally, this should be zero.'))
  # } else if (round(kurtosis, 2) < 0) {
  #   print(paste('Kurtosis is', round(kurtosis, 2),  '. Since it\'s less than zero, there may be',
  #               'a light-tailed distribution. Ideally, this should be zero.'))
  # } else {
  #   print('The Kurtosis is 0, which indicates a normal distribution.')
  # }
  # 
  # skew <- d$skew
  # if (round(skew, 2) > 0) {
  #   print(paste('Skew is', round(skew, 2),  '. Since it\'s greater than zero, there may be ',
  #               'a pile up of scores on the left of the distribution. Ideally, this should be zero.'))
  # } else if (round(skew, 2) < 0) {
  #   print(paste('Skew is', round(skew, 2),  '. Since it\'s less than zero, there may be ',
  #               'a pile up of scores on the right of the distribution. Ideally, this should be zero.'))
  # } else {
  #   print('The Skew is 0, which indicates a normal distribution.')
  # }
}

a <- assumptions('Average Speed (MPH)', ride_data, ride_data$average_speed_mph, 15)

#a <- assumptions('Distance (Miles)', ride_data, ride_data$distance_mi, 15)
#a <- assumptions('Moving Time (Minutes)', ride_data, ride_data$moving_time, 15)
#a <- assumptions('Elevation Gain (Feet)', ride_data, ride_data$elevation_gain_ft, 15)
#a <- assumptions('Average Power (Watts)', ride_data, ride_data$average_watts, 15)
#a <- assumptions('Average Heart Rate', ride_data, ride_data$average_heartrate, 15)
# a <- assumptions('Average Temperature (Celsius)', ride_data, ride_data$average_temp, 15)
# 

# 
# ggplot(ride_data, aes(x = distance_mi, y = avg_speed_mph), color = factor(gear_id)) + 
#          geom_point()
# 
# cor(some_bikes$distance_mi, strava_data$avg_speed_mph)
# 
# # boxplot with just some bikes
# ggplot(data = some_bikes, aes(x = factor(gear_id), y = avg_speed_mph)) +
#          geom_boxplot()
# 
# # Simple lm model - how distance affects speed
# lm_speed_dist_gear_id <- lm(avg_speed_mph ~ distance_mi + factor(gear_id), data = ride_data)
# summary(lm_speed_dist_gear_id)
# lm_speed_dist_gear_id
# 
# # try parallel slopes
# # Augment the model
# augmented_bikes <- augment(lm_speed_dist_gear_id)
# # scatterplot, with color
# lm_plot <- ggplot(augmented_bikes, aes(x = distance_mi, y = avg_speed_mph, color = factor.gear_id.)) + 
#   geom_point()
# # single call to geom_line()
# lm_plot + 
#   geom_line(aes(y = .fitted))
# lm_plot.Show()
# 
# summary(logistic_model)
# model_chi <- logistic_model.1$null.deviance - logistic_model.1$deviance


