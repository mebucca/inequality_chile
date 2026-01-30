w <- function(data, dataset_name) {
  
  # Extract year from dataset name (e.g., "casen_1990" -> "1990")
  i <- gsub("casen_", "", dataset_name)
  
  cat("Processing year:", i, "\n")
  cat("----------------------- sample weights -----------------------\n")

  if (i == "2011") {
    data  <- data %>% mutate(weight = expr_full)
  } else {
    data  <- data %>% mutate(weight = expr)
      }
  
}
