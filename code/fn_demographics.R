# demo function - first argument is data, second is name

demo <- function(data, dataset_name) {
  # Extract year from dataset name (e.g., "casen_1990" -> "1990")
  i <- gsub("casen_", "", dataset_name)
  
  cat("Processing year:", i, "\n")
  cat("----------------------------- id household -----------------------------\n")
  
  if (i == "1990") {
    data <- data %>%
      mutate(id_hh = paste(r, p, c, z, f)) %>%
      group_by(id_hh) %>%
      mutate(aux = n()) %>%
      ungroup() 
    
    data %>% with(cor(numper, aux, use = "pairwise.complete.obs")) %>% print()
  } else if (i == "1992" || i == "1994" || i == "1996") {
    data <- data %>%
      mutate(id_hh = paste(seg, f, p, z, s, v, comu)) %>%
      group_by(id_hh) %>%
      mutate(aux = n()) %>%
      ungroup() 
    
    data %>% with(cor(numper, aux, use = "pairwise.complete.obs")) %>% print()
  } else if (i == "1998" || i == "2003") {
    data <- data %>%
      mutate(id_hh = paste(segmento, f, p, z, estrato)) %>%
      group_by(id_hh) %>%
      mutate(aux = n()) %>%
      ungroup() 
    
    data %>% with(cor(numper, aux, use = "pairwise.complete.obs")) %>% print()
  } else if (i == "2000") {
    data <- data %>%
      mutate(id_hh = paste(segmento, folio)) %>%
      group_by(id_hh) %>%
      mutate(aux = n()) %>%
      ungroup() 
    
    data %>% with(cor(numper, aux, use = "pairwise.complete.obs")) %>% print()
  } else if (i == "2006") {
    data <- data %>%
      mutate(id_hh = paste(seg, f, p, z, estrato)) %>%
      group_by(id_hh) %>%
      mutate(aux = n()) %>%
      ungroup() 
    
    data %>% with(cor(numper, aux, use = "pairwise.complete.obs")) %>% print()
  } else if (i == "2009" || i == "2011" || i == "2013" ||
             i == "2015" || i == "2017" || i == "2020" || i == "2022") {
    data <- data %>%
      mutate(k = 1) %>%
      mutate(id_hh = paste(folio, k)) %>%
      group_by(id_hh) %>%
      mutate(aux = n()) %>%
      ungroup() %>%
      select(-k)
    
    data %>% with(cor(numper, aux, use = "pairwise.complete.obs")) %>% print()
  }
  
  cat("--------------------- number of people by household --------------------\n")
  data <- data %>% mutate(n_hh = numper)  
  
  cat("------------------------------ survey year -----------------------------\n")
  data <- data %>% mutate(year = as.numeric(i))  
  
  cat("---------------------------------- age ---------------------------------\n")
  data <- data %>% mutate(age = edad)  
  
  cat("--------------------------------- sex ----------------------------------\n")
  data <- data %>% mutate(sex = ifelse(sexo == 1, 1, ifelse(sexo == 2, 0, NA))) 
  
  cat("------------------------- role in household ---------------------------\n")
  data <- data %>%
    mutate(head = ifelse(pco1 == 1, 1, 0)) %>%
    mutate(partner = ifelse(pco1 == 2, 1, 0)) %>%
    mutate(children = ifelse(pco1 == 3, 1, 0)) 
  
  cat("--------------------------- marital status ------------------------------\n")
  data <- data %>% mutate(married = ifelse(ecivil == 1, 1, 0)) 
  
  if (as.numeric(i) < 2015) {
    data <- data %>% mutate(cohabitating = ifelse(ecivil == 2, 1, 0)) 
  } else {
    data <- data %>% mutate(cohabitating = ifelse(ecivil == 2 | ecivil == 3, 1, 0)) 
  }
  
  cat("\n")
  
  return(data)
}
