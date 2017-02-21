source('header.R')
figs <- captioner(prefix = "Figure")
tbls <- captioner(prefix = "Table")

# cov
figs("spatnorth", "Location of ARUs and island groups within northern part of study area.")
figs("spatsouth", "Location of ARUs and island groups within southern part of study area.")
figs("tempcov", "Temporal coverage at sites (ARU monitoring locations), 2010-2015. Color indicates island group.")

figs("spatnorth.ph2", "Location of ARUs and island groups within northern part of study area; Phase 2.")
figs("spatsouth.ph2", "Location of ARUs and island groups within southern part of study area; Phase 2.")
figs("tempcov.ph2", "Phase 2 temporal coverage at sites (ARU monitoring locations), 2012-2015.")

# nightly
figs("voc.night.m", "Daily vocalization probability by species and response.
     Points indicate mean at all sites; vertical lines indicate standard error interval.")
figs("voc.night.cov.site", "Number of sites in each 10-minute recording period.")
figs("window3", "Mean daily vocalisation probability within one-hour sliding window, by species.")

# seasonal
figs("voc.allyear.m", "Seasonal vocalization probability by species and species, all years combined. 
     Points indicate mean at all sites; vertical lines indicate standard error interval.")
figs("voc.allyear.cov.site", "Number of sites in each night.")
figs("window14", "Mean seasonal vocalisation probability within 14-day sliding window, by species.")
figs("voc.allyear.diff", "Seasonal vocalisation probability; difference between responses (p(presence) - p(presence>1)).")

# by year
figs("voc.byyear.m.anmu", "Seasonal vocalization probability; Ancient Murrelet, 2010-2015.
     Points indicate mean at all sites; vertical lines indicate standard error interval.")
figs("voc.byyear.cov.anmu.site", "Number of sites in each night; Ancient Murrelet.")
figs("voc.byyear.m.caau", "Seasonal vocalization probability; Cassin's Auklet, 2010-2015.
     Points indicate mean at all sites; vertical lines indicate standard error interval.")
figs("voc.byyear.cov.caau.site", "Number of sites in each night; Cassin's Auklet.")
figs("voc.byyear.m.ftsp", "Seasonal vocalization probability; Fork-Tailed Storm-Petrel, 2010-2015.
     Points indicate mean at all sites; vertical lines indicate standard error interval.")
figs("voc.byyear.cov.ftsp.site", "Number of sites in each night; Fork-Tailed Storm-Petrel.")
figs("voc.byyear.m.lesp", "Seasonal vocalization probability; Leach's Storm-Petrel, 2010-2015.
     Points indicate mean at all sites; vertical lines indicate standard error interval.")
figs("voc.byyear.cov.lesp.site", "Number of sites in each night; Leach's Storm-Petrel.")



