source('header.R')
source('data-clean.R')

  ## create phase 2 time intervals to find max overlap
  load('data/sea-clean.Rda')
  load('data/voc-year-means.Rda')
  load('data/voc-night-means.Rda')
  
  seabaci <- select(sea, island, siteID, year, hrmin, night, rats, exp, species, pa, pa2, phase1, phase2)
  
  # set year to arbitrary (2010) to enable filter by within-season data and time
  seabaci$night.ny <- seabaci$night
  year(seabaci$night.ny) <- 2010
  
  # filter by date sampling window for each species
  anmu.strt <- "2010-05-11"
  anmu.end <- "2010-05-24"
  caau.strt <- "2010-05-01"
  caau.end <- "2010-05-14"
  ftsp.strt <- "2010-05-01"
  ftsp.end <- "2010-05-14"
  
  seabaci %<>% filter(night.ny >= as.Date(anmu.strt) & night.ny <= as.Date(anmu.end) & species == sp[1] |
                     night.ny >= as.Date(caau.strt) & night.ny <= as.Date(caau.end) & species == sp[2] | ## second peak in vocal activity
                     night.ny >= as.Date(ftsp.strt) & night.ny <= as.Date(ftsp.end) & species == sp[3]) 
  
  
  # filter by night samping window for each species
  seabaci %<>% filter(hour(night) >= 0 & hour(night) <=3  & species == sp[1] |
                  hour(night) >= 0 & hour(night) <=3  & species == sp[3] |
                  hour(night) >= 1 & hour(night) <=4  & species == sp[2] 
                  )
  # create period variable
  seabaci %<>% mutate(PeriodPh2 = ifelse(year<= 2013, 'Before', 'After'),
                      PeriodPh1 = ifelse(year<= 2011, 'Before', 'After'))
  
  # ensure factors and ordered factors
  seabaci %<>% mutate(island = factor(island),
                     site = factor(siteID),
                     yearf = ordered(year, levels = c(2010, 2011, 2012, 2013, 2014, 2015)),
                     rats = ordered(rats, levels = c('Absent', 'Reduced', 'Present')),
                     exp = ordered(exp, levels = c('Control', 'Impact')),
                     PeriodPh1 = ordered(PeriodPh1, levels = c('Before', 'After')),
                     PeriodPh2 = ordered(PeriodPh2, levels = c('Before', 'After')),
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
  