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

#### function for boxplots
boxplot <- function(data, x, y, group, facet, xlab = 'Date', ylab = 'p(presence)', date.breaks = '1 month', date.format = '%b') {
  ggplot(data) + geom_boxplot( aes_string(x = x, y = y, group = group ), outlier.shape = NA) + 
    facet_wrap(facet, ncol = 2) + theme_few() + 
    scale_x_date(breaks = date_breaks(date.breaks), labels = date_format(date.format)) + 
    labs(y = ylab, x = xlab) + 
    theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
          axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
          axis.title.y=element_text(margin=margin(0,10,0,0)),
          strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1.1, "lines"))
}

boxplot(voc.allyear, 'ynight', 'prop1', 'ynight', 'species')

### function for coverage plots
coverage <- function (data, x, y, facet, xlab = 'Date', ylab = 'p(presence)', date.breaks = '1 month', date.format = '%b') {
  ggplot(data) +
    geom_bar( aes_string(x = x, y = y), stat = 'identity', width = 200)  + 
    facet_wrap(facet, ncol = 2, strip.position = 'top') + theme_few() +
    scale_x_datetime(breaks = date_breaks(date.breaks), labels = date_format(date.format)) + 
    labs(y = ylab, x = xlab) + 
    theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
          axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
          axis.title.y=element_text(margin=margin(0,10,0,0)),
          strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1.1, "lines"))
}  

### function for mean prop plots
point <- function (data, x, facet, xlab = 'Date', ylab = 'p(presence)', date.breaks = '1 month', date.format = '%b') {
  ggplot(data) +
    geom_point( aes_string(x = x, y = 'mean1'), size = 1)  + 
    geom_point( aes_string(x = x, y = 'mean2'), size = 1, color = 'blue')  + 
    geom_errorbar(aes_string(x, ymin = 'lower1', ymax = 'upper1'), size = 0.4) +
    geom_errorbar(aes_string(x, ymin = 'lower2', ymax = 'upper2'), color = 'blue', size = 0.4) +
    facet_wrap(facet, ncol = 2, strip.position = 'top') + theme_few() +
    scale_x_date(breaks = date_breaks(date.breaks), labels = date_format(date.format)) + 
    labs(y = ylab, x = xlab) + 
    theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
          axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
          axis.title.y=element_text(margin=margin(0,10,0,0)),
          strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1.1, "lines"))
}  
point(voc.allyear.m, x = 'ynight', 'species')

# 14-day sampling window
ggplot(voc.allyear.m, aes(label = paste(month(ynight, label = TRUE), day(ynight), sep = '-'))) + geom_line(aes(x = ynight, y = mean1.14, color = species)) + geom_point(aes(x = ynight, y = day1), color = 'black') + 
  geom_label(aes(x = ynight, y = day1), hjust = -0.2, vjust = 0.2) + theme_bw() + labs(x = 'Date', y = 'p(presence)', color = 'Species') +
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) 

ggplot(voc.night.m, aes(label = paste(hour(hrmin), lubridate::minute(hrmin), sep = ':'))) + geom_line(aes(x = hrmin, y = mean1.14, color = species)) + geom_point(aes(x = hrmin, y = hour1), color = 'black') + 
  geom_label(aes(x = hrmin, y = hour1), hjust = -0.2, vjust = 0.2) +  labs(x = 'Time of Night', y = 'p(presence)', color = 'Species') +
  scale_x_datetime(breaks = date_breaks('2 hours'), labels = date_format("%H:%M", tz = tz_data))  + theme_bw()
  

voc.night.prop1

voc.night.prop2

voc.night.cov.site

voc.night.cov.rec

### Nightly vocalization probabilities, all years combined
voc.allyear.prop1

voc.allyear.prop2

voc.allyear.cov.site

voc.allyear.cov.rec

### Nightly vocalization probabilities by year
#### Ancient Murrelet
voc.byyear.anmu

voc.byyear.anmu.prop2

