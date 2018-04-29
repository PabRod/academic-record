# Input RMardown files
inputs <- c('sci-comm-en.Rmd',
           'sci-comm-es.Rmd',
           'education-en.Rmd')

config <- data.frame(inputs)

# Corresponding headers (w/o "Modified" metadata)
config$headers <- c('headers/sci-comm-en.md',
             'headers/sci-comm-es.md',
             'headers/education-en.md')

# Output formats
config$output_formats <- c('md_document',
                    'md_document',
                    'md_document')


# Output filenames (NULL for default: name.Rmd -> name.md)
config$output_filenames <- c(NULL,
                     NULL,
                     NULL)

# Render only if active
config$active <- c(TRUE,
                   TRUE,
                   TRUE)

# Backups location
config$backups_dir <- './backups'

# Output directory
config$output_dir <- '../../content/pages'

# Temporary header location
config$hdr_temp <- 'headers/temp.md'
