
varselect <- function(data, dataset_name) {
  # Extract year from dataset name (e.g., "casen_1990" -> "1990")
  i <- gsub("casen_", "", dataset_name)
  
  cat("Processing year:", i, "\n")
  cat("----------------------- variable selection -----------------------\n")
  
  data <- data %>% select(year,id_hh,age,sex,schooling,y_aut,y_mon_hh,weight)

}

