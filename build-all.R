rm(list = ls())
library(rmarkdown)

# Update header_with_date.md
source('config.R')
source('auxs.R')

n <- length(inputs)

for (i in 1:n) {
  if (active[i]) {
    updateHeader(headers[i], hdr_temp)
    
    render(inputs[i], 
           output_format = 'md_document', 
           output_file = output_filenames[i],
           output_dir = output_dir,
           encoding = 'utf-8',
           clean = TRUE)
    
    file.remove(hdr_temp)
  }
}
