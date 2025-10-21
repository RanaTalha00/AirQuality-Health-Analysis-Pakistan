# ============================================
# 01_data_cleaning.R
# Project: Public Policy Data Analysis – Air Quality & Health in Pakistan
# Author: Talha Rana
# Purpose: Import and clean merged dataset
# ============================================

library(tidyverse)
library(lubridate)

# ---- 1. Load Dataset ----
path <- "C:/Users/PMLS/Downloads/Project/Public Policy Data Analysis – Air Quality & Health in Pakistan/Final_AirQuality_Health_Pakistan_Cleaned.csv"
df <- read_csv(path, show_col_types = FALSE)

# ---- 2. Data Inspection ----
glimpse(df)
skimr::skim(df)

# ---- 3. Clean Data Types ----
df <- df %>%
  mutate(
    pm25 = str_replace_all(pm25, "[^0-9\\.]", ""),  # remove non-numeric chars
    pm25 = as.numeric(pm25),
    date = as.Date(date),
    city = as.factor(city),
    facility_type = as.factor(facility_type),
    year = year(date)
  ) %>%
  select(-pollutant_type)  # remove redundant column

# ---- 4. Check Conversion Results ----
summary(df$pm25)
sum(is.na(df$pm25))

# ---- 5. Save Cleaned File ----
write_csv(df, "C:/Users/PMLS/Downloads/Project/Public Policy Data Analysis – Air Quality & Health in Pakistan/Cleaned_AirQuality.csv")
