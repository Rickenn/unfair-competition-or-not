#### Preamble ####
# Purpose: Simulates a dataset of Canadian food price, including the product_name, 
  # current_price, vendor 
# Author: Ruikang Wang (1008238872)
# Date: 3 December 2024
# Contact: ruikang.wang@utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse`, 'dplyr' and 'here' package must be installed


#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(here)

# Set seed for reproducibility
set.seed(123)

vendors <- c("Metro", "Loblaws", "NoFrills", "SaveOnFoods", "TandT", "Voila", "Walmart")
products <- c("Smoked Classic Cut Bacon", "Omega 3 Eggs", "Lactose-Free 2% Milk", "100% Whole Grain Ancient with Quinoa Bread")

# Generate a simulated dataset
n <- 1000  # Number of observations

sim_data <- data.frame(
  vendor = sample(vendors, n, replace = TRUE),
  product_name = sample(products, n, replace = TRUE),
  old_price = round(runif(n, min = 3, max = 10), 2),  # Old prices between 3 and 10
  price_change = round(runif(n, min = -3, max = 3), 2) # Price change between -3 and 3, ensures it's reasonable
)

# Ensure that old_price is non-negative (though it already is with the chosen range)
sim_data <- sim_data %>%
  mutate(old_price = ifelse(old_price < 0, 0, old_price))

# Calculate the current price
sim_data <- sim_data %>%
  mutate(current_price = old_price + price_change)

# Ensure no negative current prices
sim_data <- sim_data %>%
  mutate(current_price = ifelse(current_price < 0, 0, current_price))

# Remove rows with any missing values
sim_data <- sim_data %>%
  drop_na()

# Preview the simulated dataset
head(sim_data)

# You can save this dataset to a CSV file if needed
write_csv(price_change_data, here("data", "00-simulated_data", "simulated_data.csv"))