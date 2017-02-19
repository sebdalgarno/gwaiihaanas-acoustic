<- <- <- <- <- <- <- <- source('header.R')
figs <- captioner(prefix = "Figure")
tbls <- captioner(prefix = "Table")

### BACI
# ANMU
figs("anmu.temp.ph1", "Phase 1 temporal coverage by site. Colour indicates site class ('Control', 'Impact'). Vertical black lines indicate 2-week sampling window used for Ancient Murrelet analysis (May 11 - May 24)")
figs("anmu.temp.ph2", "Phase 2 temporal coverage by site. Colour indicates site class ('Control', 'Impact'). Vertical black lines indicate 2-week sampling window used for Ancient Murrelet analysis (May 11 - May 24).")

figs("anmu.mean.ph1", "Phase 1, Ancient Murrelet; Mean proportion of recordings with detected presence (left panel) and more than one individual detected. Color indicates whether island was control or impact; shape indicates island group")
figs("anmu.mean.ph2", "Phase 2, Ancient Murrelet; Mean proportion of recordings with detected presence (left panel) and more than one individual detected. Color indicates whether island was control or impact; shape indicates island group")

tbls("anmu.ph1.1.coef", "Summary model coefficients; Ancient Murrelet, Phase 1, proportion of recordings with detected presence." )
tbls("anmu.ph1.1.marg", "BACI marginal means; Ancient Murrelet, Phase 1, proportion of recordings with detected presence.")
tbls("anmu.ph1.1.cont", "BACI effect and 95% confidence intervals; Ancient Murrelet, Phase 1, proportion of recordings with detected presence.")

tbls("anmu.ph1.2.coef", "Summary model coefficients; Ancient Murrelet, Phase 1, proportion of recordings with more than one individual detected." )
tbls("anmu.ph1.2.marg", "BACI marginal means; Ancient Murrelet, Phase 1, proportion of recordings with more than one individual detected.")
tbls("anmu.ph1.2.cont", "BACI effect and 95% confidence intervals; Ancient Murrelet, Phase 1, proportion of recordings with more than one individual detected.")

tbls("anmu.ph2.1.coef", "Summary model coefficients; Ancient Murrelet, Phase 2, proportion of recordings with detected presence." )
tbls("anmu.ph2.1.marg", "BACI marginal means; Ancient Murrelet, Phase 2, proportion of recordings with detected presence.")
tbls("anmu.ph2.1.cont", "BACI effect and 95% confidence intervals; Ancient Murrelet, Phase 2, proportion of recordings with detected presence.")

tbls("anmu.ph2.2.coef", "Summary model coefficients; Ancient Murrelet, Phase 2, proportion of recordings with more than one individual detected." )
tbls("anmu.ph2.2.marg", "BACI marginal means; Ancient Murrelet, Phase 2, proportion of recordings with more than one individual detected.")
tbls("anmu.ph2.2.cont", "BACI effect and 95% confidence intervals; Ancient Murrelet, Phase 2, proportion of recordings with more than one individual detected.")

# CAAU
figs("caau.temp.ph1", "Phase 1 temporal coverage by site. Colour indicates site class ('Control', 'Impact'). Vertical black lines indicate 2-week sampling window used for Cassin's Auklet analysis (May 01 - May 14).")
figs("caau.temp.ph2", "Phase 2 temporal coverage by site. Colour indicates site class ('Control', 'Impact'). Vertical black lines indicate 2-week sampling window used for Cassin's Auklet analysis (May 01 - May 14).")

figs("caau.mean.ph1", "Phase 1, Cassin's Auklet; Mean proportion of recordings with detected presence (left panel) and more than one individual detected. Color indicates whether island was control or impact; shape indicates island group")
figs("caau.mean.ph2", "Phase 2, Cassin's Auklet; Mean proportion of recordings with detected presence (left panel) and more than one individual detected. Color indicates whether island was control or impact; shape indicates island group")

tbls("caau.ph1.1.coef", "Summary model coefficients; Cassin's Auklet, Phase 1, proportion of recordings with detected presence." )
tbls("caau.ph1.1.marg", "BACI marginal means; Cassin's Auklet, Phase 1, proportion of recordings with detected presence.")
tbls("caau.ph1.1.cont", "BACI effect and 95% confidence intervals; Cassin's Auklet, Phase 1, proportion of recordings with detected presence.")

