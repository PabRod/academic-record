get_data <- function(key, save_backup = TRUE)
  
  tryCatch(
  {
    data <- parse_academic_production(key)
    if (save_backup) {
      save(data, file=paste(backups_dir, '/backup.Rda', sep =''))
      write.csv(data, file=paste(backups_dir, '/backup.csv', sep =''), fileEncoding='UTF-8')
    }
    return(data)
  },
  error = function(cond){
    message('Unable to access URL. Using backup version')
    
    load('./backups/backup.Rda')
    return(data)
  }
  
)

parse_academic_production <- function(key) {
  ## Download using read-only link
  # As seen here: https://stackoverflow.com/questions/42461806/getting-a-csv-read-into-r-though-a-shareable-google-drive-link
  
  ## Load required libraries
  library(dplyr)
  library(lubridate)
  
  ## Download the data
  sheet <- "Hoja 1"
  link <- sprintf("https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet={%s}", key, sheet)
  raw <- read.csv(link, encoding='UTF-8', dec=',')
  
  ## Clean the data
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
  
  # Combine name and URL in a clickable string for electronic publications
  tidy <- mutate(tidy, 
                 NameURL = case_when(
                   URL == "" ~ Name,
                   URL != "" ~ paste0("[", Name, "](", URL, ")"))
                   )
}


plot_map <- function(countries) {
  library(maptools)
  
  data(wrld_simpl)
  myCountries = wrld_simpl@data$NAME %in% countries
  plot(wrld_simpl, xlim = c(0,10), ylim = c(35,60), bg='lightblue', col = c('lightgrey', 'olivedrab3')[myCountries+1])
}

updateHeader <- function(input, output, encoding='utf-8') {
  new_date <- format(Sys.time(), '%m/%d/%Y, %H:%M:%S')
  date_of_modification <- paste('Modified:', new_date)
  header_base <- readLines(input, encoding = encoding)
  header_with_date <- c(header_base, date_of_modification)
  writeLines(header_with_date, con = output)
}