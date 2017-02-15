source('header.R')

  ## create phase 2 time intervals to find max overlap
  load('data/sea-clean.Rda')
  sea %<>% mutate(hour.min = paste(hour(DateTime), minute(DateTime), sep=":"),
                  hourmin = parse_date_time(hour.min, 'HM'),
                  hrmin = as.POSIXct(ifelse(hour(hourmin) >= 0 & hour(hourmin) < 06, hourmin + ddays(1), hourmin), 
                                     origin = "1970-01-01", tz = tz_data),
                  hour.min = NULL,
                  hourmin = NULL,
                  ynight = as.Date(paste(2000, lubridate::yday(night), 1, sep = '-'),' %Y-%j-%H'), # note that year is arbitrary
                  year = year(night),
                  week = as.Date(paste(2000, lubridate::week(night), 5, sep = '-'),' %Y-%U-%u') # note that year is arbitrary
  )
  
  seaph2.pre <- filter(sea, phase2 == 1) %>%
    
    select(island, siteID, year, night, rats, exp, species, pa, pa2)
  
  # find time interval overlap between replicates
  seaph2.int <- arrange(seaph2.pre, siteID, night) %>%
    
    group_by(siteID, year) %>%
    
    summarise(start = first(night), 
              end = last(night))  
  
  # change year to 2010 to allow within-season comparison regardless of year
  year(seaph2.int$start) <- 2010
  year(seaph2.int$end) <- 2010
  
  seaph2.sampint <- interval(seaph2.int$start, seaph2.int$end, tz = tz_data)
  
  # create analysis interval to test how many replicate:site combinations intersect
  seaph2.analint <- interval(ymd(paste(2010, 05, 01, sep = '-'), tz = tz_data), ymd(paste(2010, 06, 01, sep = '-'), tz = tz_data))
  
  intersect(seaph2.sampint, seaph2.analint)
  
  # filter seaph2 df to include only recordings between May01 and June 15
  seaph2.pre$night.ny <- seaph2.pre$night
  year(seaph2.pre$night.ny) <- 2010
  
  seaph2 <- filter(seaph2.pre, night.ny >= as.Date("2010-05-01") & night.ny <= as.Date("2010-06-15") ) 
  
  # filter out Ramsay replicate NBR22_RAMS because only one year of data (2011)
  seaph2 %<>% filter(siteID != 'NBR22_RAMS')
  
  seaph2 %<>% mutate(period = ifelse(year<= 2013, 'Before', 'After'))
  
  seaph2 %<>% mutate(island = factor(island),
                     siteID = factor(siteID),
                     yearf = ordered(year, levels = c(2011, 2012, 2013, 2014, 2015)),
                     rats = ordered(rats, levels = c('Absent', 'Reduced', 'Present')),
                     exp = factor(exp),
                     period = ordered(period, levels = c('Before', 'After')),
                     ynight = floor_date(night, 'day')
  )
  
  ### anmu baci
  ph2.baci.anmu <- ddply(filter(seaph2, species == sp[1]), .(island, siteID, year), summarise, yearf = first(yearf), exp = first(exp), period = first(period), 
                         trials = length(siteID), success1 = sum(pa), success2 = sum(pa2)) %>%
    
    mutate(prop1 = success1/trials,
           prop2 = success2/trials)
  
  # summary
  mean.anmu <- ddply(ph2.baci.anmu, .(year, yearf, island, exp, period), function(x){
    n <- nrow(x)
    mean.prop <- mean(x$prop1, na.rm=TRUE)
    sd.prop   <- sd(  x$prop1, na.rm=TRUE)
    res <- data.frame(n, mean.prop, sd.prop)
  })
  
  # plot sd vs mean - log transformation not needed
  
  
  # caau baci
  ph2.baci.caau <- ddply(filter(seaph2, species == sp[2]), .(island, siteID, year), summarise, exp = first(exp), period = first(period), 
                         trials = length(siteID), success1 = sum(pa), success2 = sum(pa2)) %>%
    
    mutate(prop1 = success1/trials,
           prop2 = success2/trials)
  
  # ftsp baci
  ph2.baci.ftsp <- ddply(filter(seaph2, species == sp[3]), .(island, siteID, year), summarise, exp = first(exp), period = first(period), 
                         trials = length(siteID), success1 = sum(pa), success2 = sum(pa2)) %>%
    
    mutate(prop1 = success1/trials,
           prop2 = success2/trials)
  

