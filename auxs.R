get_data <- function(key, save_backup = TRUE, ignore_future = TRUE)
  # Gets and cleans the data from my GoogleDrive spreadsheet. Additionally it saves Rda and csv backups.
  #
  # Args:
  #   key: The key string for sharing the content of the data base (I keep it private)
  #   save_backup (Optional): TRUE/FALSE for saving / not saving backup
  #   ignore_future (Optional): TRUE for filtering out future publications/entries
  #
  # Returns:
  #   A data frame version of the spreadsheet

  # Try to connect to GoogleDrive data base
  tryCatch(
  {
    data <- parse_academic_production(key)

    # Save backup if required
    if (save_backup) {
      # Save as .Rda
      save(data, file=paste(config$backups_dir[1], '/backup.Rda', sep =''))

      # Save as .csv
      #
      # Less handy than .Rda, but more readable being plain text
      write.csv(data, file=paste(config$backups_dir[1], '/backup.csv', sep =''), fileEncoding='UTF-8')

      # Save an example containing the basic structure
      #
      # The GoogleDrive sheet is not public, and it is evolving simultaneously with this project
      # This file helps keeping track of changes without compromising privacy
      empty_data <- filter(data, Country == 'Unexistent')
      write.csv(empty_data, file=paste(config$backups_dir[1], '/example.csv', sep =''), fileEncoding='UTF-8')
    }

    # Arrange by descending date
    library(dplyr)
    data <- arrange(data, desc(Date))

    # Filter future if required
    if(ignore_future) {
      library(lubridate)
      data <- filter(data, Date <= today())
    }

    return(data)
  },
  error = function(cond){ # If the connection fails, load from latest backup
    message('Unable to access URL. Using backup version')

    load(paste(config$backups_dir[1], '/backup.Rda', sep=''))
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

get_flag <- function(countryName, width=30, height=20) {
  # Returns the url of a properly formatted national flag. Source: http://flagpedia.net/
  #
  # Args:
  #   countryName: Name(s) of the country or countries (in English)
  #   width (Optional): Width in px
  #   heigth (Optional): height in px
  #
  # Returns:
  #   The url of the flag(s)
  library(countrycode)
  code <- countrycode(countryName, origin='country.name', destination='iso2c')

  flagURL <- sprintf('<img src="http://flagpedia.net/data/flags/mini/%s.png" alt="Drawing" title="%s" style="width: %dpx; height: %dpx"/>', tolower(code), countryName, width, height)
}

plot_map <- function(countries) {
  library(maptools)

  data(wrld_simpl)
  myCountries = wrld_simpl@data$NAME %in% countries
  plot(wrld_simpl, xlim = c(0,10), ylim = c(35,60), bg='lightblue', col = c('lightgrey', 'olivedrab3')[myCountries+1])
}

plot_cities <- function(data) {
  library(maps)
  library(dplyr)

  data(world.cities)
  visited.cities <- filter(world.cities, is.element(name, data$City) & is.element(country.etc, data$Country))

  map('world', xlim = c(-20, 40), ylim = c(35, 60), bg = 'lightblue', interior = TRUE, fill = TRUE, col = 'lightgray')
  map.cities(visited.cities, label = FALSE, pch = '.', cex = 10, col = 'red')
}

updateHeader <- function(input, output, encoding='utf-8') {
  # Generates an output markdown file appending the line: 'Modified: {current date}'
  #
  # Args:
  #   input: Input markdown file containing the header.
  #   output: Output markdown file.
  #
  # Returns:
  #   Void, after creating/updating the file.

  new_date <- format(Sys.time(), '%m/%d/%Y, %H:%M:%S')
  date_of_modification <- paste('Modified:', new_date)
  header_base <- readLines(input, encoding = encoding)
  header_with_date <- c(header_base, date_of_modification)
  writeLines(header_with_date, con = output)
}

createStreamPlot <- function() {
  # Library
  library(streamgraph)
  
  # Create data:
  year0 <- 2002
  year99 <- 2019
  tSteps <- year99 - year0 + 1
  
  cats <- c('Physics student at UCM', 'Science teacher', 'Science journalist at Naukas', 'R&D Engineer at IOT', 'PhD student at WUR')
  cols <- c('green', 'darkgreen', 'blue', 'red', 'orange')
  nCat <- length(cats)
  
  year <- rep(seq(year0, year99) , each = nCat)
  name <- rep(cats , tSteps)
  colors <- rep(cols, tSteps)
  
  value <- c(8, 0, 0, 0, 0, #2002
             4, 4, 0, 0, 0, #2003
             4, 4, 0, 0, 0, #2004
             4, 4, 0, 0, 0, #2005
             4, 4, 0, 0, 0, #2006
             4, 4, 0, 0, 0, #2007
             4, 4, 0, 0, 0, #2008
             4, 4, 0, 0, 0, #2009
             4, 4, 0, 0, 0, #2010
             4, 4, 2, 0, 0, #2011
             0, 0, 2, 8, 0, #2012
             0, 0, 2, 8, 0, #2013
             0, 0, 2, 8, 0, #2014
             0, 0, 2, 8, 0, #2015
             0, 0, 2, 0, 8, #2016
             0, 0, 2, 0, 8, #2017
             0, 0, 2, 0, 8, #2018
             0, 0, 2, 0, 8) #2019
  
  
  data <- data.frame(year, name, value, cols)
  
  # Stream graph with a legend
  p <- streamgraph(data, key="name", value="value", date="year", interpolate = "basis", interactive = FALSE) %>% 
    #sg_legend(show=TRUE, label="names: ") %>% 
    sg_axis_x(tick_interval = 1) %>%
    sg_axis_y(tick_count = 0)
  # sg_annotate("ak", x = 2008, y = 1, size = 100)
  #sg_fill_manual(cols)
}
