source('header.R')
source('data-clean.R')
  
voc_analysis <- function() {
  # make new datetime category for hour:minute
  load(file = 'data/sea-clean.Rda')
  
  ### include only ARUs with >0.001 proprotion detections for each species
  sitedet <- plyr::ddply(sea, .(species, siteID), summarise, success1 = sum(pa), success2 = sum(pa2), trials = length(siteID)) %>%
    
    mutate(prop1 = success1/trials,
           prop2 = success2/trials,
           sparu = paste0(species, siteID)) %>%
    
    filter(prop1 > 0.01)
  
  save(sitedet, file = 'data/site-det.Rda')
  
  seavoc <- mutate(sea, sparu = paste0(species, siteID)) %>% filter(sparu %in% sitedet$sparu) %>% mutate(sparu = NULL)
  
  ### nightly vocalization probability
  # first at sites
  voc.night <- ddply(seavoc, .(species, siteID, hrmin), dplyr::summarize, trials = n(), success1 = sum(pa), success2 = sum(pa2)) 
  tmp <- ddply(seavoc, .(species, siteID, year, hrmin), dplyr::summarize, trials = n(), success1 = sum(pa), success2 = sum(pa2)) 

  # for boxplots
  voc.night.box <- mutate(voc.night, prop1 = success1/trials,
                          prop2 = success2/trials)
  
  save(voc.night.box, file = 'data/voc-night-box.Rda')
  
  # mean of sites
  voc.night.m <- ddply(voc.night, .(species, hrmin), dplyr::summarise, 
                       n = length(hrmin),
                       mean1 = mean(success1/trials),
                       mean2 = mean(success2/trials),
                       lower1 = mean1 - sd(success1/trials)/sqrt(n),  
                       upper1 = mean1 + sd(success1/trials)/sqrt(n),
                       lower2 = mean2 - sd(success2/trials)/sqrt(n),
                       upper2 = mean2 + sd(success2/trials)/sqrt(n))
  
  voc.night.m %<>% group_by(species) %>%
    
    # sliding window
    mutate(mean1.3 = rollapply(mean1, width = 3, FUN = mean, fill = NA),
           mean2.3 = rollapply(mean2, width = 3, FUN = mean, fill = NA)) %>%
    
    # which max  
    mutate(hour1 = ifelse(mean1.3 == max(mean1.3, na.rm = TRUE), max(mean1.3, na.rm = TRUE), NA),
           hour2 = ifelse(mean2.3 == max(mean2.3, na.rm = TRUE), max(mean2.3, na.rm = TRUE), NA)) %>%
    
    # melt mean type for plotting
    melt(measure.vars = c('mean1', 'mean2'), variable.name = 'response', value.name = 'mean') %>%
    
    # carry over other vars
    mutate(lower = ifelse(response == 'mean1', lower1, lower2),
           upper = ifelse(response == 'mean1', upper1, upper2),
           mean.3 = ifelse(response == 'mean1', mean1.3, mean2.3),
           max.3 = ifelse(response == 'mean1', hour1, hour2),
           lower1 = NULL, lower2 = NULL, upper1 = NULL, 
           upper2 = NULL, mean1.3 = NULL, mean2.3 = NULL,
           hour1 = NULL, hour2 = NULL) %>%
    
    # replace negative lower CL with 0, change mean1 and mean2
    mutate(lower = replace(lower, lower < 0, 0),
           upper = replace(upper, upper < 0, 0)) 
  
  voc.night.m$response %<>% recode(mean1 = 'p(presence)', mean2 = 'p(presence>1)')
  
  save(voc.night.m, file = 'data/voc-night-m.Rda')
  
  # coverage
  voc.night.cov <- ddply(seavoc, .(species, hrmin), dplyr::summarise, sites = sum(length(unique(siteID))), recordings = length(hrmin))
  
  save(voc.night.cov, file = 'data/voc-night-cov.Rda')
  
  ### seasonal vocalization probability
  # site means
  voc.allyear.m <- plyr::ddply(seavoc, .(species, siteID, ynight), dplyr::summarise, 
                               trials = length(ynight),
                               success1 = sum(pa), 
                               success2 = sum(pa2)) 
  
  voc.allyear.m %<>% plyr::ddply(.(species, ynight), dplyr::summarise, 
                                 n = length(ynight),
                                 mean1 = mean(success1/trials),
                                 mean2 = mean(success2/trials),
                                 lower1 = mean1 - sd(success1/trials)/sqrt(n),  
                                 upper1 = mean1 + sd(success1/trials)/sqrt(n),
                                 lower2 = mean2 - sd(success2/trials)/sqrt(n),
                                 upper2 = mean2 + sd(success2/trials)/sqrt(n))
  
  voc.allyear.diff <- mutate(voc.allyear.m, meandiff = mean1 - mean2)
  
  save(voc.allyear.diff, file = 'data/voc-allyear-diff.Rda')
  
  # sliding window
  voc.allyear.m %<>% group_by(species) %>%
    
    mutate(mean1.14 = zoo::rollapply(mean1, width = 14, FUN = mean, fill = NA),
           mean2.14 = zoo::rollapply(mean2, width = 14, FUN = mean, fill = NA)) %>%
    
    # which max  
    mutate(night1 = ifelse(mean1.14 == max(mean1.14, na.rm = TRUE), max(mean1.14, na.rm = TRUE), NA),
           night2 = ifelse(mean2.14 == max(mean2.14, na.rm = TRUE), max(mean2.14, na.rm = TRUE), NA)) %>%
    
    # melt mean type for plotting
    melt(measure.vars = c('mean1', 'mean2'), variable.name = 'response', value.name = 'mean') %>%
    
    # carry over other vars
    mutate(lower = ifelse(response == 'mean1', lower1, lower2),
           upper = ifelse(response == 'mean1', upper1, upper2),
           mean.14 = ifelse(response == 'mean1', mean1.14, mean2.14),
           max.14 = ifelse(response == 'mean1', night1, night2),
           lower1 = NULL, lower2 = NULL, upper1 = NULL, 
           upper2 = NULL, mean1.14 = NULL, mean2.14 = NULL,
           night1 = NULL, night2 = NULL) %>%
    
    # replace negative lower CL with 0, change mean1 and mean2
    mutate(lower = replace(lower, lower < 0, 0),
           upper = replace(upper, upper < 0, 0)) 
  
  voc.allyear.m$response %<>% recode(mean1 = 'p(presence)', mean2 = 'p(presence>1)')
  
  save(voc.allyear.m, file = 'data/voc-allyear-m.Rda')
  
  # calculate means for each year                     
  voc.byyear.m <- ddply(seavoc, .(species, siteID, year, ynight), dplyr::summarise, 
                        trials = length(ynight),
                        success1 = sum(pa), 
                        success2 = sum(pa2)) 
  
  
  voc.byyear.m %<>% ddply(.(species, year, ynight), dplyr::summarise, n = length(ynight), 
                          mean1 = mean(success1/trials), 
                          mean2 = mean(success2/trials),
                          lower1 = mean1 - sd(success1/trials)/sqrt(n),  
                          upper1 = mean1 + sd(success1/trials)/sqrt(n),
                          lower2 = mean2 - sd(success2/trials)/sqrt(n),
                          upper2 = mean2 + sd(success2/trials)/sqrt(n)) %>%
  # melt mean type for plotting
  melt(measure.vars = c('mean1', 'mean2'), variable.name = 'response', value.name = 'mean') %>%
    
    # carry over other vars
    mutate(lower = ifelse(response == 'mean1', lower1, lower2),
           upper = ifelse(response == 'mean1', upper1, upper2),
           lower1 = NULL, lower2 = NULL, upper1 = NULL, 
           upper2 = NULL) %>%
    
    # replace negative lower CL with 0, change mean1 and mean2
    mutate(lower = replace(lower, lower < 0, 0),
           upper = replace(upper, upper < 0, 0)) 
  
  voc.byyear.m$response %<>% recode(mean1 = 'p(presence)', mean2 = 'p(presence>1)')
  
  save(voc.byyear.m, file = 'data/voc-byyear-m.Rda')
  
  # boxplots by week
  # all year
  voc.allyear.box <- ddply(seavoc, .(species, siteID, week), dplyr::summarise, 
                           trials = length(ynight),
                           success1 = sum(pa), 
                           success2 = sum(pa2)) %>%
    
    mutate(prop1 = success1/trials,
           prop2 = success2/trials)
  
  save(voc.allyear.box, file = 'data/voc-allyear-box.Rda')
  
  # by year
  voc.byyear.box <- ddply(seavoc, .(species, year, siteID, week), dplyr::summarise, 
                          trials = length(ynight),
                          success1 = sum(pa), 
                          success2 = sum(pa2)) %>%
    
    mutate(prop1 = success1/trials,
           prop2 = success2/trials)
  
  save(voc.byyear.box, file = 'data/voc-byyear-box.Rda')
  
  # coverage for all years
  voc.allyear.cov <- ddply(seavoc, .(species, ynight), dplyr::summarize, 
                           sites = sum(length(unique(siteID))), recordings = length(ynight)) 
  
  save(voc.allyear.cov, file = 'data/voc-allyear-cov.Rda')
  # voc.allyear.cov %<>% melt(measure.vars = c('Sites', 'Recordings'), variable.name = 'unit', value.name = 'frequency')
  
  # coverage by year
  voc.byyear.cov <- ddply(seavoc, .(species, year, ynight), dplyr::summarize, 
                          sites = sum(length(unique(siteID))), recordings = length(ynight)) 
  
  save(voc.byyear.cov, file = 'data/voc-byyear-cov.Rda')
}

voc_analysis()
 









