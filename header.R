library(lubridate)
library(ggthemes)
library(scales)
library(ggplot2)
library(magrittr)
library(plyr)
library(dplyr)
library(plotrix)
library(sp)
library(rgdal)
library(reshape2)
library(readr)
library(rgeos)
library(ggrepel)
library(Hmisc)
library(nlme)
library(lme4)
library(lmerTest)
library(lsmeans)
library(knitr)

## function to convert projection
convert_proj <- function(data, data.x = "Long", data.y = "Lat", data.CRS = "+init=epsg:4326", new.CRS = "+init=epsg:3005") {
  
  data %<>% as.data.frame()
  
  sp::coordinates(data) <- c(data.x, data.y)
  proj4string(data) <- sp::CRS(data.CRS)
  sp::spTransform(data, new.CRS)
}

tz_data = 'PST8PDT'

sp = c('Ancient Murrelet', "Cassin's Auklet", "Fork-Tailed Storm-Petrel", "Leach's Storm-Petrel")

task2a <- 'Describe seabird and songbird data coverage in space and time with appropriate plots.'

task2b <- 'If possible (not mandatory), describe the seasonal variation in songbird vocalization rates, overall, and by selected species (SEASON = Early, Mid, Late). This is meant to be an exploratory analyses, not a polished result.'

task2c <- 'Describe the annual and nightly variation in seabird vocalization (proportion of recordings with presence, and proportion of recordings with presence of multiple individuals), by species (appropriate figures such as box plots).'

task2d <- 'Examine effects of year, rat status, island on seabird vocalization metrics as agreed upon, and departure time.'

task2e <- 'Test whether restoration resulted in an increase in seabird vocalization metrics, by species (abundance), using BACI design.'

task2f <- 'Test whether restoration resulted in a lengthened seabird departure time from rat-infested islands.'
