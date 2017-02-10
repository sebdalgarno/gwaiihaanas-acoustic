library(plyr)
library(sp)
library(rgdal)
library(ggplot2)

setwd('~/Google_Drive/')

### read data
seabird=read.csv('Contracts/GH_accoustic_bird/data/Seabirds_010317.csv')
songbird=read.csv('Contracts/GH_accoustic_bird/data/SongBirds_22Dec2016.csv')

### task 2a - Describe the annual and nightly variation in seabird vocalization rates, by species (appropriate figures such as box plots)
plot()
### task 2b - Describe the annual variation in songbird vocalization rates, overall, and by selected species (appropriate figures such as box plots; up to 10 species)

### task 2c - Describe differences in species richness by season, for songbirds (using a stacked bar plot or some other similar formatted graph to visualize shifts in the species composition comprising richness)

### task 2d - Test whether restoration resulted in a short-term increase in seabird vocalizations, by species (abundance), using BACI design

### task 2e - Test whether restoration resulted in a short-term decrease or increase in songbird vocalizations (abundance), species richness and biodiversity, using BACI design