# Install and load required packages
install.packages("tidyverse")
library(tidyverse)
library(dplyr)
library(ggplot2)
library(caret)

# Load the healthcare dataset
healthcare <- read.csv("C:/Users/hp/OneDrive/Desktop/Excel/healthcare_dataset.csv")

# ---------------------------------------
# Step 1: Data Inspection
# ---------------------------------------
head(healthcare)  # First few rows
tail(healthcare)  # Last few rows
summary(healthcare)  # Summary statistics
str(healthcare)  # Structure of the dataset

# ---------------------------------------
# Step 2: Data Cleaning
# ---------------------------------------
# Check for missing values
missing_values <- sum(is.na(healthcare))
cat("Total missing values:", missing_values, "\n")

# Check for duplicate rows
duplicate_rows <- sum(duplicated(healthcare))
cat("Total duplicate rows:", duplicate_rows, "\n")

# Remove duplicate rows
healthcare_data_clean <- unique(healthcare)

# ---------------------------------------
# Step 3: Exploratory Data Analysis (EDA)
# ---------------------------------------

# Demographics Analysis: Age and Gender
hist(
  healthcare_data_clean$Age, 
  main = "Age Distribution", 
  xlab = "Age", 
  col = "lightblue"
)

cat("Gender Distribution:\n")
print(table(healthcare_data_clean$Gender))

cat("Medical Condition Distribution:\n")
print(table(healthcare_data_clean$Medical.Condition))

# Billing Amount Analysis by Medical Condition and Insurance Provider
boxplot(
  Billing.Amount ~ Medical.Condition, 
  data = healthcare_data_clean, 
  main = "Billing Amount by Medical Condition", 
  col = "lightgreen"
)

boxplot(
  Billing.Amount ~ Insurance.Provider, 
  data = healthcare_data_clean, 
  main = "Billing Amount by Insurance Provider", 
  col = "lightcoral"
)

# ---------------------------------------
# Step 4: Time Analysis
# ---------------------------------------
# Convert admission and discharge dates to Date type
healthcare_data_clean$Date.of.Admission <- as.Date(healthcare_data_clean$Date.of.Admission, format = "%Y-%m-%d")
healthcare_data_clean$Discharge.Date <- as.Date(healthcare_data_clean$Discharge.Date, format = "%Y-%m-%d")

# Calculate length of stay
healthcare_data_clean$Length.of.Stay <- as.numeric(
  difftime(healthcare_data_clean$Discharge.Date, healthcare_data_clean$Date.of.Admission, units = "days")
)

# Histogram of length of stay
hist(
  healthcare_data_clean$Length.of.Stay, 
  main = "Length of Stay Distribution", 
  xlab = "Days", 
  col = "lightyellow"
)

# Length of stay by medical condition
ggplot(healthcare_data_clean, aes(x = Medical.Condition, y = Length.of.Stay)) +
  geom_boxplot(fill = "lightblue") +
  theme_minimal() +
  labs(title = "Length of Stay by Medical Condition", x = "Medical Condition", y = "Length of Stay")

# ---------------------------------------
# Step 5: Billing Amount Analysis
# ---------------------------------------
# Age vs Billing Amount
ggplot(healthcare_data_clean, aes(x = Age, y = Billing.Amount)) +
  geom_point(alpha = 0.7, color = "blue") +
  theme_minimal() +
  labs(title = "Age vs Billing Amount", x = "Age", y = "Billing Amount")

# Billing Amount Distribution by Gender
ggplot(healthcare_data_clean, aes(x = Gender, y = Billing.Amount, fill = Gender)) +
  geom_violin(alpha = 0.8) +
  theme_minimal() +
  labs(title = "Billing Amount Distribution by Gender", x = "Gender", y = "Billing Amount")

# Age vs Billing Amount with Length of Stay
ggplot(healthcare_data_clean, aes(x = Age, y = Billing.Amount, size = Length.of.Stay, color = Gender)) +
  geom_point(alpha = 0.6) +
  theme_minimal() +
  labs(title = "Age vs Billing Amount with Length of Stay", x = "Age", y = "Billing Amount")

# ---------------------------------------
# Step 6: Monthly Admissions Trend
# ---------------------------------------
# Extract month from Date of Admission
healthcare_data_clean$Month <- format(healthcare_data_clean$Date.of.Admission, "%Y-%m")

# Calculate admissions trend
admissions_trend <- table(healthcare_data_clean$Month)

# Plot admissions trend
ggplot(
  data.frame(Month = names(admissions_trend), Count = as.numeric(admissions_trend)), 
  aes(x = Month, y = Count)
) +
  geom_line(group = 1, color = "blue") +
  geom_point(color = "red") +
  theme_minimal() +
  labs(title = "Monthly Admissions Trend", x = "Month", y = "Number of Admissions") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# ---------------------------------------
# Final Notes
# ---------------------------------------
cat("Data Cleaning and EDA completed successfully.")
