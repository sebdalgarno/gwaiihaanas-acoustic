source('header.R')

# coverage 
tempcov.baci = function(data, x, y, color) {
  ggplot(data, aes_string(x = x, y = y,  color = color)) + geom_point(size = 1) + theme_bw() +
  labs(x = 'Date', y = 'SiteID', color = 'Site Class') +
  scale_x_datetime(breaks = date_breaks('2 months'), labels = date_format("%b-%Y"))  +
  theme(axis.text.x = element_text(angle = 90, size = 9)) + 
  geom_vline(xintercept = as.numeric(as.POSIXct('2011-05-01 00:00:00'))) +
  geom_vline(xintercept = as.numeric(as.POSIXct('2011-06-15 00:00:00'))) +
  geom_vline(xintercept = as.numeric(as.POSIXct('2012-06-15 00:00:00'))) +
  geom_vline(xintercept = as.numeric(as.POSIXct('2012-05-01 00:00:00'))) +
  geom_vline(xintercept = as.numeric(as.POSIXct('2013-05-01 00:00:00'))) +
  geom_vline(xintercept = as.numeric(as.POSIXct('2013-06-15 00:00:00'))) +
  geom_vline(xintercept = as.numeric(as.POSIXct('2014-05-01 00:00:00'))) +
  geom_vline(xintercept = as.numeric(as.POSIXct('2014-06-15 00:00:00'))) +
  geom_vline(xintercept = as.numeric(as.POSIXct('2015-05-01 00:00:00'))) +
  geom_vline(xintercept = as.numeric(as.POSIXct('2015-06-15 00:00:00'))) 
}


  
# BACI effect

# diagnostic plots


  
