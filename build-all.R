rm(list = ls())

# Update header_with_date.md
new_date <- format(Sys.time(), '%m/%d/%Y, %H:%M:%S')
new_line <- paste('Modified:', new_date)
header_base <- readLines('headers/header_base.md', encoding = 'utf-8')
header_with_date <- c(header_base, new_line)
writeLines(header_with_date, con = 'headers/header_with_date.md')

# Render the files
library(rmarkdown)

render('academic-record.Rmd', 
        output_format = 'md_document', 
        output_file = NULL,
        output_dir = 'output',
        encoding = 'utf-8',
        clean = TRUE)