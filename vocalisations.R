source('header.R')

vocalizations <- function() {
  
  # make new datetime category for hour:minute
  load(file = 'data/sea-clean.Rda')
 
  
  
  ### include only ARUs with >0.001 proprotion detections for each species
  sitedet <- plyr::ddply(sea, .(species, siteID), summarise, success1 = sum(pa), success2 = sum(pa2), trials = length(siteID)) %>%
    
    mutate(prop1 = success1/trials,
           prop2 = success2/trials,
           sparu = paste0(species, siteID)) %>%
    
    filter(prop1 > 0.01)

  
  # filter main data set, including only matching Species and siteID as above
  seavoc <- mutate(sea, sparu = paste0(species, siteID)) %>% filter(sparu %in% sitedet$sparu) %>% mutate(sparu = NULL)
  # check
  tmp <- ddply(seavoc, .(species, siteID), dplyr::summarise, trials = length(siteID))
  tmp <- ddply(sea, .(species, siteID), dplyr::summarise, trials = length(siteID))
  rm(tmp)
  
  
  # calculate nightly vocalization rates
  voc.night <- ddply(seavoc, .(species, siteID, hrmin), dplyr::summarize, trials = length(hrmin), success1 = sum(pa), success2 = sum(pa2)) %>%
    
    mutate(prop1 = success1/trials,
           prop2 = success2/trials)
  
  voc.night.m <- ddply(voc.night, .(species, hrmin), dplyr::summarize, n = length(hrmin), mean1 = mean(success1/trials), mean2 = mean(success2/trials),
                       sd1 = sd(success1/trials), sd2 = sd(success2/trials), se1 = sd1/ sqrt(n), se2 = sd2/sqrt(n),
                       lower1 = mean1 - (1.96 * se1), upper1 = mean1 + (1.96 * se1), lower2 = mean2 - (1.96 * se2), upper2 = mean2 + (1.96 * se2))
  
  
  # coverage
  voc.night.cov <- ddply(seavoc, .(species, hrmin), dplyr::summarize, sites = sum(length(unique(siteID))), recordings = length(hrmin))
  
  
  ### seasonal vocalization rates
  # calc proportion by night
  voc.allyear <- ddply(seavoc, .(species, ynight), dplyr::summarize, trials = length(ynight), success1 = sum(pa), success2 = sum(pa2), NightTime = first(night)) %>%
                         mutate(mean1 = binconf(success1, trials)[,1],
                                                        lower1 = binconf(success1, trials)[,2],
                                                        upper1 = binconf(success1, trials)[,3],
                                                        mean2 = binconf(success2, trials)[,1],
                                                        lower2 = binconf(success2, trials)[,2],
                                                        upper2 = binconf(success2, trials)[,3])
                      
  
   
    mutate(prop1 = success1 / trials,
           prop2 = success2 / trials)
  
  voc.byyear <- ddply(seavoc, .(species, siteID, year, ynight), dplyr::summarize, trials = length(ynight), success1 = sum(pa), success2 = sum(pa2), NightTime = first(night)) %>%
    
    mutate(prop1 = success1 / trials,
           prop2 = success2 / trials)
  
  # calc proportion by week (for boxplots)
  # voc.allyear.w <- ddply(seavoc, .(species, siteID, week), dplyr::summarize, trials = length(week), success1 = sum(pa), success2 = sum(pa2), NightTime = first(night)) %>%
  #   
  #   mutate(prop1 = success1 / trials,
  #          prop2 = success2 / trials)
  
  # voc.byyear.w <- ddply(seavoc, .(species, siteID, year, week), dplyr::summarize, trials = length(week), success1 = sum(pa), success2 = sum(pa2), NightTime = first(night)) %>%
  #   
  #   mutate(prop1 = success1 / trials,
  #          prop2 = success2 / trials)
  
  # function to calculate confidence interval limits and se
  voc.allyear.m <- ddply(voc.allyear, .(species, ynight), dplyr::summarize, n = length(ynight), mean1 = mean(success1/trials), mean2 = mean(success2/trials),
                         lower1 = mean1 - (qt(.975, df = n-1) * ((sd(success1/trials)/sqrt(n)))),  
                         upper1 = mean1 + (qt(.975, df = n-1) * ((sd(success1/trials)/sqrt(n)))),
                         lower2 = mean2 - (qt(.975, df = n-1) * ((sd(success2/trials)/sqrt(n)))),
                         upper2 = mean2 + (qt(.975, df = n-1) * ((sd(success2/trials)/sqrt(n)))))
  
  voc.byyear.m <- ddply(voc.byyear, .(species, year, ynight), dplyr::summarize, n = length(ynight), mean1 = mean(success1/trials), mean2 = mean(success2/trials),
                         lower1 = mean1 - (qt(.975, df = n-1) * ((sd(success1/trials)/sqrt(n)))),  
                         upper1 = mean1 + (qt(.975, df = n-1) * ((sd(success1/trials)/sqrt(n)))),
                         lower2 = mean2 - (qt(.975, df = n-1) * ((sd(success2/trials)/sqrt(n)))),
                         upper2 = mean2 + (qt(.975, df = n-1) * ((sd(success2/trials)/sqrt(n)))))
  
  # filter species
  # voc.byyear.anmu.w <- filter(voc.byyear.w, species == 'Ancient Murrelet')
  # voc.byyear.caau.w <- filter(voc.byyear.w, species == "Cassin's Auklet")
  # voc.byyear.ftsp.w <- filter(voc.byyear.w, species == "Fork-tailed Storm Petrel")
  # voc.byyear.lesp.w <- filter(voc.byyear.w, species == "Leach's Storm Petrel")
  
  # filter species
  voc.byyear.anmu.m <- filter(voc.byyear.m, species == 'Ancient Murrelet')
  voc.byyear.caau.m <- filter(voc.byyear.m, species == "Cassin's Auklet")
  voc.byyear.ftsp.m <- filter(voc.byyear.m, species == "Fork-Tailed Storm-Petrel")
  voc.byyear.lesp.m <- filter(voc.byyear.m, species == "Leach's Storm-Petrel")
  
  # coverage for all years
  voc.allyear.cov <- ddply(seavoc, .(species, yday(night)), dplyr::summarize, sites = sum(length(unique(siteID))), recordings = length(yday(night)))
  
  # coverage for each year
  voc.byyear.cov <- ddply(seavoc, .(species, year(night), yday(night)), dplyr::summarize, sites = sum(length(unique(siteID))), recordings = length(yday(night)))
  # filter species
  voc.byyear.anmu.cov <- filter(voc.byyear.cov, species == 'Ancient Murrelet')
  voc.byyear.caau.cov <- filter(voc.byyear.cov, species == "Cassin's Auklet")
  voc.byyear.ftsp.cov <- filter(voc.byyear.cov, species == "Fork-Tailed Storm-Petrel")
  voc.byyear.lesp.cov <- filter(voc.byyear.cov, species == "Leach's Storm-Petrel")
}

vocalizations()

# # wilson binomial confidence intervals
# # function
# confint <- function(data) {
#   data %<>% mutate(prop1 = Hmisc::binconf(success1, trials)[,1],
#                    lower1 = Hmisc::binconf(success1, trials)[,2],
#                    upper1 = Hmisc::binconf(success1, trials)[,3],
#                    prop2 = Hmisc::binconf(success2, trials)[,1],
#                    lower2 = Hmisc::binconf(success2, trials)[,2],
#                    upper2 = Hmisc::binconf(success2, trials)[,3])
#   
# }






