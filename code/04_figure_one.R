pacman::p_load(tidyverse)

here::i_am("code/04_figure_one.R")

dataset <- readRDS(here::here("data/dataset.rds"))

daily_visits <- dataset %>%
  pivot_longer(cols = c(HEAT1, FEI1, AKI1, CKD1, RENAL1), names_to = "Outcome", values_to = "Presence") %>%
  filter(Presence == 1) %>%
  group_by(DATE, Outcome) %>%
  summarise(Visits = n(), .groups = 'drop')

outcome_labels <- c("HEAT1" = "All Heat Illnesses",
                    "FEI1" = "Fluid Electrolyte Imbalance",
                    "AKI1" = "Acute Kidney Injury",
                    "CKD1" = "Chronic Kidney Disease",
                    "RENAL1" = "All Renal Diseases")

figure1 <- ggplot(data = daily_visits, aes(x = DATE, y = Visits, color = Outcome)) +
  geom_line() + 
  geom_point(size = 0.5) +
  labs(title = "Daily ER Visits",
       x = "Date",
       y = "Number of Visits",
       color = "Outcome") +
  scale_color_manual(values = scales::hue_pal()(length(outcome_labels)),
                     labels = outcome_labels,
                     name = "Primary Outcome") +
  scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
  theme_minimal()  

figure1

saveRDS(figure1, file = here::here("output/figure1.rds"))