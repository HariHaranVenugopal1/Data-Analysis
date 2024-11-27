# Load Libraries
if (!require(tidyverse)) install.packages('tidyverse')
if (!require(naniar)) install.packages('naniar')
if (!require(caret)) install.packages('caret')
install.packages("ggplot2")
install.packages("dplyr")

library(tidyverse)
library(dplyr)
library(ggplot2)
library(caret)
library(naniar)

# Load Data
big_mart <- read.csv("C:/Users/hp/OneDrive/Desktop/Excel/Big_mart_sales_new.csv")

# View Data
head(big_mart)
tail(big_mart)

# Summary and Structure
summary(big_mart)
str(big_mart)

# ----- Data Cleaning -----

# Check for Missing Values
missing_item_weight <- mean(is.na(big_mart$Item_Weight)) * 100
missing_outlet_size <- mean(is.na(big_mart$Outlet_Size)) * 100
cat("Missing Item_Weight:", missing_item_weight, "%\n")
cat("Missing Outlet_Size:", missing_outlet_size, "%\n")

# Impute Missing Values
big_mart$Item_Weight[is.na(big_mart$Item_Weight)] <- median(big_mart$Item_Weight, na.rm = TRUE)
big_mart$Outlet_Size[is.na(big_mart$Outlet_Size)] <- "Unknown"

# Remove Duplicates
big_mart <- big_mart[!duplicated(big_mart), ]

# Standardize Item_Fat_Content
big_mart$Item_Fat_Content <- tolower(as.character(big_mart$Item_Fat_Content))
big_mart$Item_Fat_Content <- ifelse(big_mart$Item_Fat_Content %in% c("lf", "low fat"), "low fat", "regular")

# ----- Exploratory Data Analysis (EDA) -----

# Histogram for Item_Weight
ggplot(big_mart, aes(x = Item_Weight)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black") +
  labs(title = "Distribution of Item Weight", x = "Item Weight", y = "Count")

# Boxplot for Item_MRP
ggplot(big_mart, aes(y = Item_MRP)) +
  geom_boxplot(fill = "green", color = "black") +
  labs(title = "Boxplot of Item MRP", y = "Item MRP")

# Scatter Plot for Item_Visibility vs. Item_Outlet_Sales
ggplot(big_mart, aes(x = Item_Visibility, y = Item_Outlet_Sales)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Item Visibility vs. Outlet Sales", x = "Item Visibility", y = "Item Outlet Sales")

# Boxplot for Outlet_Type vs. Item_Outlet_Sales
ggplot(big_mart, aes(x = Outlet_Type, y = Item_Outlet_Sales)) +
  geom_boxplot(fill = "orange") +
  labs(title = "Sales Distribution by Outlet Type", x = "Outlet Type", y = "Item Outlet Sales")

# Summary Statistics
summary(big_mart[c("Item_Weight", "Item_Visibility", "Item_MRP", "Item_Outlet_Sales")])

# ----- Feature Engineering -----

# Calculate Outlet Age
big_mart$Outlet_Age <- 2024 - big_mart$Outlet_Establishment_Year

# Bin Item Visibility
big_mart$Visibility_Bins <- cut(big_mart$Item_Visibility, breaks = 3, labels = c("Low", "Medium", "High"))

# ----- Advanced Analysis -----

# Correlation Analysis
numeric_cols <- big_mart %>% select(where(is.numeric))
correlation_matrix <- cor(numeric_cols, use = "complete.obs")
print(correlation_matrix)

# Pivot Table: Aggregate Mean Sales by Outlet_Type
sales_by_outlet <- aggregate(Item_Outlet_Sales ~ Outlet_Type, big_mart, mean)
print(sales_by_outlet)

# ----- Visualization -----

# Bar Plot for Outlet_Type
ggplot(big_mart, aes(x = Outlet_Type, fill = Outlet_Type)) +
  geom_bar() +
  labs(title = "Count of Outlets by Type", x = "Outlet Type", y = "Count") +
  theme_minimal()

# Line Plot for Sales by Outlet_Age
ggplot(big_mart, aes(x = Outlet_Age, y = Item_Outlet_Sales)) +
  stat_summary(fun = "mean", geom = "line", color = "red") +
  labs(title = "Average Sales by Outlet Age", x = "Outlet Age", y = "Average Sales")

# ----- Linear Regression Model -----

# Build the Model
model <- lm(Item_Outlet_Sales ~ Item_Weight + Item_Visibility + Item_MRP + Outlet_Type, data = big_mart)

# Model Summary
summary(model)

# Check Multicollinearity
if (!require(car)) install.packages('car')
library(car)
vif_values <- vif(model)
print(vif_values)
