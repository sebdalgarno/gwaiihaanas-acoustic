
figs <- captioner(prefix = "Figure")
tbls <- captioner(prefix = "Table")

### BACI
# ANMU
figs("anmu.temp.ph1", paste("Phase 1 temporal coverage by site within 14-day sampling window",
                            ' ', '(', month(y.window[1,2], label = TRUE),'-', day(y.window[1,2]), ' - ', month(y.window[1,3], label = TRUE), '-',  day(y.window[1,3]), ')',
                            "; ", "Ancient Murrelet.", sep = '')) 
figs("anmu.temp.ph2", paste("Phase 2 temporal coverage by site within 14-day sampling window",
                            ' ', '(', month(y.window[1,2], label = TRUE),'-', day(y.window[1,2]), ' - ', month(y.window[1,3], label = TRUE), '-',  day(y.window[1,3]), ')',
                            "; ", "Ancient Murrelet.", sep = ''))
     
figs("anmu.mean.ph1", "Phase 1, Ancient Murrelet; Mean logit(proportion) by island of recordings by with detected presence (left panel) and more than one individual detected (right panel). Standard error bars are shown in cases where number of sites within each island > 1.")
figs("anmu.mean.ph2", "Phase 2, Ancient Murrelet; Mean logit(proportion) by island of recordings by with detected presence (left panel) and more than one individual detected (right panel). Standard error bars are shown in cases where number of sites within each island > 1.")

tbls("anmu.ph1.1.cont", "BACI effect and 95% confidence intervals; Ancient Murrelet, Phase 1, proportion of recordings with detected presence. All values are logit-transformed unless otherwise stated.")
tbls("anmu.ph1.1.marg", "BACI marginal means; Ancient Murrelet, Phase 1, proportion of recordings with detected presence. Confidence limits and SE are in the logit scale. Proportion was back-transformed using antilogit. Proportion was back-transformed using antilogit.")

tbls("anmu.ph1.2.cont", "BACI effect and 95% confidence intervals; Ancient Murrelet, Phase 1, proportion of recordings with more than one individual detected. All values are logit-transformed unless otherwise stated.")
tbls("anmu.ph1.2.marg", "BACI marginal means; Ancient Murrelet, Phase 1, proportion of recordings with more than one individual detected. Confidence limits and SE are in the logit scale. Proportion was back-transformed using antilogit.")

tbls("anmu.ph2.1.cont", "BACI effect and 95% confidence intervals; Ancient Murrelet, Phase 2, proportion of recordings with detected presence. All values are logit-transformed unless otherwise stated.")
tbls("anmu.ph2.1.marg", "BACI marginal means; Ancient Murrelet, Phase 2, proportion of recordings with detected presence. Confidence limits and SE are in the logit scale. Proportion was back-transformed using antilogit.")

tbls("anmu.ph2.2.cont", "BACI effect and 95% confidence intervals; Ancient Murrelet, Phase 2, proportion of recordings with more than one individual detected. All values are logit-transformed unless otherwise stated.")
tbls("anmu.ph2.2.marg", "BACI marginal means; Ancient Murrelet, Phase 2, proportion of recordings with more than one individual detected. Confidence limits and SE are in the logit scale. Proportion was back-transformed using antilogit.")

# CAAU
figs("caau.temp.ph1",paste("Phase 1 temporal coverage by site within 14-day sampling window",
                           ' ', '(', month(y.window[2,2], label = TRUE),'-', day(y.window[2,2]), ' - ', month(y.window[2,3], label = TRUE), '-',  day(y.window[2,3]), ')',
                           "; ", "Cassin's Auklet.", sep = ''))
figs("caau.temp.ph2", paste("Phase 2 temporal coverage by site within 14-day sampling window",
                                  ' ', '(', month(y.window[2,2], label = TRUE),'-', day(y.window[2,2]), ' - ', month(y.window[2,3], label = TRUE), '-',  day(y.window[2,3]), ')',
                                  "; ", "Cassin's Auklet.", sep = ''))

