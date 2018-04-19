rm(list = ls())

# Update header_with_date.md
source('auxs.R')
updateHeader('headers/header_base.md','headers/header_with_date.md')

# Render the files
library(rmarkdown)

render('academic-record.Rmd', 
        output_format = 'md_document', 
        output_file = NULL,
        output_dir = 'output',
        encoding = 'utf-8',
        clean = TRUE)