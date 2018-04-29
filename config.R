# Input RMardown files
inputs <- c('sci-comm-en.Rmd',
           'sci-comm-es.Rmd',
           'education-en.Rmd')

config <- data.frame(inputs)

# Corresponding headers (w/o "Modified" metadata)
config$headers <- c('headers/base_sci-comm_en.md',
             'headers/base_sci-comm_es.md',
             'headers/base_education_en.md')

# Render only if active
config$active <- c(TRUE,
            TRUE,
            TRUE)

# Output formats
config$output_formats <- c('md_document',
                    'md_document',
                    'md_document')


# Output filenames (NULL for default: name.Rmd -> name.md)
config$output_filenames <- c(NULL,
                     NULL,
                     NULL)

# Backups location
config$backups_dir <- './backups'

# Output directory
config$output_dir <- '../../content/pages'

# Temporary header location
config$hdr_temp <- 'headers/hdr_temp.md'
