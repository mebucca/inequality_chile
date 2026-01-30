# ==============================================================================
# CASEN data Harmonization Pipeline
# ==============================================================================

# Preamble ---------------------------------------------------------------------
rm(list = ls()) 
options(width = 170) 

# Libraries --------------------------------------------------------------------
library(pacman)
p_load(tidyverse, haven, data.table, priceR, reldist, 
       rsample, modelr, wesanderson, ggridges, purrr, here)

# Directories ------------------------------------------------------------------
diranalysis <- here(getwd(),"code")
dirdata     <- here(getwd(),"data")

# Load Inflation Data ----------------------------------------------------------
source(file.path(diranalysis, "inflation.R"))

# Load CASEN Data --------------------------------------------------------------
load(file.path(dirdata, "all_casen_files.RData"))

# Load Processing Functions ----------------------------------------------------
walk(c("fn_demographics.R", "fn_education.R", "fn_income.R", 
       "fn_weights.R", "fn_varselection.R"), 
     ~source(file.path(diranalysis, .x)))


# Data Harmonization -----------------------------------------------------------
cat("Processing demographics...\n")
data_list <- map2(data_list, names(data_list), demo)

cat("Processing education...\n")
data_list <- map2(data_list, names(data_list), educ)

cat("Processing income...\n")
data_list <- map2(data_list, names(data_list), income)

cat("Processing weights...\n")
data_list <- map2(data_list, names(data_list), w)

cat("Selecting variables...\n")
data_list <- map2(data_list, names(data_list), varselect)

# Combine and Adjust -----------------------------------------------------------

cat("Combining data...\n")
casen_full <- bind_rows(data_list)
rm(data_list)

cat("Adjusting for inflation...\n")
casen_full <- casen_full %>% 
  left_join(ipc, by = "year") %>%
  mutate(y_aut_2023 = y_aut * inflation)

cat("Complete! Final dataset:", nrow(casen_full), "observations\n")