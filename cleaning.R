source('header.R')

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
sea %<>% mutate(hour = round(hour.rough, -2)/100,
                minute.rough = round(hour.rough, -2),
                minute = hour.rough - minute.rough)

# true DateTime
sea %<>% mutate(DateTime = ISOdate(year, month, day, hour, minute, tz = "America/Los_Angeles"))

# create 'night' DateTime to analyse by night
sea %<>% mutate(night = ISOdate(year, monthstrt, daystrt, hour, minute, tz = "America/Los_Angeles"))

# fix island names (e.g. alder vs. alder islet)
sea %<>% mutate(island = recode(island, `Alder Islet` = 'Alder'))

sea %<>% mutate(island = recode(island, `Hotspring Islet` = 'Hotspring')) 


# reduce columns
sea %<>% select(-minute.rough, -hour.rough, -year, -month, -day, -hour, -minute, -rec.order,
                -notes.obs, -notes.cap, -team, -ID)

# melt species columns into one column
sea %<>% melt(id.vars = c('island', 'aru', 'siteID', 'long', 'lat', 'rain', 'noise', 'human.sound', 'jet', 
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
sea %<>% mutate(exp = recode(island, Alder = "Control", Arichika = "Impact", Bischofs = "Impact",
                             Faraday = "Impact", Hotspring = "Control", House = "Control",
                             Murchison = "Impact", Ramsay = "Control"),
                phase1 = recode(island, Alder = 1, Arichika = 1, Bischofs = 1,
                                Faraday = 0, Hotspring = 1, House = 0,
                                Murchison = 0, Ramsay = 0),
                phase2 = recode(island, Alder = 1, Arichika = 0, Bischofs = 0,
                                Faraday = 1, Hotspring = 1, House = 1,
                                Murchison = 1, Ramsay = 1))

# create a p/a variables (pa > 1 and pa2 > 2)
sea %<>% mutate(pa = replace(presence, presence == 2, 1),
                tmp = replace(presence, presence == 1, 0),
                pa2 = replace(tmp, tmp == 2, 1),
                tmp = NULL)

save(sea, file = 'data/sea-clean.Rda')
# create a spatial points data.frame
sp.sea <- convert_proj(sea, 'long', 'lat')




       
