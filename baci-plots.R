source('header.R')

# coverage 
tempcov_baci_all = function(data, x, y, color, date.start, date.end) {
  ggplot(data, aes_string(x = x, y = y,  color = color)) + geom_point(size = 0.8) + 
    theme_bw() + facet_wrap(.(year), ncol = 6) + theme(panel.spacing = unit(0, "lines")) +
    labs(x = 'Date', y = 'Site', color = 'Treatment') +
    scale_x_datetime(breaks = date_breaks('1 month'), labels = date_format("%b"))  +
    theme(axis.text.x = element_text(angle = 90, size = 9)) + 
    geom_vline(xintercept = as.numeric(date.start)) +
    geom_vline(xintercept = as.numeric(date.end)) + theme_big
    # geom_vline(xintercept = as.numeric(as.POSIXct(paste(vline, '11-01', sep = '-')), tz = tz_data), color = 'blue')
}

tempcov_baci_win = function(data, x, y, color, date.start, date.end) {
  ggplot(data, aes_string(x = x, y = y,  color = color)) + geom_point(size = 1.2) + 
    theme_bw() + facet_wrap(.(year), ncol = 6) + theme(panel.spacing = unit(0, "lines")) +
    labs(x = 'Date', y = 'Site', color = 'Treatment') +
    scale_x_datetime(breaks = date_breaks('2 day'), labels = date_format("%b-%e"))  +
    theme(axis.text.x = element_text(angle = 90)) + theme_big
  # geom_vline(xintercept = as.numeric(as.POSIXct(paste(vline, '11-01', sep = '-')), tz = tz_data), color = 'blue')
}
# tempcov_baci(data = filter(sea, phase1 == 1 & species == sp[1]), x = 'ynight', y = 'siteID', color = 'exp', date.start = y.window[1,2], date.end = y.window[1,3])
# 
# tempcov_baci_win(data = filter(sea, phase1 == 1 & species == sp[1] & yday(ynight) >= yday(y.window[1,2]) & yday(ynight) <= yday(y.window[1,3])), x = 'ynight', y = 'siteID', color = 'exp', date.start = y.window[1,2], date.end = y.window[1,3])

# props x island
island_props = function(data, vline) {
  ggplot(data, aes(x = year, y = mean.prop,  color = exp, shape = island)) +
    facet_wrap(~propType) + geom_point(size = 2.4, position = position_dodge(width = 0.1)) + geom_line() +
    theme_bw() + geom_vline(xintercept = vline) + labs(x = 'Year', y = 'Mean logit(proportion)', color = 'Treatment', shape = 'Island') + 
    theme_big
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






  
