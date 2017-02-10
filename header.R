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

## function to convert projection
convert_proj <- function(data, data.x = "Long", data.y = "Lat", data.CRS = "+init=epsg:4326", new.CRS = "+init=epsg:3005") {
  
  data %<>% as.data.frame()
  
  sp::coordinates(data) <- c(data.x, data.y)
  proj4string(data) <- sp::CRS(data.CRS)
  sp::spTransform(data, new.CRS)
}

