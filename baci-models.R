
source('baci-prep.R')

antilogit <- function(x) { exp(x) / (1 + exp(x) ) }
# function to fit lmer model
lmer_fit = function(data, period) {
  form = formula(paste('prop~', period, '+ exp +', period,':exp + (1|yearf) + (1|island/site)'))
  lmerTest::lmer(formula = form, data = data)
}

# fit models
anmu.ph2.1 <- lmer_fit(data = dplyr::filter(baci, species == sp[1] & phase2 == 1 & propType == 'p(presence)'), period = 'PeriodPh2')
anmu.ph2.2 <- lmer_fit(data = dplyr::filter(baci, species == sp[1] & phase2 == 1 & propType == 'p(presence>1)'), period = 'PeriodPh2')
anmu.ph1.1 <- lmer_fit(data = dplyr::filter(baci, species == sp[1] & phase1 == 1 & propType == 'p(presence)'), period = 'PeriodPh1')
anmu.ph1.2 <- lmer_fit(data = dplyr::filter(baci, species == sp[1] & phase1 == 1 & propType == 'p(presence>1)'), period = 'PeriodPh1')

caau.ph2.1 <- lmer_fit(data = dplyr::filter(baci, species == sp[2] & phase2 == 1 & propType == 'p(presence)'), period = 'PeriodPh2')
caau.ph2.2 <- lmer_fit(data = dplyr::filter(baci, species == sp[2] & phase2 == 1 & propType == 'p(presence>1)'), period = 'PeriodPh2')
caau.ph1.1 <- lmer_fit(data = dplyr::filter(baci, species == sp[2] & phase1 == 1 & propType == 'p(presence)'), period = 'PeriodPh1')
caau.ph1.2 <- lmer_fit(data = dplyr::filter(baci, species == sp[2] & phase1 == 1 & propType == 'p(presence>1)'), period = 'PeriodPh1')

ftsp.ph2.1 <- lmer_fit(data = dplyr::filter(baci, species == sp[3] & phase2 == 1 & propType == 'p(presence)'), period = 'PeriodPh2')
ftsp.ph2.2 <- lmer_fit(data = dplyr::filter(baci, species == sp[3] & phase2 == 1 & propType == 'p(presence>1)'), period = 'PeriodPh2')
ftsp.ph1.1 <- lmer_fit(data = dplyr::filter(baci, species == sp[3] & phase1 == 1 & propType == 'p(presence)'), period = 'PeriodPh1')
ftsp.ph1.2 <- lmer_fit(data = dplyr::filter(baci, species == sp[3] & phase1 == 1 & propType == 'p(presence>1)'), period = 'PeriodPh1')

# summary - coefficients
summary_coef = function(model) {
  coef <- as.data.frame(coef(summary(model)))
  rownames(coef) <- c('Intercept', 'TimePeriod', 'Treatment', 'TimePeriod:Treatment')
  coef %<>% mutate(Term = rownames(coef), Estimate = round(Estimate, 2), SE = round(`Std. Error`, 2), 
                   df = round(df, 1), `p-value` = round(`Pr(>|t|)`, 3)) %>%
    select(Term, Estimate, SE, df, `p-value`) 
    
  return(coef)
}

summary_coef(anmu.ph2.1)

# summary - marginal means
summary_marg = function(model, period) {
  marg.means <- as.data.frame(summary(lsmeans::lsmeans(model, specs = c('exp', period)))) %>%
    select_('Treatment' = 'exp', 'Time Period' = period,
            'Marginal Mean' = 'lsmean', 'SE', 'df',
           'Lower CL' = 'lower.CL', 'Upper CL' = 'upper.CL') %>%
    mutate(`Logit(proportion)` = round(`Marginal Mean`, 2), `Proportion` = round(antilogit(`Marginal Mean`), 2),  SE = round(SE, 2), df = round(df, 1),
           'Lower CL' = round(`Lower CL`, 2), 'Upper CL' = round(`Upper CL`, 2)) %>%
    
    select(Treatment, `Time Period`, `Logit(proportion)`, SE, df, `Lower CL`, `Upper CL`, `Proportion`)
}


# summary - contrast + confint
summary_cont = function(model, period) {
  marg <- lsmeans::lsmeans(model, specs = c('exp', period))
  contr <- lsmeans::contrast(marg, list(baci = c(1, -1, -1, 1)))
  confint <- confint(lsmeans::contrast(marg, list(baci = c(1, -1, -1, 1))))
  df <- data.frame(Estimate = round(confint$estimate, 2), expEst = round(exp(confint$estimate), 2),
                   SE = round(confint$SE, 2), lowercl = round(confint$lower.CL, 2), uppercl = round(confint$upper.CL, 2),
                        df = round(confint$df, 1), pvalue = round(summary(contr)[1,6], 3)) %>%
    select(Estimate, SE, `Lower CL` = lowercl, `Upper CL` = uppercl, `p-value` = pvalue, `exp(Estimate)` = expEst)
}

# variance
# VarCorr(lmer.anmu.ph2.1)
