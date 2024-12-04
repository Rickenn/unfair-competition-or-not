#### Preamble ####
# Purpose: Tests analysis fit for study or not
# Author: Ruikang Wang (1008238872)
# Date: 3 December 2024
# Contact: ruikang.wang@utoronto.ca
# License: MIT
# Pre-requisites: run 03-clean_data.R
# install 'testthat' package


#### Workspace setup ####
library(tidyverse)
library(testthat)

data_data <- read_csv("data/02-analysis_data/analysis_data.csv")


# 1. Test column types
test_that("Column types are correct", {
  expect_type(data$vendor, "character")
  expect_type(data$product_name, "character")
  expect_type(data$current_price, "double")
})


# 3. Check vendor in categorical columns
test_that("vendor in categorical columns", {
  unique_vendors <- unique(data$vendor)
  expect_true(length(unique_vendors) > 0)
})


# 3. Check product_name in categorical columns
test_that("product_name in categorical columns", {
  unique_vendors <- unique(data$product_name)
  expect_true(length(unique_vendors) > 0)
})

# 4. Test ranges for numeric variables
test_that("Current prices are not negative", {
  expect_gte(min(data$current_price), 0)
})


#### Summary of Testing ####
print("All tests passed successfully!")