source('header.R')

clean <- function() {
  ### read in data
  seabird=read_csv('data/seabird-raw.csv')
  
  # rename columns
  sea <-  dplyr::select(seabird, ID = ID, island = Island, aru = ARU.number, siteID = SiteID_NBR,
                        long = Long_NBR, lat = Lat_NBR, year = Yr, month = ActualMonth, day = ActualDay,
                        monthstrt = BeginMonth, daystrt = BeginDay,
                        hour.rough = Time.start, rec.order = Recording.Period, rain = Audible.precip,
                        noise = Noise_level, anmu = ANMU, caau = CAAU, ftsp = FTSP,
                        lesp = LESP, human.sound = human.sounds, jet = jet, unknown.sound = unknown,
                        notes.obs = Notes, notes.cap = Capture_cmmt, team = Data_capture,
                        rats = RatStatus, phase1 = Phase1_status, phase2 = Phase2_status)
  
  # convert DateTime
  # change hour to hours and minutes
  sea %<>% mutate(hour = round(hour.rough, - 2)/100,
                  minute.rough = round(hour.rough, - 2),
                  minute = hour.rough - minute.rough)
  
  # true DateTime
  sea %<>% mutate(DateTime = ISOdate(year, month, day, hour, minute, tz = tz_data))
  
  # create 'night' DateTime to analyse by night
  sea %<>% mutate(night = ISOdate(year, monthstrt, daystrt, hour, minute, tz = tz_data))
  
  # create island group var (e.g. alder vs. alder islet)
  sea %<>% mutate(islandGroup = recode(island, `Alder Islet` = 'Alder', `Hotspring Islet` = 'Hotspring'))
  
  # reduce columns
  sea %<>% select(-minute.rough, -hour.rough, -year, -month, -day, -hour, -minute, -rec.order,
                  -notes.obs, -notes.cap, -team, -ID)
  
  # melt species columns into one column
  sea %<>% melt(id.vars = c('island', 'islandGroup', 'aru', 'siteID', 'long', 'lat', 'rain', 'noise', 'human.sound', 'jet', 
                            'unknown.sound', 'rats', 'phase1', 'phase2', 'DateTime', 'night'),
                measure.vars = c('anmu', 'caau', 'ftsp', 'lesp'), 
                variable.name = 'species')
  
  sea %<>% mutate(presence = value,
                  value = NULL)
  
  # there is a 3 for some reason in presence - remove
  sea %<>% mutate(presence = replace(presence, presence == 3, 2))
  
  # check for null values
  na <- sea[which(is.na(sea$DateTime)),]
  na <- seabird[which(is.na(seabird$Time.start)),]
  # 2 observations missing dattime info (along with other variables)
  # remove these
  sea <- sea[which(!is.na(sea$DateTime)),]
  
  na <- sea[which(is.na(sea$presence)),]
  rm(na)
  # remove missing values in presence/absence
  sea <- sea[which(!is.na(sea$presence)),]
  
  # remove any date after oct 1st (Carey Bergman says is error)
  sea %<>% filter(week(DateTime) < 42)
  
  
  # recode species names
  sea$species %<>% recode(anmu = "Ancient Murrelet", caau = "Cassin's Auklet", 
                          ftsp = "Fork-Tailed Storm-Petrel", lesp = "Leach's Storm-Petrel")
  
  # add column indicating whether control or impact site
  sea %<>% mutate(exp = recode(island, Alder = "Control", `Alder Islet` = "Control", Arichika = "Impact", Bischofs = "Impact",
                               Faraday = "Impact", Hotspring = "Control", `Hotspring Islet` = "Control", House = "Control",
                               Murchison = "Impact", Ramsay = "Control"),
                  
                  phase1 = ifelse(((island %in% control.anmu.ph1 | island %in% impact.phase1) & species == sp[1]) & year(night) < 2014 | 
                                    ((island %in% control.ftsp.ph1 | island %in% impact.phase1) & species == sp[3]) & year(night) < 2014 | 
                                    ((island %in% control.caau.ph1 | island %in% impact.phase1) & species == sp[2]) & year(night) < 2014, 1, 0),
                  
                  phase2 = ifelse(((island %in% control.anmu.ph2 | island %in% impact.phase2) & species == sp[1]) & year(night) > 2011 | 
                                    ((island %in% control.ftsp.ph2 | island %in% impact.phase2) & species == sp[3]) & year(night) > 2011 | 
                                    ((island %in% control.caau.ph2 | island %in% impact.phase2) & species == sp[2]) & year(night) > 2011, 1, 0))
  
  # create a p/a variables (pa > 1 and pa2 > 2)
  sea %<>% mutate(pa = replace(presence, presence == 2, 1),
                  tmp = replace(presence, presence == 1, 0),
                  pa2 = replace(tmp, tmp == 2, 1),
                  tmp = NULL)
  
  # create hour:minute variable for nightly vocalisation probability
  sea %<>% mutate(hour.min = paste(hour(night), lubridate::minute(night), sep=":"),
                  hourmin = parse_date_time(hour.min, 'HM', tz = tz_data),
                  hrmin = as.POSIXct(ifelse(hour(hourmin) >= 0 & hour(hourmin) < 06, hourmin + ddays(1), hourmin), # make 1am follow from 11:pm as next night
                                     origin = "1970-01-01", tz = tz_data),
                  hour.min = NULL,
                  hourmin = NULL,
                  ynight = as.Date(paste(2010, lubridate::yday(night), 1, sep = '-'),' %Y-%j-%H'), # note that year is arbitrary
                  year = year(night),
                  week = as.Date(paste(2010, lubridate::week(night), 5, sep = '-'),' %Y-%U-%u')) %>% # note that year is arbitrary
    
    mutate(ynight = ymd_hms(paste(as.character(ynight), '00:00:00', sep = ' '), tz = tz_data))
  
  save(sea, file = 'data/sea-clean.Rda')
  # create a spatial points data.frame
  sp.sea <- convert_proj(sea, 'long', 'lat')
  
  save(sp.sea, file = 'data/sp-sea.Rda')
  
}

clean()





       
