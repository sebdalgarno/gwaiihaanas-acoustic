source('header.R')

#  Overall temporal coverage by siteID
sea %<>% arrange(exp)
temp.cov <- ggplot(arrange(sea, island), aes(x=DateTime, y=siteID, color = island)) +
  geom_point(size = 0.8)  + theme_bw() +
  scale_x_datetime(breaks = date_breaks('4 months'), labels = date_format("%b-%Y")) + 
  theme(axis.text.x = element_text(angle = 90, size = 9)) + 
  labs(x = 'Date', y = 'Site ID', color = 'Island') +
  scale_color_manual(values = c('Bischofs' = '#1b9e77', 'Faraday' = '#d95f02', 'Hotspring' = '#7570b3','House' = '#e7298a', 'Murchison' = '#66a61e', 'Ramsay' = '#e6ab02', 'Alder' = '#a6761d', 'Arichika' = '#377eb8'), na.value = 'dark grey', name = 'Island Group') +
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8, face = 'bold') , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)))

#### Nightly Vocalization Rates
voc.night.prop1 <- ggplot(voc.night) + geom_boxplot( aes(x=hrmin, y=prop1, group = hrmin), varwidth = TRUE) + 
  facet_wrap(.(species), ncol = 2) + theme_few() + 
  scale_x_datetime(breaks = date_breaks('1 hour'), labels = date_format("%H:%M")) + 
  labs(y = 'Proportion with Detection \nof one or more Individual', x = 'Time of Night') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1.1, "lines"))

voc.night.prop2 <- ggplot(voc.night) + geom_boxplot( aes(x=hrmin, y=prop2, group = hrmin), varwidth = TRUE) + 
  facet_wrap(.(species), ncol = 2) + theme_few() + 
  scale_x_datetime(breaks = date_breaks('1 hour'), labels = date_format("%H:%M")) + 
  labs(y = 'Proportion with Detection \nof two or more Individual', x = 'Time of Night') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1.1, "lines"))

voc.night.cov.site <- ggplot(voc.night.cov, aes(x=hrmin, y=sites)) +
  geom_bar(stat = 'identity')  + 
  facet_wrap(~species, ncol = 2, strip.position = 'top') + theme_few() +
  scale_x_datetime(breaks = date_breaks('1 hour'), labels = date_format("%H:%M")) + 
  labs(y = 'Number of Sites', x = 'Time of Night') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1.1, "lines"))

voc.night.cov.rec <- ggplot(voc.night.cov, aes(x=hrmin, y=recordings)) +
  geom_bar(stat = 'identity')  + 
  facet_wrap(~species, ncol = 2, strip.position = 'top') + theme_few() +
  scale_x_datetime(breaks = date_breaks('1 hour'), labels = date_format("%H:%M")) + 
  labs(y = 'Number of Recordings', x = 'Time of Night') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1.1, "lines"))

### Annual vocalization rates
voc.allyear.prop1 <- ggplot(voc.allyear) + geom_boxplot(aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=prop1, group = as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u')), varwidth = TRUE) + 
  facet_wrap(.(species), ncol = 2) + theme_few() + 
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'Proportion with Detection \nof one or more Individual', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1.1, "lines"))

voc.allyear.prop2 <- ggplot(voc.allyear) + geom_boxplot(aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=prop2, group = as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u')), varwidth = TRUE) + 
  facet_wrap(.(species), ncol = 2) + theme_few() + 
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'Proportion with Detection \nof Two or more Individuals', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1.1, "lines"))

voc.allyear.cov.site <- ggplot(voc.allyear.cov, aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=sites)) +
  geom_bar(stat = 'identity')  + 
  facet_wrap(~species, ncol = 2, strip.position = 'top') + theme_few() +
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'Number of Sites', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1.1, "lines"))

voc.allyear.cov.rec <- ggplot(voc.allyear.cov, aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=recordings)) +
  geom_bar(stat = 'identity')  + 
  facet_wrap(~species, ncol = 2, strip.position = 'top') + theme_few() +
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'Number of Recordings', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1.1, "lines"))

#### Annual vocalization rates by year
#### Ancient Murrelet
voc.byyear.anmu <- ggplot(subset(voc.byyear, species == "Ancient Murrelet")) + geom_boxplot(aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=prop1, group = as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u')), varwidth = TRUE) + 
  facet_wrap(.(year), ncol = 2) + theme_few() + 
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'Proportion with Detection \nof One or more Individual', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1, "lines"))

voc.byyear.anmu.prop2 <- ggplot(subset(voc.byyear, species == "Ancient Murrelet")) + geom_boxplot(aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=prop2, group = as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u')), varwidth = TRUE) + 
  facet_wrap(.(year), ncol = 2) + theme_few() + 
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'Proportion with Detection \nof Two or more Individuals', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1, "lines"))

