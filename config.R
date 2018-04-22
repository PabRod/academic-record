# Input RMardown files
inputs <- c('sci-comm-en.Rmd',
           'sci-comm-es.Rmd')

# Corresponding headers (w/o "Modified" metadata)
headers <- c('headers/base_sci-comm_en.md',
             'headers/base_sci-comm_es.md')

# Render only if active
active <- c(TRUE,
            TRUE)

# Output directory
output_dir <- '../../content/pages'

# Output filenames (NULL for default: name.Rmd -> name.md)
output_filenames <- c(NULL,
                     NULL)

# Temporary header location
hdr_temp <- 'headers/hdr_temp.md'

# Backups location
backups_dir <- './backups'
