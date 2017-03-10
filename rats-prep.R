
lapply(list.files(path = 'data', pattern = "*.Rda", full.names = TRUE), load, .GlobalEnv)

seaprep %<>% mutate(Impact = ifelse((exp == 'Impact' & PeriodPh2 == 'After' & phase2 == 1) | (exp == 'Impact' & PeriodPh1 == 'After' & phase1 == 1), 1, 0))

# eliminate post-impact site:year combinations
rats <- filter(seaprep, Impact == 0)

# summarize by site and species
rats %<>% ddply(.(species, site, year, yearf, rats, island), summarise,
                trials = n(), success1 = sum(pa), success2 = sum(pa2)) %>%
  
  mutate('p(presence)' = success1/trials,
         'p(presence>1)' = success2/trials)

### melt prop so same df
rats %<>% melt(measure.vars = c('p(presence)', 'p(presence>1)'), variable.name = 'propType', value.name = 'prop')

# empirical logit transform
rats %<>% mutate(prop = binomTools::empLogit(prop))

# aggragate by island for plotting
rats.island <- group_by(rats, species, island, year, rats, propType) %>%  summarise( n = n(),
                                                               mean = mean(prop),
                                                               lower = mean - sd(prop)/sqrt(n),  
                                                               upper = mean + sd(prop)/sqrt(n),
                                                               yearf = first(yearf))

# mean by rat status and year
rats.mean <- group_by(rats, species, year, rats, propType) %>%  summarise( n = n(),
                                                                         mean = mean(prop),
                                                                         lower = mean - sd(prop)/sqrt(n),  
                                                                         upper = mean + sd(prop)/sqrt(n),
                                                                         yearf = first(yearf))





