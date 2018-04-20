rm(list = ls())

# Update header_with_date.md
source('config.R')
source('auxs.R')

updateHeader(hdr_scicomm_en, hdr_temp)

render(input_scicomm_en, 
       output_format = 'md_document', 
       output_file = output_name_scicomm_en,
       output_dir = output_dir,
       encoding = 'utf-8',
       clean = TRUE)

file.remove(hdr_temp)
