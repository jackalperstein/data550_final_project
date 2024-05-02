pacman::p_load(data.table, tidyverse, gtsummary)

here::i_am("code/03_table_one.R")

dataset <- readRDS("/final_project/data/dataset.Rds") %>%
  mutate(ENG_SPA_OTH = as.factor(ifelse(LANG == "English", "English",
                                        ifelse(LANG == "Spanish", "Spanish", "Other")))) %>% 
  mutate(ENG_SPA_OTH = factor(ENG_SPA_OTH, levels = c("English", "Spanish", "Other")))

table1 <- tbl_summary(
  dataset,
  by = ENG_SPA_OTH,
  include = c(PATCO, SEX, AGE, RACE, ETH, PAYOR, HEAT, FEI, AKI, CKD, RENAL, HEAT1, FEI1, AKI1, CKD1, RENAL1),
  label = list(
    PATCO ~ "County",
    SEX ~ "Sex",
    AGE ~ "Age",
    RACE ~ "Race",
    ETH ~ "Ethnicity",
    PAYOR ~ "Method of Payment",
    HEAT ~ "All Heat Illnesses (HEAT)",
    FEI ~ "Fluid Electrolyte Imbalance (FEI)",
    AKI ~ "Acute Kidney Injury (AKI)",
    CKD ~ "Chronic Kidney Disease (CKD)",
    RENAL ~ "All Renal Diseases (RENAL)",
    HEAT1 ~ "HEAT is Primary Reason for Visit",
    FEI1 ~ "FEI is Primary Reason for Visit",
    AKI1 ~ "AKI is Primary Reason for Visit",
    CKD1 ~ "CKD is Primary Reason for Visit",
    RENAL1 ~ "RENAL is Primary Reason for Visit"),
  missing_text = "Missing") %>%  
  add_overall(col_label = "**Total**, N = {n}") %>% 
  bold_labels() %>% 
  modify_footnote(update = everything() ~ NA) %>% 
  modify_header(label = "**Variable**") %>% 
  as_gt() %>% gt::tab_header(title = "Table 1. Descriptive Statistics",
                             subtitle = "Baseline Demographic and Language Data, 2010 - 2019")

saveRDS(table1, file = "/final_project/output/table1.Rds")