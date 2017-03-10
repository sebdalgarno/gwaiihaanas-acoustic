tempcov_rats_win = function(data, x, y, color) {
  ggplot(data, aes_string(x = x, y = y,  color = color)) + geom_point(size = 1.2) + 
    theme_bw() + facet_wrap(.(year), ncol = 6) + theme(panel.spacing = unit(0, "lines")) +
    labs(x = 'Date', y = 'Site', color = 'Rat Status') +
    scale_x_datetime(breaks = date_breaks('2 day'), labels = date_format("%b-%e"))  +
    theme(axis.text.x = element_text(angle = 90)) + theme_big}

tempcov_rats_win(data = filter(seaprep, Impact == 0 & species == sp[1]),
                 x = 'night.ny', y = 'site', color = 'rats')

rat_props = function(data) {
  ggplot(data, aes(x = year, y = mean,  color = island, shape = rats)) +
    geom_point(size = 2, position = position_dodge(width = 0.1)) + facet_wrap(~propType) +
    geom_errorbar(aes(year, ymin = lower, ymax = upper), width = 0.2) +
    theme_bw() + labs(x = 'Year', y = 'Mean logit (proportion)', color = 'Island', shape = "Rat Status") + 
    theme_big
}


