source('header.R')

#  Overall temporal coverage by siteID
sea %<>% arrange(exp)
tempcov <- ggplot(arrange(sea, island), aes(x=DateTime, y=siteID, color = island)) +
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

### function for coverage plots
coverage <- function (data, x, y, facet, xlab = 'Date', ylab = 'Number of Sites', date.breaks = '1 month', date.format = '%b') {
  ggplot(data) +
    geom_line( aes_string(x = x, y = y), size = 0.5) +
    # geom_bar( aes_string(x = x, y = y), stat = 'identity', width = 0.1)  + 
    facet_wrap(facet, ncol = 4, strip.position = 'top') + theme_bw() +
    scale_x_datetime(breaks = date_breaks(date.breaks), labels = date_format(date.format, tz = tz_data), timezone = tz_data) + 
    labs(y = ylab, x = xlab) 
    # theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
    #       axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
    #       axis.title.y=element_text(margin=margin(0,10,0,0)),
    #       strip.text=element_text(size=8, face="bold"), panel.spacing = unit(1.1, "lines"))
}  

### function for mean prop plots
point <- function (data, x, facet, xlab = 'Date', ylab = 'Mean Proportion', date.breaks = '1 month', date.format = '%b') {
  ggplot(data) +
    geom_point( aes_string(x = x, y = 'mean', color = 'response'), size = 0.4)  + 
    geom_errorbar(aes_string(x, ymin = 'lower', ymax = 'upper', color = 'response'), size = 0.1) +
    geom_line(aes_string(x = x, y = 'mean', color = 'response'), size = 0.3) +
    facet_wrap(facet, ncol = 2, strip.position = 'top') + theme_bw() +
    scale_x_datetime(breaks = date_breaks(date.breaks), labels = date_format(date.format)) + 
    labs(y = ylab, x = xlab, color = 'Response')  
    # theme(panel.grid.major.y = element_line( size=.05, color="black"), panel.grid.major.x = element_line( size=.05, color="black"), axis.text = element_text(size = 6),
    #       axis.title=element_text(size=8) , axis.title.x=element_text(margin=margin(10,0,0,0)),
    #       axis.title.y=element_text(margin=margin(0,10,0,0)),
    #       strip.text=element_text(size=8, face="bold"), panel.spacing = unit(0.8, "lines"))
}  

# 14-day sampling window
window14 <- ggplot(filter(voc.allyear.m, response == 'p(presence)'), aes(label = paste(month(ynight, label = TRUE), day(ynight), sep = '-'))) + 
  geom_line(aes(x = ynight, y = mean.14, color = species)) +
  geom_point(aes(x = ynight, y = max.14), color = 'black') + 
  geom_label(aes(x = ynight, y = max.14), hjust = -0.2, vjust = 0.2, size = 3) + theme_bw() +
  labs(x = 'Date', y = 'p(presence)', color = 'Species') +
  scale_x_datetime(breaks = date_breaks('1 month'), labels = date_format("%b")) 

window3 <- ggplot(filter(voc.night.m, response == 'p(presence)'), aes(label = paste(hour(hrmin), lubridate::minute(hrmin), sep = ':'))) +
  geom_line(aes(x = hrmin, y = mean.3, color = species)) + 
  geom_point(aes(x = hrmin, y = max.3), color = 'black') + 
  geom_label(aes(x = hrmin, y = max.3), hjust = -0.2, vjust = 0.2, size = 3) +  
  labs(x = 'Time of Night', y = 'p(presence)', color = 'Species') +
  scale_x_datetime(breaks = date_breaks('2 hours'), labels = date_format("%H:%M", tz = tz_data))  + theme_bw()
  

