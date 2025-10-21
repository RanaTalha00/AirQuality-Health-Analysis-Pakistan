# ============================================
# 02_aggregation_analysis.R
# Purpose: Aggregate and summarize air quality data by city and year
# ============================================

library(tidyverse)
library(lubridate)

# ---- 1. Load Cleaned Data ----
df <- read_csv("C:/Users/PMLS/Downloads/Project/Public Policy Data Analysis – Air Quality & Health in Pakistan/Cleaned_AirQuality.csv", show_col_types = FALSE)

# ---- 2. Aggregate by City & Year ----
annual <- df %>%
  filter(!is.na(pm25)) %>%
  group_by(city, year) %>%
  summarise(
    pm25_mean = mean(pm25, na.rm = TRUE),
    pm25_max = max(pm25, na.rm = TRUE),
    .groups = "drop"
  )

# ---- 3. Merge Health Summary ----
health_summary <- df %>%
  filter(!is.na(number)) %>%
  select(number, beds, year) %>%
  distinct()

annual <- left_join(annual, health_summary, by = "year")

# ---- 4. Check Results ----
print(annual, n = 10)
summary(annual)

# ---- 5. Export Aggregated Data ----
write_csv(annual, "C:/Users/PMLS/Downloads/Project/Public Policy Data Analysis – Air Quality & Health in Pakistan/AirQuality_Health_Annual.csv")
