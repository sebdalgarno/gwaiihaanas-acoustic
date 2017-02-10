source('header.R')

# load shapefile
islands <- readOGR(dsn = 'data', layer = 'islands')
islands %<>% spTransform('+init=epsg:4326')

# fortify
islands@data$id <- rownames(islands@data)
islands.pts <- fortify(islands, region = 'id')

islands.df <- as.data.frame(islands)

islands.pts %<>% left_join(islands.df) %>%
  
  # remove holes to facilitate drawing
  filter(hole == FALSE)  %>%
  
  # misspelled ramsey
  mutate(island = recode(island, Ramsey = 'Ramsay'))
  
islands.north <- filter(islands.pts, island != 'Alder' & island != 'Arichika' | is.na(island))
islands.south <- filter(islands.pts, island != 'Bischofs' & island != 'Faraday' & island != 'Hotspring' & island != 'House' & island != 'Murchison' & island != 'Ramsay' | is.na(island))
# add receiver locations
sites <- remove.duplicates(sp.sea)
sites %<>% spTransform('+init=epsg:4326') %>%
  as.data.frame()

sites.north <- filter(sites, island != 'Alder' & island != 'Arichika')
sites.south <- filter(sites, island != 'Bischofs' & island != 'Faraday' & island != 'Hotspring Islet' & island != 'Hotspring' & island != 'House' & island != 'Murchison' & island != 'Ramsay')

mapnorth <- ggplot() +
  geom_polygon(data = islands.north, 
               aes(x=long, y=lat, group = id, fill = island))  + theme_bw()  + coord_map(xlim = c(-131.59, -131.4), ylim = c(52.55, 52.62)) +
  scale_fill_manual(values = c('Bischofs' = '#1b9e77', 'Faraday' = '#d95f02', 'Hotspring' = '#7570b3','House' = '#e7298a', 'Murchison' = '#66a61e', 'Ramsay' = '#e6ab02'  ), na.value = 'dark grey', name = 'Island Group') + 
  geom_point(data = sites, aes(x = long, y = lat)) + geom_label_repel(data = sites.north, aes(x = long, y = lat, label = siteID), size = 2) +
  labs(x = 'Longitude', y = 'Latitiude') + scale_y_continuous(expand = c(0,0)) + scale_x_continuous(expand = c(0,0))
mapnorth

mapnorthword <- ggplot() +
  geom_polygon(data = islands.north, 
               aes(x=long, y=lat, group = id, fill = island))  + theme_bw()  + coord_map(xlim = c(-131.59, -131.4), ylim = c(52.55, 52.62)) +
  scale_fill_manual(values = c('Bischofs' = '#1b9e77', 'Faraday' = '#d95f02', 'Hotspring' = '#7570b3','House' = '#e7298a', 'Murchison' = '#66a61e', 'Ramsay' = '#e6ab02'  ), na.value = 'dark grey', name = 'Island Group') + 
  geom_point(data = sites, aes(x = long, y = lat), size = 1.5) + geom_label_repel(data = sites.north, aes(x = long, y = lat, label = siteID), size = 3) +
  labs(x = 'Longitude', y = 'Latitiude') 
mapnorthword

mapsouth <- ggplot() +
  geom_polygon(data = islands.south, 
               aes(x=long, y=lat, group = id, fill = island))  + theme_bw()  + coord_map(xlim = c(-131.36, -131.31), ylim = c(52.43, 52.48)) +
  scale_fill_manual(values = c('Alder' = '#a6761d', 'Arichika' = '#377eb8'), na.value = 'dark grey', name = 'Island Group') +
  geom_point(data = sites, aes(x = long, y = lat)) + geom_label_repel(data = sites.south, aes(x = long, y = lat, label = siteID), size = 3) +
  labs(x = 'Longitude', y = 'Latitiude') + scale_y_continuous(expand = c(0,0)) + scale_x_continuous(expand = c(0,0))
mapsouth
