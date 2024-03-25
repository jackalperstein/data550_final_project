pacman::p_load(data.table, tidyverse, gtsummary)

here::i_am("code/02_analysis.Rmd")

# simple naming list of all 10 CSVs in data folder
csv_files <- list.files(path = "../data/", pattern = "\\.csv$")

# combine all identified files into a large list
csv_list <- setNames(lapply(paste0("../data/", csv_files), fread), csv_files)


# convert variables for each CSV (which does not retain factor information)
convert_variables <- function(df) {
  df %>%
    mutate(PATCO = factor(case_when(
      PATCO == "Los_Angeles" ~ "Los Angeles",
      PATCO == "San_Bernardino" ~ "San Bernardino",
      TRUE ~ PATCO
    )),
    SEX = factor(SEX),
    RACE = factor(RACE),
    ETH = factor(ETH),
    PAYOR = factor(PAYOR),
    PATZIP = factor(PATZIP),
    LANG = factor(LANG),
    HEAT = factor(HEAT),
    FEI = factor(FEI),
    CKD = factor(CKD),
    AKI = factor(AKI),
    RENAL = factor(RENAL),
    HEAT1 = factor(HEAT1),
    FEI1 = factor(FEI1),
    CKD1 = factor(CKD1),
    AKI1 = factor(AKI1),
    RENAL1 = factor(RENAL1)
    )
}


# apply function to each dataframe in the list
csv_list_fac_lab <- lapply(csv_list, convert_variables)

# create a single dataframe, combining each CSV in the list, add column to identify origin CSV and make it a factor
dataset <- bind_rows(csv_list_fac_lab, .id = "CSV") %>% 
  mutate(CSV = as.factor(CSV))

# remove working variables, objects, functions
rm(csv_files, csv_list, csv_list_fac_lab, convert_variables)

saveRDS(dataset, file = here::here("data/dataset.Rds"))