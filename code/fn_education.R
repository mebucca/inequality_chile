  
educ <- function(data, dataset_name) {
  i <- gsub("casen_", "", dataset_name)
  
cat("Processing year:", i, "\n")
cat("----------------------- years of Schooling -----------------------\n")

  # Years of Schooling
  data <- data %>%
    mutate(schooling = esc)
  
}