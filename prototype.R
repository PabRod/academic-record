## Clean environment
rm(list = ls())
source('auxs.R')

## Download using read-only link
# As seen here: https://stackoverflow.com/questions/42461806/getting-a-csv-read-into-r-though-a-shareable-google-drive-link
key <- "1DVLcKvMLVrdkn2kRO-X-_KADaqVnhM4yyWddP-UN-40"
tidy <- parse_academic_production(key)

## TODO:
# Clean (at least) the fields you want to keep hidden (or secret?)
# Export as citation
# Make it accessible through a Shiny app

## Extract relevant information
total_amount <- sum(tidy$Amount, na.rm = TRUE)