figs("caau.mean.ph1", "Phase 1, Cassin's Auklet; Mean logit(proportion) by island of recordings by with detected presence (left panel) and more than one individual detected (right panel). Standard error bars are shown in cases where number of sites within each island > 1.")
figs("caau.mean.ph2", "Phase 2, Cassin's Auklet; Mean logit(proportion) by island of recordings by with detected presence (left panel) and more than one individual detected (right panel). Standard error bars are shown in cases where number of sites within each island > 1.")

tbls("caau.ph1.1.cont", "BACI effect and 95% confidence intervals; Cassin's Auklet, Phase 1, proportion of recordings with detected presence. All values are logit-transformed unless otherwise stated.")
tbls("caau.ph1.1.marg", "BACI marginal means; Cassin's Auklet, Phase 1, proportion of recordings with detected presence. Confidence limits and SE are in the logit scale. Proportion was back-transformed using antilogit.")

tbls("caau.ph1.2.cont", "BACI effect and 95% confidence intervals; Cassin's Auklet, Phase 1, proportion of recordings with more than one individual detected. All values are logit-transformed unless otherwise stated.")
tbls("caau.ph1.2.marg", "BACI marginal means; Cassin's Auklet, Phase 1, proportion of recordings with more than one individual detected. Confidence limits and SE are in the logit scale. Proportion was back-transformed using antilogit.")

tbls("caau.ph2.1.cont", "BACI effect and 95% confidence intervals; Cassin's Auklet, Phase 2, proportion of recordings with detected presence. All values are logit-transformed unless otherwise stated.")
tbls("caau.ph2.1.marg", "BACI marginal means; Cassin's Auklet, Phase 2, proportion of recordings with detected presence. Confidence limits and SE are in the logit scale. Proportion was back-transformed using antilogit.")

tbls("caau.ph2.2.cont", "BACI effect and 95% confidence intervals; Cassin's Auklet, Phase 2, proportion of recordings with more than one individual detected. All values are logit-transformed unless otherwise stated.")
tbls("caau.ph2.2.marg", "BACI marginal means; Cassin's Auklet, Phase 2, proportion of recordings with more than one individual detected. Confidence limits and SE are in the logit scale. Proportion was back-transformed using antilogit.")

# FTSP
figs("ftsp.temp.ph1", paste("Phase 1 temporal coverage by site within 14-day sampling window",
                            ' ', '(', month(y.window[3,2], label = TRUE),'-', day(y.window[3,2]), ' - ', month(y.window[3,3], label = TRUE), '-',  day(y.window[3,3]), ')',
                            "; ", "Fork-Tailed Storm Petrel.", sep = ''))
figs("ftsp.temp.ph2", paste("Phase 1 temporal coverage by site within 14-day sampling window",
                            ' ', '(', month(y.window[3,2], label = TRUE),'-', day(y.window[3,2]), ' - ', month(y.window[3,3], label = TRUE), '-',  day(y.window[3,3]), ')',
                            "; ", "Fork-Tailed Storm Petrel.", sep = ''))
figs("ftsp.mean.ph1", "Phase 1, Fork-Tailed Storm-Petrel; Mean logit(proportion) by island of recordings by with detected presence (left panel) and more than one individual detected (right panel). Standard error bars are shown in cases where number of sites within each island > 1.")
figs("ftsp.mean.ph2", "Phase 2, Fork-Tailed Storm-Petrel; Mean logit(proportion) by island of recordings by with detected presence (left panel) and more than one individual detected (right panel). Standard error bars are shown in cases where number of sites within each island > 1.")

tbls("ftsp.ph1.1.cont", "BACI effect and 95% confidence intervals; Fork-Tailed Storm-Petrel, Phase 1, proportion of recordings with detected presence. All values are logit-transformed unless otherwise stated.")
tbls("ftsp.ph1.1.marg", "BACI marginal means; Fork-Tailed Storm-Petrel, Phase 1, proportion of recordings with detected presence. Confidence limits and SE are in the logit scale. Proportion was back-transformed using antilogit.")

