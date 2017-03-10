antilogit <- function(x) { exp(x) / (1 + exp(x) ) }
# function to fit lmer model
lmer_rats = function(data) {
  lmerTest::lmer(prop ~ rats + year + (1|yearf) + (1|island/site), data = data)
}

lmer_ratint = function(data) {
  lmerTest::lmer(prop ~ rats + year + rats:year + (1|yearf) + (1|island/site), data = data)
}

lmer_yearf = function(data) {
  lmerTest::lmer(prop ~ rats + yearf + (1|island/site), data = data)
}

anmu.1 = lmer_rats(data = filter(rats, propType == 'p(presence)' & species == sp[1]))
anmu.2 = lmer_rats(filter(rats, propType == 'p(presence>1)' & species == sp[1]))

caau.1 = lmer_rats(filter(rats, propType == 'p(presence)' & species == sp[2]))
caau.2 = lmer_rats(filter(rats, propType == 'p(presence>1)' & species == sp[2]))

ftsp.1 = lmer_rats(filter(rats, propType == 'p(presence)' & species == sp[3]))
ftsp.2 = lmer_rats(filter(rats, propType == 'p(presence>1)' & species == sp[3]))

anmu.f.1 = lmer_yearf(data = filter(rats, propType == 'p(presence)' & species == sp[1]))
anmu.f.2 = lmer_yearf(filter(rats, propType == 'p(presence>1)' & species == sp[1]))

caau.f.1 = lmer_yearf(filter(rats, propType == 'p(presence)' & species == sp[2]))
caau.f.2 = lmer_yearf(filter(rats, propType == 'p(presence>1)' & species == sp[2]))

ftsp.f.1 = lmer_yearf(filter(rats, propType == 'p(presence)' & species == sp[3]))
ftsp.f.2 = lmer_yearf(filter(rats, propType == 'p(presence>1)' & species == sp[3]))

anmu.i.1 = lmer_ratint(data = filter(rats, propType == 'p(presence)' & species == sp[1]))
anmu.i.2 = lmer_ratint(filter(rats, propType == 'p(presence>1)' & species == sp[1]))

caau.i.1 = lmer_ratint(filter(rats, propType == 'p(presence)' & species == sp[2]))
caau.i.2 = lmer_ratint(filter(rats, propType == 'p(presence>1)' & species == sp[2]))

ftsp.i.1 = lmer_ratint(filter(rats, propType == 'p(presence)' & species == sp[3]))
ftsp.i.2 = lmer_ratint(filter(rats, propType == 'p(presence>1)' & species == sp[3]))

summary_rats = function(model) {
  coef <- as.data.frame(coef(summary(model)))
  rownames(coef) <- c('Intercept', 'Rat Status', 'Year')
  coef %<>% mutate(Term = rownames(coef), Estimate = round(Estimate, 3), SE = round(`Std. Error`, 3), 
                   df = round(df, 1), `p-value` = round(`Pr(>|t|)`, 3)) %>%
    select(Term, Estimate, SE, df, `p-value`) 
  
  return(coef)
}

