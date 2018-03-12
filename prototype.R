## Clean environment
rm(list = ls())
library(tidyverse)

source('auxs.R')

## Get the data
key <- "1DVLcKvMLVrdkn2kRO-X-_KADaqVnhM4yyWddP-UN-40"
tidy <- parse_academic_production(key)

## TODO:
# Clean (at least) the fields you want to keep hidden (or secret?)
# Export as citation
# Make it accessible through a Shiny app

## Extract relevant information
total_amount <- sum(tidy$Amount, na.rm = TRUE)

sci_comm <- filter(tidy, Type == 'Article', 
                 Description == 'Naukas' |
                 Description == 'CCC' | 
                 Description == 'Next Door' | 
                 Description == 'Mapping ignorance')

## Plot some results
hist(sci_comm$Date, breaks=20)

plot_map(tidy$Country)
