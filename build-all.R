rm(list = ls())
library(rmarkdown)

# Load auxiliary files
source('config.R')
source('auxs.R')

# Generate each of the n documents
n <- nrow(config)
for (i in 1:n) {
  if (config$active[i]) { # Only render if active
    updateHeader(config$headers[i], config$hdr_temp[i]) # Generate temporary header with current date and time
    
    # Render the documents
    render(inputs[i], 
           output_format = config$output_formats[i], 
           output_file = config$output_filenames[i],
           output_dir = config$output_dir[i],
           encoding = 'utf-8',
           clean = TRUE)
    
    file.remove(config$hdr_temp[i]) # Remove temporary file used for including current date and time in the header
  }
}

