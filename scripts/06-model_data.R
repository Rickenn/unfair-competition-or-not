#### Preamble ####
# Purpose: Models current_price_model to find how the variable effect current price
# Author: Ruikang Wang (1008238872)
# Date: 3 December 2024
# Contact: ruikang.wang@utoronto.ca
# License: MIT
# Pre-requisites: install.package 'brms'
# run 03-clean_data.R before this


install.packages("brms")

# Load necessary libraries
library(tidyverse)
library(rstanarm)
library(here)
library(readr)
library(dplyr) # Ensure dplyr is loaded
library(brms)


data <- read_csv("data/02-analysis_data/price_change_data.csv")


new_data <- data %>%
  mutate(current_price = old_price + price_change) %>% # Calculate the new variable
  select(-price_change)


# Convert categorical variables to factors
new_data <- new_data %>%
  mutate(
    vendor = as.factor(vendor),
    product_name = as.factor(product_name)
  )

# Define the Bayesian regression model
current_price_model <- stan_glm(
  formula = current_price ~ old_price + vendor + product_name,
  data = new_data,
  family = Gamma(link = "log"), # Gamma regression with a log link
  prior = normal(location = 0, scale = 2.5),         # Prior for coefficients
  prior_intercept = normal(location = 0, scale = 2.5), # Prior for intercept
  seed = 1234                                       # Seed for reproducibility
)

# Summarize the model
summary(current_price_model)

# Plot posterior distributions
plot(price_change_model)

# Check model fit with posterior predictive checks
pp_check(price_change_model)

# Extract fixed effects (coefficients)
fixef(price_change_model)



#### Save model ####
saveRDS(
  current_price_model,
  file = "models/current_price_model.rds"
)