tbls("ftsp.ph1.2.cont", "BACI effect and 95% confidence intervals; Fork-Tailed Storm-Petrel, Phase 1, proportion of recordings with more than one individual detected. All values are logit-transformed unless otherwise stated.")
tbls("ftsp.ph1.2.marg", "BACI marginal means; Fork-Tailed Storm-Petrel, Phase 1, proportion of recordings with more than one individual detected. Confidence limits and SE are in the logit scale. Proportion was back-transformed using antilogit.")

tbls("ftsp.ph2.1.cont", "BACI effect and 95% confidence intervals; Fork-Tailed Storm-Petrel, Phase 2, proportion of recordings with detected presence. All values are logit-transformed unless otherwise stated.")
tbls("ftsp.ph2.1.marg", "BACI marginal means; Fork-Tailed Storm-Petrel, Phase 2, proportion of recordings with detected presence. Confidence limits and SE are in the logit scale. Proportion was back-transformed using antilogit.")

tbls("ftsp.ph2.2.cont", "BACI effect and 95% confidence intervals; Fork-Tailed Storm-Petrel, Phase 2, proportion of recordings with more than one individual detected. All values are logit-transformed unless otherwise stated.")
tbls("ftsp.ph2.2.marg", "BACI marginal means; Fork-Tailed Storm-Petrel, Phase 2, proportion of recordings with more than one individual detected. Confidence limits and SE are in the logit scale. Proportion was back-transformed using antilogit.")

tbls("anmu.ph1.1.coef", "Summary model coefficients; Ancient Murrelet, Phase 1, proportion of recordings with detected presence. All values are logit-transformed unless otherwise stated." )
tbls("anmu.ph1.2.coef", "Summary model coefficients; Ancient Murrelet, Phase 1, proportion of recordings with more than one individual detected. All values are logit-transformed unless otherwise stated." )
tbls("anmu.ph2.1.coef", "Summary model coefficients; Ancient Murrelet, Phase 2, proportion of recordings with detected presence. All values are logit-transformed unless otherwise stated." )
tbls("anmu.ph2.2.coef", "Summary model coefficients; Ancient Murrelet, Phase 2, proportion of recordings with more than one individual detected. All values are logit-transformed unless otherwise stated." )
tbls("caau.ph1.1.coef", "Summary model coefficients; Cassin's Auklet, Phase 1, proportion of recordings with detected presence. All values are logit-transformed unless otherwise stated." )
tbls("caau.ph1.2.coef", "Summary model coefficients; Cassin's Auklet, Phase 1, proportion of recordings with more than one individual detected. All values are logit-transformed unless otherwise stated." )
tbls("caau.ph2.1.coef", "Summary model coefficients; Cassin's Auklet, Phase 2, proportion of recordings with detected presence. All values are logit-transformed unless otherwise stated." )
tbls("caau.ph2.2.coef", "Summary model coefficients; Cassin's Auklet, Phase 2, proportion of recordings with more than one individual detected. All values are logit-transformed unless otherwise stated." )
tbls("ftsp.ph1.1.coef", "Summary model coefficients; Fork-Tailed Storm-Petrel, Phase 1, proportion of recordings with detected presence. All values are logit-transformed unless otherwise stated." )
tbls("ftsp.ph1.2.coef", "Summary model coefficients; Fork-Tailed Storm-Petrel, Phase 1, proportion of recordings with more than one individual detected. All values are logit-transformed unless otherwise stated." )
tbls("ftsp.ph2.1.coef", "Summary model coefficients; Fork-Tailed Storm-Petrel, Phase 2, proportion of recordings with detected presence. All values are logit-transformed unless otherwise stated." )
tbls("ftsp.ph2.2.coef", "Summary model coefficients; Fork-Tailed Storm-Petrel, Phase 2, proportion of recordings with more than one individual detected. All values are logit-transformed unless otherwise stated." )

