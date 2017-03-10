figs <- captioner(prefix = "Figure")
tbls <- captioner(prefix = "Table")

figs("anmu.temp.rats", paste("Temporal coverage by year and site within 14-day sampling window",
                            ' ', '(', month(y.window[1,2], label = TRUE),'-', day(y.window[1,2]), ' - ', month(y.window[1,3], label = TRUE), '-',  day(y.window[1,3]), ')',
                            "; ", "Ancient Murrelet;", " all site:year combinations unaffected by rat eradication.", sep = '')) 

figs("anmu.mean.rats", "Ancient Murrelet; mean logit(proportion) by island and year of recordings with detected presence (left panel) and more than one individual detected (right panel). Means were only calculated from site:year combinations unaffected by rat eradication. Standard error bars are shown where number of sites per island > 1.")

tbls("anmu.1.rats", "Summary of model coefficients: Ancient Murrelet; proportion of recordings with detected presence; all site:year combinations unaffected by rat eradication. All values are logit-transformed unless otherwise stated.")
tbls("anmu.2.rats", "Summary of model coefficients: Ancient Murrelet; proportion of recordings with more than one individual detected; all site:year combinations unaffected by rat eradication. All values are logit-transformed unless otherwise stated.")

figs("caau.temp.rats", paste("Temporal coverage by year and site within 14-day sampling window",
                             ' ', '(', month(y.window[1,2], label = TRUE),'-', day(y.window[1,2]), ' - ', month(y.window[1,3], label = TRUE), '-',  day(y.window[1,3]), ')',
                             "; ", "Cassin's Auklet;", " all site:year combinations unaffected by rat eradication.", sep = '')) 

figs("caau.mean.rats", "Cassin's Auklet; mean logit(proportion) by island and year of recordings with detected presence (left panel) and more than one individual detected (right panel). Means were only calculated from site:year combinations unaffected by rat eradication. Standard error bars are shown where number of sites per island > 1.")

tbls("caau.1.rats", "Summary of model coefficients: Cassin's Auklet; proportion of recordings with detected presence; all site:year combinations unaffected by rat eradication. All values are logit-transformed unless otherwise stated.")
tbls("caau.2.rats", "Summary of model coefficients: Cassin's Auklet; proportion of recordings with more than one individual detected; all site:year combinations unaffected by rat eradication. All values are logit-transformed unless otherwise stated.")

figs("ftsp.temp.rats", paste("Temporal coverage by year and site within 14-day sampling window",
                             ' ', '(', month(y.window[1,2], label = TRUE),'-', day(y.window[1,2]), ' - ', month(y.window[1,3], label = TRUE), '-',  day(y.window[1,3]), ')',
                             "; ", "Fork-Tailed Storm Petrel;", " all site:year combinations unaffected by rat eradication.", sep = '')) 

figs("ftsp.mean.rats", "Fork-Tailed Storm Petrel; mean logit(proportion) by island and year of recordings with detected presence (left panel) and more than one individual detected (right panel). Means were only calculated from site:year combinations unaffected by rat eradication. Standard error bars are shown where number of sites per island > 1.")

tbls("ftsp.1.rats", "Summary of model coefficients: Fork-Tailed Storm Petrel; proportion of recordings with detected presence; all site:year combinations unaffected by rat eradication. All values are logit-transformed unless otherwise stated.")
tbls("ftsp.2.rats", "Summary of model coefficients: Fork-Tailed Storm Petrel; proportion of recordings with more than one individual detected; all site:year combinations unaffected by rat eradication. All values are logit-transformed unless otherwise stated.")