tbls("caau.ph1.2.coef", "Summary model coefficients; Cassin's Auklet, Phase 1, proportion of recordings with more than one individual detected." )
tbls("caau.ph1.2.marg", "BACI marginal means; Cassin's Auklet, Phase 1, proportion of recordings with more than one individual detected.")
tbls("caau.ph1.2.cont", "BACI effect and 95% confidence intervals; Cassin's Auklet, Phase 1, proportion of recordings with more than one individual detected.")

tbls("caau.ph2.1.coef", "Summary model coefficients; Cassin's Auklet, Phase 2, proportion of recordings with detected presence." )
tbls("caau.ph2.1.marg", "BACI marginal means; Cassin's Auklet, Phase 2, proportion of recordings with detected presence.")
tbls("caau.ph2.1.cont", "BACI effect and 95% confidence intervals; Cassin's Auklet, Phase 2, proportion of recordings with detected presence.")

tbls("caau.ph2.2.coef", "Summary model coefficients; Cassin's Auklet, Phase 2, proportion of recordings with more than one individual detected." )
tbls("caau.ph2.2.marg", "BACI marginal means; Cassin's Auklet, Phase 2, proportion of recordings with more than one individual detected.")
tbls("caau.ph2.2.cont", "BACI effect and 95% confidence intervals; Cassin's Auklet, Phase 2, proportion of recordings with more than one individual detected.")

# FTSP
figs("ftsp.temp.ph1", "Phase 1 temporal coverage by site. Colour indicates site class ('Control', 'Impact'). Vertical black lines indicate 2-week sampling window used for Fork-Tailed Storm-Petrel analysis (May 01 - May 14).")
figs("ftsp.temp.ph2", "Phase 2 temporal coverage by site. Colour indicates site class ('Control', 'Impact'). Vertical black lines indicate 2-week sampling window used for Fork-Tailed Storm-Petrel analysis (May 01 - May 14).")

figs("ftsp.mean.ph1", "Phase 1, Fork-Tailed Storm-Petrel; Mean proportion of recordings with detected presence (left panel) and more than one individual detected. Color indicates whether island was control or impact; shape indicates island group")
figs("ftsp.mean.ph2", "Phase 2, Fork-Tailed Storm-Petrel; Mean proportion of recordings with detected presence (left panel) and more than one individual detected. Color indicates whether island was control or impact; shape indicates island group")

tbls("ftsp.ph1.1.coef", "Summary model coefficients; Fork-Tailed Storm-Petrel, Phase 1, proportion of recordings with detected presence." )
tbls("ftsp.ph1.1.marg", "BACI marginal means; Fork-Tailed Storm-Petrel, Phase 1, proportion of recordings with detected presence.")
tbls("ftsp.ph1.1.cont", "BACI effect and 95% confidence intervals; Fork-Tailed Storm-Petrel, Phase 1, proportion of recordings with detected presence.")

tbls("ftsp.ph1.2.coef", "Summary model coefficients; Fork-Tailed Storm-Petrel, Phase 1, proportion of recordings with more than one individual detected." )
tbls("ftsp.ph1.2.marg", "BACI marginal means; Fork-Tailed Storm-Petrel, Phase 1, proportion of recordings with more than one individual detected.")
tbls("ftsp.ph1.2.cont", "BACI effect and 95% confidence intervals; Fork-Tailed Storm-Petrel, Phase 1, proportion of recordings with more than one individual detected.")

tbls("ftsp.ph2.1.coef", "Summary model coefficients; Fork-Tailed Storm-Petrel, Phase 2, proportion of recordings with detected presence." )
tbls("ftsp.ph2.1.marg", "BACI marginal means; Fork-Tailed Storm-Petrel, Phase 2, proportion of recordings with detected presence.")
tbls("ftsp.ph2.1.cont", "BACI effect and 95% confidence intervals; Fork-Tailed Storm-Petrel, Phase 2, proportion of recordings with detected presence.")

tbls("ftsp.ph2.2.coef", "Summary model coefficients; Fork-Tailed Storm-Petrel, Phase 2, proportion of recordings with more than one individual detected." )
tbls("ftsp.ph2.2.marg", "BACI marginal means; Fork-Tailed Storm-Petrel, Phase 2, proportion of recordings with more than one individual detected.")
tbls("ftsp.ph2.2.cont", "BACI effect and 95% confidence intervals; Fork-Tailed Storm-Petrel, Phase 2, proportion of recordings with more than one individual detected.")

