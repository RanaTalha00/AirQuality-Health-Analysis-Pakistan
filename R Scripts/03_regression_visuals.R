# ============================================
# 03_regression_visuals.R
# Purpose: Simulate health data, run regression, and visualize relationships
# ============================================

library(tidyverse)
library(ggplot2)

# ---- 1. Load Annual Data ----
annual <- read_csv("C:/Users/PMLS/Downloads/Project/Public Policy Data Analysis – Air Quality & Health in Pakistan/AirQuality_Health_Annual.csv", show_col_types = FALSE)

# ---- 2. Simulate Health Variable (for demonstration) ----
set.seed(123)
annual <- annual %>%
  mutate(
    respiratory_cases = round(2000 + pm25_mean * runif(n(), 5, 10) + rnorm(n(), 0, 300))
  )

# ---- 3. Correlation ----
cor_test <- cor.test(annual$pm25_mean, annual$respiratory_cases)
print(cor_test)

# ---- 4. Regression ----
model <- lm(respiratory_cases ~ pm25_mean, data = annual)
summary(model)

# ---- 5. Visualizations ----

# PM2.5 Trend Over Time
ggplot(df, aes(x = date, y = pm25, color = city)) +
  geom_line() +
  labs(
    title = "PM2.5 Trend Over Time by City",
    y = "PM2.5 (µg/m³)",
    x = "Date"
  ) +
  theme_minimal()

# Average Annual PM2.5 by City
ggplot(annual, aes(x = reorder(city, -pm25_mean), y = pm25_mean, fill = city)) +
  geom_col() +
  labs(
    title = "Average Annual PM2.5 by City",
    y = "Mean PM2.5 (µg/m³)",
    x = "City"
  ) +
  theme_minimal()

# Simulated Correlation Visualization
ggplot(annual, aes(x = pm25_mean, y = respiratory_cases, color = city)) +
  geom_point(size = 3) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Simulated Relationship: PM2.5 vs. Respiratory Cases",
    x = "PM2.5 (µg/m³)",
    y = "Respiratory Illness Cases"
  ) +
  theme_minimal()

# ---- 6. Save Plots (Optional) ----
ggsave("C:/Users/PMLS/Downloads/Project/Public Policy Data Analysis – Air Quality & Health in Pakistan/PM25_vs_RespCases.png")
