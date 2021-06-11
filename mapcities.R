rm(list = ls())
graphics.off()

library(maps)
library(dplyr)

spain.cities <- filter(world.cities, country.etc == 'Spain')

spain.cities.big <- filter(spain.cities, pop > 150000)

spain.cities.withname <- filter(spain.cities, grepl('Po', name))

cities <- c('Sevilla', 'Valladolid', 'Madrid', 'Bilbao', 'San Sebastian', 'London', 'Exeter', 'Linz', 
            'Jena', 'Goslar', 'Wageningen', 'Utrecht', 'Kerkyra', 'Cork')
spain.cities.list <- filter(world.cities, is.element(name, cities))

map('world', c('Spain', 'France', 'Belgium', 'Portugal', 'Netherlands', 'UK', 'Germany', 'Austria', 'Greece', 'Ireland'),
    bg = 'lightblue', interior = TRUE, fill = TRUE, col = 'pink')
map.cities(spain.cities.list, label = TRUE)
