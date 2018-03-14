parse_academic_production <- function(key) {
  ## Download using read-only link
  # As seen here: https://stackoverflow.com/questions/42461806/getting-a-csv-read-into-r-though-a-shareable-google-drive-link
  
  sheet <- "Hoja 1"
  link <- sprintf("https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet={%s}", key, sheet)
  raw <- read.csv(link, encoding='UTF-8', dec=',')
  
  ## Clean the data
  library(dplyr)
  library(lubridate)
  #library(urlshorteneR)
  #shortener_authenticate("86368629146-2ag2qh1j4c26mf5dtm5p7gi85esn3i.apps.googleusercontent.com", "55Y3NsWjiic5Uv8mT-YNMWlK")
  
  tidy <- raw # By default, everything is understood as a factor
  
  # Read dates
  tidy <- mutate(tidy, 
                 Date = dmy(Date),
                 End.date = dmy(End.date),
                 Pay.day = dmy(Pay.day))
  
  # Read text
  tidy <- mutate(tidy,
                 Name = as.character(Name),
                 URL = as.character(URL),
                 Author = as.character(Author))
  
  # Read geographical information
  tidy <- mutate(tidy,
                 City = as.character(City),
                 Country = as.character(Country))
  
  # Read numbers
  tidy <- mutate(tidy, 
                 ECTS = as.numeric(ECTS))
  
  # Read money
  tidy <- mutate(tidy, 
                 Amount = as.numeric(Amount))
  
  #tidy <- mutate(tidy, URL_short = shorten.google(URL))
}


plot_map <- function(countries) {
  library(maptools)
  
  data(wrld_simpl)
  myCountries = wrld_simpl@data$NAME %in% countries
  plot(wrld_simpl, xlim = c(0,10), ylim = c(35,60), bg='lightblue', col = c('lightgrey', 'olivedrab3')[myCountries+1])
}