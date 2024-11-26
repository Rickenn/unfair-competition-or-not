#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)
library(here)
library(readr)
clean_data <- read_csv("data/02-analysis_data/clean_data.csv")

#### Clean data ####
# Load necessary library
library(dplyr)

# Assuming your dataset is named "clean_data" and already imported

clean_data <- clean_data %>%
  mutate(
    vendor = case_when(
      product_id %in% c(4068860, 3998031, 4068282, 4073728) ~ "walmart",  # Assign "walmart" for these product_ids
      product_id %in% c(712206, 712154, 710822, 711970) ~ "Voila",      # Assign "Voila" for these product_ids
      product_id %in% c(3677991, 3677154, 3678071, 3677566) ~ "TandT", 
      product_id %in% c(1704900, 1688551, 1698576, 1695676) ~ "Loblaws",
      product_id %in% c(2892726, 2881295, 2875605, 2886297) ~ "NoFrills",
      product_id %in% c(919285, 920226, 917069, 917272) ~ "Galleria",
      product_id %in% c(2321339, 2332786, 2320771, 2328223) ~ "Metro",
      product_id %in% c(3358207, 3357385, 3357119, 3360423) ~ "SaveOnFoods",
      TRUE ~ NA_character_                            # Default to NA for all other product_ids
    ),
    product_name = case_when(
      product_id %in% c(4068860, 3677991, 1704900, 2892726, 712154, 919285, 2321339, 3358207) ~ "Lactose-Free 2% Milk", 
      product_id %in% c(712206, 1688551, 2332786, 2881295, 3357385, 3998031, 3677154, 920226) ~ "100% Whole Grain Ancient with Quinoa Bread", 
      product_id %in% c(1698576, 2875605, 2320771, 3678071, 4068282, 710822, 3358119, 917069) ~ "Omega 3 Eggs", 
      product_id %in% c(1695676, 2328223, 2886297, 3360423, 4073728, 3677566, 711970, 917272) ~ "Smoked Classic Cut Bacon",
      TRUE ~ NA_character_                            # Default to NA for all other product_ids
    )
  )

head(clean_data)
write_csv(clean_data, here("data", "02-analysis_data", "analysis_data.csv"))







# Step 1: Ensure data is sorted by product_id and nowtime
clean_data <- clean_data %>%
  arrange(product_id, nowtime) # Sort data by product_id and time

# Step 2: Detect price changes and calculate the count of changes
price_change_data <- clean_data %>%
  group_by(product_id) %>%
  mutate(price_change = ifelse(current_price != lag(current_price), 1, 0)) %>% # Flag price changes
  summarise(times_price_changed = sum(price_change, na.rm = TRUE)) # Count the price changes

# Step 3: View the new dataset
print(price_change_data)

# Step 4: Save the new dataset to a CSV file if needed
# write.csv(price_change_data, "price_change_data.csv", row.names = FALSE)








# Load necessary library
library(dplyr)

# Load data from the CSV file
data <- read_csv(file = "D:/汪瑞康/U of T/2024/Fall/sta304/final program/starter_folder-main/data/01-raw_data/hammer-4-product.csv", 
                 show_col_types = FALSE)

# Remove duplicate rows
cleaned_data <- data %>%
  distinct()

# Handle missing values by dropping rows with any missing values
cleaned_data <- cleaned_data %>%
  drop_na()

# Display summary of cleaned data
print(summary(cleaned_data))

# Save the cleaned data to a new CSV file
# write.csv(cleaned_data, "D:/汪瑞康/U of T/2024/Fall/sta304/final program/starter_folder-main/data/02-analysis_data/cleaned_hammer_product.csv", row.names = FALSE)
