## Clean environment
rm(list = ls())

## Download using read-only link
# As seen here: https://stackoverflow.com/questions/42461806/getting-a-csv-read-into-r-though-a-shareable-google-drive-link
key <- "1NEQkPGVakj7XGFUkWe8alNsyTulrJuPqgAROqaPoSi0"
sheet <- "Hoja 1"
link <- sprintf("https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet={%s}", key, sheet)
stuff <- read.csv(link, encoding='UTF-8')
