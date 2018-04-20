rm(list = ls())

# Update header_with_date.md
source('auxs.R')
updateHeader('headers/header_base.md','headers/header_with_date.md')
updateHeader('headers/base_sci-comm.md','headers/base_sci-comm_with_date.md')

# Render the files
library(rmarkdown)

render('academic-record.Rmd', 
        output_format = 'md_document', 
        output_file = NULL,
        output_dir = 'output',
        encoding = 'utf-8',
        clean = TRUE)

render('sci-comm-en.Rmd', 
       output_format = 'md_document', 
       output_file = NULL,
       output_dir = 'output',
       encoding = 'utf-8',
       clean = TRUE)

# Copy the files in the appropriate locations
#file.copy('output/academic-record.md', 
#          '../../content/pages/academic-record.md', 
#          overwrite = TRUE)

#input_images <- 'output/academic-record_files/figure-markdown_strict'
#new_folder <- '../../content/images'
#list_of_files <- list.files(input_images) 
#file.copy(file.path(input_images, list_of_files), new_folder, overwrite = TRUE)

file.copy('output/sci-comm-en.md', 
          '../../content/pages/sci-comm-en.md', 
          overwrite = TRUE)
