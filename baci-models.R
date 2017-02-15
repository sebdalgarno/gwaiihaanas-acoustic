source('header.R')
source('baci-prep.R')

########## Phase 2 ##########
### ANMU
# model
# lmer
lmer.anmu.ph2.1 <- lmerTest::lmer(mean.prop ~ period + exp + period:exp + (1|yearf) + (1|island), data = mean.anmu)
summary(lmer.anmu.ph2.1)

# lme
# lme.anmu.ph2.1 <- lme(mean.prop ~ period + exp + period:exp, data = mean.anmu, random = list(~1|yearf, ~1|island))
# summary(lm.anmu.ph2.1)
# anova(lm.anmu.ph2.1)

# marginal means
lmer.anmu.ph2.1.marg <- lsmeans::lsmeans(lmer.anmu.ph2.1, ~exp:period)
summary(lmer.anmu.ph2.1.marg)

# baci contrast and se
confint(contrast(lmer.anmu.ph2.1.marg, list(baci=c(1,-1,-1,1))))
contrast(lmer.anmu.ph2.1.marg, list(baci=c(1,-1,-1,1)))

# variance
VarCorr(lmer.anmu.ph2.1)
