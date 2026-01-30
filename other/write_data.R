library(haven)

# folder where the .dta files live
path <- "/Users/mebucca/Library/Mobile Documents/com~apple~CloudDocs/Research/Inequality Chile/Data/"

# find all .dta files
files <- list.files(path, pattern = "\\.dta$", full.names = TRUE)

# read them all into a named list
data_list <- lapply(files, read_dta)

# give each dataset a name based on filename
names(data_list) <- tools::file_path_sans_ext(basename(files))

# save everything into one .RData file
save(data_list, file = "all_casen_files.RData")
