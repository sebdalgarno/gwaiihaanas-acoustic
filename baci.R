source('header.R')

# phase 2 - use siteIDs with data in 2012 & 2013 & 2014 & 2015
# NBR20_ALDE, 
ph2cov <- ddply(sea, .(siteID, year(DateTime)), summarise, sum = sum(dum))
ph2 <- filter(sea, year(DateTime) == 2012 & year(DateTime) == 2013 & year(DateTime) == 2014 & year(DateTime) == 2015)



t