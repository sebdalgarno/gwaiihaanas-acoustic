source('header.R')

# coverage 
tempcov_baci = function(data, x, y, color, date.start, date.end) {
  ggplot(data, aes_string(x = x, y = y,  color = color)) + geom_point(size = 1) + theme_bw() +
    labs(x = 'Date', y = 'SiteID', color = 'Site Class') +
    scale_x_datetime(breaks = date_breaks('3 months'), labels = date_format("%b-%Y"))  +
    theme(axis.text.x = element_text(angle = 90, size = 9)) + 
    geom_vline(xintercept = as.numeric(date.start + years(1))) +
    geom_vline(xintercept = as.numeric(date.end + years(1))) +
    geom_vline(xintercept = as.numeric(date.start + years(2))) +
    geom_vline(xintercept = as.numeric(date.end + years(2))) +
    geom_vline(xintercept = as.numeric(date.start + years(3))) +
    geom_vline(xintercept = as.numeric(date.end + years(3))) +
    geom_vline(xintercept = as.numeric(date.start + years(4))) +
    geom_vline(xintercept = as.numeric(date.end + years(4))) +
    geom_vline(xintercept = as.numeric(date.start + years(5))) +
    geom_vline(xintercept = as.numeric(date.end + years(5))) 
    # geom_vline(xintercept = as.numeric(as.POSIXct(paste(vline, '11-01', sep = '-')), tz = tz_data), color = 'blue')
}

tempcov_baci(data = filter(sea, phase1 == 1 & species == sp[1]), x = 'night', y = 'siteID', color = 'exp', 
             date.start = y.window[1,2], date.end = y.window[1,3])
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






  
