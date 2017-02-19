source('header.R')

# coverage 
tempcov_baci = function(data, x, y, color, date.start, date.end) {
  ggplot(data, aes_string(x = x, y = y,  color = color)) + geom_point(size = 1) + theme_bw() +
    labs(x = 'Date', y = 'SiteID', color = 'Site Class') +
    scale_x_datetime(breaks = date_breaks('3 months'), labels = date_format("%b-%Y"))  +
    theme(axis.text.x = element_text(angle = 90, size = 9)) + 
    geom_vline(xintercept = as.numeric(as.POSIXct(paste('2010-', date.start, '-',' ', "00:", "00:", "00", sep = '')))) +
    geom_vline(xintercept = as.numeric(as.POSIXct(paste('2010-', date.end, '-',' ', "00:", "00:", "00", sep = '')))) +
    geom_vline(xintercept = as.numeric(as.POSIXct(paste('2011-', date.start, '-',' ', "00:", "00:", "00", sep = '')))) +
    geom_vline(xintercept = as.numeric(as.POSIXct(paste('2011-', date.end, '-',' ', "00:", "00:", "00", sep = '')))) +
    geom_vline(xintercept = as.numeric(as.POSIXct(paste('2012-', date.start, '-',' ', "00:", "00:", "00", sep = '')))) +
    geom_vline(xintercept = as.numeric(as.POSIXct(paste('2012-', date.end, '-',' ', "00:", "00:", "00", sep = '')))) +
    geom_vline(xintercept = as.numeric(as.POSIXct(paste('2013-', date.start, '-',' ', "00:", "00:", "00", sep = '')))) +
    geom_vline(xintercept = as.numeric(as.POSIXct(paste('2013-', date.end, '-',' ', "00:", "00:", "00", sep = '')))) +
    geom_vline(xintercept = as.numeric(as.POSIXct(paste('2014-', date.start, '-',' ', "00:", "00:", "00", sep = '')))) +
    geom_vline(xintercept = as.numeric(as.POSIXct(paste('2014-', date.end, '-',' ', "00:", "00:", "00", sep = '')))) +
    geom_vline(xintercept = as.numeric(as.POSIXct(paste('2015-', date.start, '-',' ', "00:", "00:", "00", sep = '')))) +
    geom_vline(xintercept = as.numeric(as.POSIXct(paste('2015-', date.end, '-',' ', "00:", "00:", "00", sep = '')))) 
}


# props x island
island_props = function(data, vline) {
  ggplot(data, aes(x = year, y = mean.prop,  color = exp, shape = island)) +
    facet_wrap(~propType) + geom_point(size = 2.4, position = position_dodge(width = 0.1)) + geom_line() +
    theme_bw() + geom_vline(xintercept = vline) + labs(x = 'Year', y = 'Logit (mean proportion)', color = 'Site Class', shape = 'Island Group')
}

# # # diagnostic plots
# plot_diag = function(model) {
#   # residuals vs. fitted
#   resid.fit <- as.data.frame(cbind(Fitted = fitted(model), Residuals= resid(model)))
#   ggplot(data = resid.fit, aes(x = Fitted, y = Residuals)) + geom_point() +theme_bw()
#   
#   # qqplot normality
#   randoms <- ranef(model, postVar = TRUE)
#   qq <- attr(ranef(model, postVar = TRUE)[[1]], 'postVar')
#   read.interc <- randoms$Batch
#   qqdf <- as
#   qqmath(lmer.anmu.ph2.1)
#   plot(lmer.anmu.ph2.1)
# }






  