voc.byyear.cov.anmusite <- ggplot(subset(voc.byyear.cov, species == "Ancient Murrelet"), aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=sites)) + geom_bar(stat = 'identity') + 
  facet_wrap(.(year), ncol = 2) + theme_few() + 
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'Number of Sites', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1, "lines"))

voc.byyear.cov.anmurec <- ggplot(subset(voc.byyear.cov, species == "Ancient Murrelet"), aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=recordings)) + geom_bar(stat = 'identity') + 
  facet_wrap(.(year), ncol = 2) + theme_few() + 
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'Number of Recordings', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1, "lines"))

#### Cassin's Auklet
voc.byyear.caau <- ggplot(subset(voc.byyear, species == "Cassin's Auklet")) + geom_boxplot(aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=prop1, group = as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u')), varwidth = TRUE) + 
  facet_wrap(.(year), ncol = 2) + theme_few() + 
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'Proportion with Detection \nof One or more Individual', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1, "lines"))

voc.byyear.caau.prop2 <- ggplot(subset(voc.byyear, species == "Cassin's Auklet")) + geom_boxplot(aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=prop2, group = as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u')), varwidth = TRUE) + 
  facet_wrap(.(year), ncol = 2) + theme_few() + 
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'Proportion with Detection \nof Two or more Individuals', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1, "lines"))

voc.byyear.cov.caausite <- ggplot(subset(voc.byyear.cov, species == "Cassin's Auklet"), aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=sites)) + geom_bar(stat = 'identity') + 
  facet_wrap(.(year), ncol = 2) + theme_few() + 
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'Number of Sites', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1, "lines"))

voc.byyear.cov.caaurec <- ggplot(subset(voc.byyear.cov, species == "Cassin's Auklet"), aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=recordings)) + geom_bar(stat = 'identity') + 
  facet_wrap(.(year), ncol = 2) + theme_few() + 
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'Number of Recordings', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1, "lines"))

#### Fork-Tailed Storm-Petrel
voc.byyear.ftsp <- ggplot(subset(voc.byyear, species == "Fork-Tailed Storm-Petrel")) + geom_boxplot(aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=prop1, group = as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u')), varwidth = TRUE) + 
  facet_wrap(.(year), ncol = 2) + theme_few() + 
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'Proportion with Detection \nof One or more Individual', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1, "lines"))

voc.byyear.ftsp.prop2 <- ggplot(subset(voc.byyear, species == "Fork-Tailed Storm-Petrel")) + geom_boxplot(aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=prop2, group = as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u')), varwidth = TRUE) + 
  facet_wrap(.(year), ncol = 2) + theme_few() + 
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'Proportion with Detection \nof Two or more Individuals', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1, "lines"))

voc.byyear.cov.ftspsite <- ggplot(subset(voc.byyear.cov, species == "Fork-Tailed Storm-Petrel"), aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=sites)) + geom_bar(stat = 'identity') + 
  facet_wrap(.(year), ncol = 2) + theme_few() + 
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'Number of Sites', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1, "lines"))

voc.byyear.cov.ftsprec <- ggplot(subset(voc.byyear.cov, species == "Fork-Tailed Storm-Petrel"), aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=recordings)) + geom_bar(stat = 'identity') + 
  facet_wrap(.(year), ncol = 2) + theme_few() + 
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'Number of Recordings', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1, "lines"))

#### Leach's Storm-Petrel
voc.byyear.lesp <- ggplot(subset(voc.byyear, species == "Leach's Storm-Petrel")) + geom_boxplot(aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=prop1, group = as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u')), varwidth = TRUE) + 
  facet_wrap(.(year), ncol = 2) + theme_few() + 
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'Proportion with Detection \nof One or more Individual', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1, "lines"))

voc.byyear.lesp.prop2 <- ggplot(subset(voc.byyear, species == "Leach's Storm-Petrel")) + geom_boxplot(aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=prop2, group = as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u')), varwidth = TRUE) + 
  facet_wrap(.(year), ncol = 2) + theme_few() + 
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'Proportion with Detection \nof Two or more Individuals', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1, "lines"))

voc.byyear.cov.lespsite <- ggplot(subset(voc.byyear.cov, species == "Leach's Storm-Petrel"), aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=sites)) + geom_bar(stat = 'identity') + 
  facet_wrap(.(year), ncol = 2) + theme_few() + 
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'Number of Sites', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1, "lines"))

voc.byyear.cov.lesprec <- ggplot(subset(voc.byyear.cov, species == "Leach's Storm-Petrel"), aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=recordings)) + geom_bar(stat = 'identity') + 
  facet_wrap(.(year), ncol = 2) + theme_few() + 
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'Number of Recordings', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1, "lines"))
