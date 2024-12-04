#### Preamble ####
# Purpose: Application for current_price_model
# Author: Ruikang Wang (1008238872)
# Date: 3 December 2024
# Contact: ruikang.wang@utoronto.ca
# License: MIT
# Pre-requisites: run 06-model_data.R before this


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
price_change_data <- read_csv("data/02-analysis_data/price_change_data.csv")

### Model data ####
exploratory_data <- price_change_data %>%
  mutate(current_price = old_price + price_change) %>% # Calculate the new variable
  select(-price_change)
loblaws_bacon_data <- exploratory_data %>%
  filter(vendor == "Loblaws", product_name == "Smoked Classic Cut Bacon")
# Use the model to predict the future price for the filtered data
predictions <- predict(current_price_model, newdata = loblaws_bacon_data)

# Add the predictions to the original dataset
loblaws_bacon_data <- loblaws_bacon_data %>%
  mutate(predicted_price = predictions)

# Create a comparison plot
ggplot(loblaws_bacon_data, aes(x = change_date)) +
  geom_line(aes(y = current_price, color = "Actual Price"), size = 1) +
  geom_line(aes(y = predicted_price / 0.25, color = "Predicted Price"), size = 1, linetype = "dashed") +
  labs(
    title = "Comparison of Actual and Predicted Prices for Classic Cut Bacon at Loblaws",
    x = "Time",
    y = "Price",
    color = "Legend"
  ) +
  theme_minimal()




voila_milk_data <- exploratory_data %>%
  filter(vendor == "Voila", product_name == "Lactose-Free 2% Milk")
# Use the model to predict the future price for the filtered data
predictions <- predict(current_price_model, newdata = voila_milk_data)

# Add the predictions to the original dataset
voila_milk_data <- voila_milk_data %>%
  mutate(predicted_price = predictions)

# Create a comparison plot
ggplot(voila_milk_data, aes(x = change_date)) +
  geom_line(aes(y = current_price, color = "Actual Price"), size = 1) +
  geom_line(aes(y = predicted_price / 0.30, color = "Predicted Price"), size = 1, linetype = "dashed") +
  labs(
    title = "Comparison of Actual and Predicted Prices for Lactose-Free 2% Milk at Voila",
    x = "Time",
    y = "Price",
    color = "Legend"
  ) +
  theme_minimal()






