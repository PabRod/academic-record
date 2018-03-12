parse_academic_production <- function(key) {
  sheet <- "Hoja 1"
  link <- sprintf("https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet={%s}", key, sheet)
  raw <- read.csv(link, encoding='UTF-8', dec=',')
  
  ## Clean the data
  library(tidyverse)
  library(lubridate)
  # library(googlesheets)
  
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
}