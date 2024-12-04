#### Preamble ####
# Purpose: Re deal with the clean data and make it fit for study
# Author: Ruikang Wang (1008238872)
# Date: 3 December 2024
# Contact: ruikang.wang@utoronto.ca
# License: MIT
# Pre-requisites: run 02-download_data.sql
# reminder, sql is not R, you may use the sql compiler

#### Workspace setup ####
library(tidyverse)
library(here)
library(readr)
clean_data <- read_csv("data/02-analysis_data/clean_data.csv")

#### Clean data ####
# Load necessary library
library(dplyr)
library(lubridate)


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


# Convert 'nowtime' to DateTime format in the `clean_data` dataset
clean_data <- clean_data %>%
  mutate(nowtime = as.POSIXct(nowtime, format = "%Y-%m-%d %H:%M:%S"))

# Remove rows where 'nowtime' is before '2024-08-01'
filtered_data <- clean_data %>%
  filter(nowtime >= as.POSIXct("2024-08-01"))

# View the filtered data
head(filtered_data)

write_csv(filtered_data, here("data", "02-analysis_data", "analysis_data.csv"))




# Convert 'nowtime' to Date format
analysis_data <- filtered_data %>%
  mutate(date = as.Date(nowtime, format = "%Y-%m-%d"))

# Sort the data by product_id, vendor, and date
analysis_data <- analysis_data %>%
  arrange(product_id, vendor, date)

# Calculate price change and filter only rows where price changed
price_change_data <- analysis_data %>%
  group_by(product_id, vendor) %>%
  mutate(
    price_change = as.numeric(current_price) - as.numeric(lag(current_price)), # Calculate the price change
    change_date = date, # The date of the current row
    old_price = lag(current_price) # The previous day's price
  ) %>%
  filter(!is.na(price_change) & price_change != 0) %>% # Filter rows where price change occurred
  ungroup() %>%
  select(change_date, price_change, product_id, vendor, product_name, old_price)

# View the resulting dataset
head(price_change_data)

write_csv(price_change_data, here("data", "02-analysis_data", "price_change_data.csv"))




