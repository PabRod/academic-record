# Input RMardown files
inputs <- c('sci-comm-en.Rmd',
           'sci-comm-es.Rmd',
           'education-en.Rmd',
           'education-es.Rmd',
           'teaching-en.Rmd',
           'teaching-es.Rmd')

config <- data.frame(inputs)

# Corresponding headers (w/o "Modified" metadata)
config$headers <- paste('headers/', gsub('.Rmd', '.md', inputs), sep='') # Takes the names from the input

# Output formats
config$output_formats <- c('md_document',
                    'md_document',
                    'md_document',
                    'md_document',
                    'md_document',
                    'md_document')

# Output filenames (NULL for default: name.Rmd -> name.md)
config$output_filenames <- c(NULL,
                     NULL,
                     NULL,
                     NULL,
                     NULL,
                     NULL)

# Render only if active
config$active <- c(TRUE,
                   TRUE,
                   TRUE,
                   TRUE,
                   TRUE,
                   TRUE)

# Backups location
config$backups_dir <- './backups'

# Output directory
config$output_dir <- '../../content/pages'

# Temporary header location
config$hdr_temp <- 'headers/temp.md'
