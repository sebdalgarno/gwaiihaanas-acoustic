library(plyr)
library(sp)
library(ggplot2)
library(rgdal)
library(magrittr)
library(dplyr)
library(lubridate)
library(reshape2)
library(HGfetch)
library(Hmisc)

# make new datetime category for hour:minute
load(file = 'data/sea-clean.Rda')
sea %<>% mutate(dum = 1,
                hour.min = paste(hour(DateTime), minute(DateTime), sep=":"),
                hourmin = parse_date_time(hour.min, 'HM'),
                hrmin = as.POSIXct(ifelse(hour(hourmin) >= 0 & hour(hourmin) < 06, hourmin + ddays(1), hourmin), 
                                   origin = "1970-01-01", tz = "UTC"),
                hour.min = NULL,
                hourmin = NULL
                )

               
### include only ARUs with >10 detections for each species
sitedet <- filter(plyr::ddply(sea, .(species, siteID), summarise, det = sum(pa), det2 = sum(pa2)), det >100) %>%
  mutate(sparu = paste0(species, siteID))

# filter main data set, including only matching Species and siteID as above
seavoc <- mutate(sea, sparu = paste0(species, siteID)) %>% filter(sparu %in% sitedet$sparu) %>% mutate(sparu = NULL)
# check
tmp <- ddply(seavoc, .(species, siteID), dplyr::summarise, sum = sum(dum))
tmp <- ddply(sea, .(species, siteID), dplyr::summarise, sum = sum(dum))
rm(tmp)


# calculate nightly vocalization rates
voc.night <- ddply(seavoc, .(species, siteID, hrmin), dplyr::summarize, trials = sum(dum), success1 = sum(pa), success2 = sum(pa2))

# confidence intervals
voc.night %<>% mutate(prop1 = binconf(success1, trials)[,1],
                      lower1 = binconf(success1, trials)[,2],
                      upper1 = binconf(success1, trials)[,3],
                      prop2 = binconf(success2, trials)[,1],
                      lower2 = binconf(success2, trials)[,2],
                      upper2 = binconf(success2, trials)[,3])

# coverage
voc.night.cov <- ddply(seavoc, .(species, hrmin), dplyr::summarize, sites = sum(length(unique(siteID))), recordings = sum(dum))


### seasonal vocalization rates
# make new datetime category
seavoc %<>% mutate(yday = yday(night),
                week = week(DateTime),
                year = year(DateTime))
# calc proportion
voc.allyear <- ddply(seavoc, .(species, siteID, week), dplyr::summarize, trials = sum(dum), success1 = sum(pa), success2 = sum(pa2), DateTime = first(DateTime))
voc.byyear <- ddply(seavoc, .(species, siteID, week, year), dplyr::summarize, trials = sum(dum), success1 = sum(pa), success2 = sum(pa2), DateTime = first(DateTime))

voc.allyear$weekDate <- as.Date(voc.allyear$week, origin = "1970-01-01")
# confidence intervals
voc.allyear %<>% mutate(prop1 = binconf(success1, trials)[,1],
                      lower1 = binconf(success1, trials)[,2],
                      upper1 = binconf(success1, trials)[,3],
                     prop2 = binconf(success2, trials)[,1],
                     lower2 = binconf(success2, trials)[,2],
                     upper2 = binconf(success2, trials)[,3])
voc.byyear %<>% mutate(prop1 = binconf(success1, trials)[,1],
                        lower1 = binconf(success1, trials)[,2],
                        upper1 = binconf(success1, trials)[,3],
                        prop2 = binconf(success2, trials)[,1],
                        lower2 = binconf(success2, trials)[,2],
                        upper2 = binconf(success2, trials)[,3])

# coverage for all years
voc.allyear.cov <- ddply(seavoc, .(species, week), dplyr::summarize, sites = sum(length(unique(siteID))), recordings = sum(dum))
voc.byyear.cov <- ddply(seavoc, .(species, year, week), dplyr::summarize, sites = sum(length(unique(siteID))), recordings = sum(dum))


# coverage for each year









