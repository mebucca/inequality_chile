
income <- function(data, dataset_name) {
  
  # Extract year from dataset name (e.g., "casen_1990" -> "1990")
  i <- gsub("casen_", "", dataset_name)
  
  cat("Processing year:", i, "\n")
  cat("----------------------- autonomous individual income -----------------------\n")


  if (i < 2013) {
    data <- data %>% mutate(y_aut = yautaj)
  } else {
    data <- data %>% mutate(y_aut = yautcor)
  }


  cat("----------------------- monetary household income -----------------------\n")
  
  
  if (i < 2013) {
    data <- data %>% mutate(y_mon_hh = ymonehaj)
  } else {
    data <- data %>% mutate(y_mon_hh = ymonecorh)
  }

}