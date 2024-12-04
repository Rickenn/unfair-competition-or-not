#### Preamble ####
# Purpose: Tests the structure and validity of the simulated Canadian food price
# Author: Ruikang Wang (1008238872)
# Date: 3 December 2024
# Contact: ruikang.wang@utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse`, 'testthat' package must be installed and loaded
  # - 00-simulate_data.R must have been run


#### Workspace setup ####
library(tidyverse)
library(testthat)
sim_data <- read_csv("data/00-simulated_data/simulated_data.csv")


# Define vendors and products as per simulation
vendors <- c("Metro", "Loblaws", "NoFrills", "SaveOnFoods", "TandT", "Voila", "Walmart")
products <- c("Smoked Classic Cut Bacon", "Omega 3 Eggs", "Lactose-Free 2% Milk", "100% Whole Grain Ancient with Quinoa Bread")

# 1. Test column types and structure
test_that("Column types are correct", {
  expect_type(sim_data$vendor, "character")
  expect_type(sim_data$product_name, "character")
  expect_type(sim_data$old_price, "double")
  expect_type(sim_data$price_change, "double")
})


# 3. Check vendor in categorical columns
test_that("vendor in categorical columns", {
  unique_vendors <- unique(sim_data$vendor)
  expect_true(length(unique_vendors) > 0)
})


# 3. Check product_name in categorical columns
test_that("product_name in categorical columns", {
  unique_vendors <- unique(sim_data$product_name)
  expect_true(length(unique_vendors) > 0)
})

# 4. Test ranges for numeric variables
test_that("Old prices are not negative", {
  expect_gte(min(sim_data$old_price), 0)
})


# 6. Test dataset size
test_that("Dataset contains the expected number of rows", {
  expect_lte(nrow(sim_data), 1000)
})


#### Summary of Testing ####
print("All tests passed successfully!")