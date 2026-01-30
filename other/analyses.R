casen_full <- casen_full %>% mutate(college=if_else(schooling>=16,"Ed. Superior","Menos Ed. Superior")) %>% drop_na(college) %>% mutate(college = factor(college))

casen_full <- casen_full %>% mutate(cohort =  year - age) %>% mutate(cohort_5 =  cohort  - (cohort %% 5)  ) 


# Define the Valentino inspired color palette
valentino_palette <- c(
  "#800080",  # Purple
  "#FFD700"   # Gold, introducing a complementary luxurious touch
)



casen_full <- as_tibble(casen_full)

# Filter for cohorts between 1950 and 1990, then plot
plot <- casen_full %>%
  filter(cohort_5 >= 1950 & cohort_5 <= 1990) %>%
  group_by(year) %>%
  mutate(rel_pos = rank(y_mon_hh) / n()) %>%
  ggplot(aes(y = factor(cohort_5), x = rel_pos, fill = college, colour = college)) +
  geom_density_ridges(alpha = 0.3) +
  geom_vline(xintercept = seq(0.2, 0.8, by = 0.2), colour = "#6495ED", linetype = "dashed", alpha = 0.7) +
  labs(x = "Percentil", y = "Cohorte de Nacimiento", fill="", colour="") +
  scale_fill_manual(values = valentino_palette) +
  scale_color_manual(values = valentino_palette) +
  theme_bw()

ggsave(plot, filename = "plot_suenos.png", width = 6, height = 10, dpi = 300)


casen_gini <- casen_full %>%
  drop_na(y_mon_hh) %>%
  modelr::bootstrap(100) %>% 
  group_by(.id) %>% 
  do(as.data.frame(.$strap)) %>%	
  group_by(.id,year) %>%
  dplyr::summarise( boot.gini=  reldist::gini(y_mon_hh, weights=weight)) %>%
  group_by(year) %>%
  dplyr::summarise(gini_mean = mean(boot.gini))  




# Define your analysis function
gini_function <- function(data) {
  reldist::gini(data$y_mon_hh, weights = data$weight)
}

# Perform bootstrap and summarize
boot_summary <- casen_full %>%
  drop_na(y_mon_hh) %>%
  nest(data = c(y_mon_hh, weight)) %>%
  mutate(
    boot_results = map(data, function(boot_data) {
      bootstrap_samples <- bootstraps(boot_data, times = 100)
      gini_values <- map_dbl(bootstrap_samples$splits, ~ gini_function(.x$data))
      tibble(boot.gini = gini_values)
    })
  ) %>%
  unnest(boot_results) %>%
  group_by(year) %>%
  summarise(
    gini_mean = mean(boot.gini)
  )

# Print the summary
print(boot_summary)



