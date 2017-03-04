source('header.R')
lapply(list.files(path = 'data', pattern = "*.Rda", full.names = TRUE), load, .GlobalEnv)

  ## create phase 2 time intervals to find max overlap
  seabaci <- select(sea, island, siteID, year, hrmin, night, rats, exp, species, pa, pa2, phase1, phase2)
  
  # night sampling window for each species
  n.window <- ddply(filter(voc.night.m, response == 'p(presence)', !is.na(max.3)), .(species), summarise, 
                    time.start =  first(hrmin) - minutes(90), time.end =  first(hrmin) + minutes(90))
  
  # seasonal sampling window for each species
  y.window <- ddply(filter(voc.allyear.m, response == 'p(presence)', !is.na(max.14)), .(species), summarise, 
                    date.start =  first(ynight) - days(7), date.end =  first(ynight) + days(7))
  
  
  # set year to arbitrary (2010) to enable filter by within-season data and time
  seabaci$night.ny <- seabaci$night
  year(seabaci$night.ny) <- 2010
  
  # filter by date sampling window for each species
  seabaci %<>% filter(yday(night) >= yday(y.window[1,2]) &  yday(night) <= yday(y.window[1,3]) & species == sp[1] |
                      yday(night) >= yday(y.window[2,2]) &  yday(night) <= yday(y.window[2,3]) & species == sp[2] | 
                      yday(night) >= yday(y.window[3,2]) &  yday(night) <= yday(y.window[3,3]) & species == sp[3])
  
  
  # filter by night samping window for each species
  seabaci %<>% filter(hour(night) >= hour(n.window[1,2]) & hour(night) <= hour(n.window[1,3])  & species == sp[1] |
                      hour(night) >= hour(n.window[2,2]) & hour(night) <= hour(n.window[2,3])  & species == sp[2] |
                      hour(night) >= hour(n.window[3,2]) & hour(night) <= hour(n.window[3,3])  & species == sp[3]) 

  
  # create period variable
  seabaci %<>% mutate(PeriodPh2 = ifelse(year<= 2013, 'Before', 'After'),
                      PeriodPh1 = ifelse(year<= 2011, 'Before', 'After'))
  
  # ensure factors and ordered factors
  seabaci %<>% mutate(island = factor(island),
                      site = factor(siteID),
                      yearf = ordered(year, levels = c(2010, 2011, 2012, 2013, 2014, 2015)),
                      rats = factor(rats),
                      exp = factor(exp),
                      PeriodPh1 = factor(PeriodPh1),
                      PeriodPh2 = factor(PeriodPh2),
                      ynight = floor_date(night, 'day')
  )
  
  ### summarize proportions by site
  baci <- ddply(seabaci, .(species, island, site, year, phase1, phase2), summarise, yearf = first(yearf), exp = first(exp), PeriodPh1 = first(PeriodPh1),
                    PeriodPh2 = first(PeriodPh2),
                         trials = length(siteID), success1 = sum(pa), success2 = sum(pa2)) %>%
    
    mutate('p(presence)' = success1/trials,
           'p(presence>1)' = success2/trials)
  
  
  ### melt prop so same df
  baci %<>% melt(measure.vars = c('p(presence)', 'p(presence>1)'), variable.name = 'propType', value.name = 'prop' )
  
  # empirical logit transform
  baci %<>% mutate(prop = binomTools::empLogit(prop))
  
  ### means by island
  baci.island <- ddply(baci, .(species, year, yearf, island, exp, propType, PeriodPh1, PeriodPh2, phase1, phase2), function(x){
    n <- nrow(x)
    mean.prop <- mean(x$prop, na.rm=TRUE)
    sd.prop   <- sd(  x$prop, na.rm=TRUE)
    res <- data.frame(n, mean.prop, sd.prop)
  })
  