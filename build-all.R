rm(list = ls())
library(rmarkdown)

# Update header_with_date.md
source('config.R')
source('auxs.R')

n <- length(config$inputs)

for (i in 1:n) {
  if (config$active[i]) {
    updateHeader(config$headers[i], config$hdr_temp[i])
    
    render(inputs[i], 
           output_format = config$output_formats[i], 
           output_file = config$output_filenames[i],
           output_dir = config$output_dir[i],
           encoding = 'utf-8',
           clean = TRUE)
    
    file.remove(config$hdr_temp[i])
  }
}