voc.byyear.cov.anmusite

voc.byyear.cov.anmurec

#
#### Cassin's Auklet
voc.byyear.caau

voc.byyear.caau.prop2

voc.byyear.cov.caausite

voc.byyear.cov.caaurec

#### Fork-Tailed Storm-Petrel
voc.byyear.ftsp

voc.byyear.ftsp.prop2

voc.byyear.cov.ftspsite

voc.byyear.cov.ftsprec

#### Leach's Storm-Petrel
voc.byyear.lesp

voc.byyear.lesp.prop2

voc.byyear.cov.lespsite

voc.byyear.cov.lesprec

coverage(voc.night.m, 'hrmin', 'species')

voc.night.prop1 <- boxplot(voc.night, 'hrmin', 'prop1', 'hrmin', 'species', 'Time of Night', 'p(presence)', '1 hour', '%H:%M')


voc.night.prop1

voc.night.prop2 <- ggplot(voc.night) + geom_boxplot( aes(x=hrmin, y = prop, group= hrmin, fill = prop.type), outlier.shape = NA) + 
  facet_wrap(.(species), ncol = 2) + theme_few() + 
  scale_x_datetime(breaks = date_breaks('1 hour'), labels = date_format("%H:%M")) + 
  labs(y = 'p(presence > 1)', x = 'Time of Night') + 
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
voc.allyear.prop1 <- e

voc.allyear.prop2 <- ggplot(voc.allyear) + geom_boxplot(aes(x=yday(NightTime), y=prop2, group = yday(NightTime))) + 
  facet_wrap(.(species), ncol = 2) + theme_few() + 
  scale_x_datetime(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'p(presence > 1)', x = 'Date') + 
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
  labs(y = 'p(presence)', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1, "lines"))

voc.byyear.anmu.prop2 <- ggplot(subset(voc.byyear, species == "Ancient Murrelet")) + geom_boxplot(aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=prop2, group = as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u')), varwidth = TRUE) + 
  facet_wrap(.(year), ncol = 2) + theme_few() + 
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'p(presence > 1)', x = 'Date') + 
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
  labs(y = 'p(presence)', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1, "lines"))

voc.byyear.caau.prop2 <- ggplot(subset(voc.byyear, species == "Cassin's Auklet")) + geom_boxplot(aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=prop2, group = as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u')), varwidth = TRUE) + 
  facet_wrap(.(year), ncol = 2) + theme_few() + 
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'p(presence > 1)', x = 'Date') + 
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
  labs(y = 'p(presence)', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1, "lines"))

voc.byyear.ftsp.prop2 <- ggplot(subset(voc.byyear, species == "Fork-Tailed Storm-Petrel")) + geom_boxplot(aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=prop2, group = as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u')), varwidth = TRUE) + 
  facet_wrap(.(year), ncol = 2) + theme_few() + 
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'p(presence > 1)', x = 'Date') + 
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
voc.byyear.lesp <- ggplot(subset(voc.byyear, species == "Leach's Storm-Petrel")) + geom_boxplot(aes(x=as.Date(paste(2000, y, 1, sep = '-'),' %Y-%U-%u'), y=prop1, group = as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u')), varwidth = TRUE) + 
  facet_wrap(.(year), ncol = 2) + theme_few() + 
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'p(presence)', x = 'Date') + 
  theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
        axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
        axis.title.y=element_text(margin=margin(0,10,0,0)),
        strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1, "lines"))

voc.byyear.lesp.prop2 <- ggplot(subset(voc.byyear, species == "Leach's Storm-Petrel")) + geom_boxplot(aes(x=as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u'), y=prop2, group = as.Date(paste(2000, week, 1, sep = '-'),' %Y-%U-%u')), varwidth = TRUE) + 
  facet_wrap(.(year), ncol = 2) + theme_few() + 
  scale_x_date(breaks = date_breaks('1 month'), labels = date_format("%b")) + 
  labs(y = 'p(presence > 1)', x = 'Date') + 
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
