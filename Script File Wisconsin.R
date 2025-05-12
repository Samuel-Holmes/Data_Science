# Ensuring necessary packages are installed

install.packages("dplyr")
install.packages("naniar")
install.packages("mice")
install.packages("ggplot2")
install.packages("corrplot")
install.packages("pscl")
install.packages("caret")
install.packages("car")
install.packages("pROC")

# Loading the necessary libraries  

library(tidyselect)
library(dplyr)
library(naniar)
library(mice)
library(ggplot2)
library(corrplot)
library(pscl)
library(caret)
library(car)
library(pROC)


# Importation and reading of the data set

file_path <- "D:/Masters Course/Rstudio AT2/WISCONSIN.csv"
WISCONSIN <- read.csv(file_path)



# At this point consult the environment and view the data, it is apparent some processing is in order. 699 obs. of 10 variables. 
# Missing values apparent in Bare.nuclei column.
# Rather than consulting the entire data set we can also check the first 6 and last 6 observations with head and tail functions.
# We can also gain summary statistics to provide some basic statistics about the data set  

# head and tail output code 

head(WISCONSIN)
tail(WISCONSIN)

# summary statistics

summary(WISCONSIN)

# consulting data set 

View(WISCONSIN)

# Class numeric conversion benign = 0 malignant = 1

WISCONSIN$Class <- ifelse(WISCONSIN$Class == 'benign', 0, 1)

# Increasing max print limit to allow for entire data set 

options(max.print = 10000000)

# Searching for NA values

is.na(WISCONSIN)

# Counting missing values

sum(is.na(WISCONSIN)) 

# Shows there are 16 missing values for clarity lets find the exact locations rather than looking at data set manually 

missing_values <- which(is.na(WISCONSIN), arr.ind = TRUE)

print("LOCATION OF MISSING VALUES (ROW, COLUMN):")
print(missing_values)

# Confirmed missing values only exist in column 6 (Bare.nuclei) in 16 instances 
# Now need to decide best imputation method based upon the data and the rate of occurrence
# 16/699 = 2.288 missing values in bare nuclei column occur in approximately 2% of the observations 

# Testing whether the data is MCAR before deciding on imputation or omission  

mcar_test(WISCONSIN)


# P value output is greater than 0.05 so the null hypothesis is rejected and the data is not missing completely so random multiple imputation will allow for use of other variables 
# when replacing the missing values utilising predictive mean matching

# Replacing the missing values 

imputed_missing_bn <- mice(WISCONSIN, m = 5, method = "pmm")

# Creating a complete data set with the imputed values   

full_dataset <- complete(imputed_missing_bn, 1)

# Removal of previous data set and checking of new data set 

rm(WISCONSIN)

View(full_dataset)

# Examining distribution of Class variable 

class_distribution <- table(full_dataset$Class)
class_percentage_distribution <- prop.table(class_distribution) * 100 

print(class_percentage_distribution)

# Outputs large decimal numbers lets round them to a whole integer as this is to further support descriptive statistical analysis 

rounded_class_distribution_percentage <- paste(round(class_percentage_distribution, 0),"%")
print(rounded_class_distribution_percentage)

# Plotting a correlation matrix 

correlation <- cor(full_dataset)
corrplot(correlation, method = 'number')

# Class variable is binary we can use a logistical regression model 
# This correlation matrix allows us to identify our predictor variables for the logistical regression model.

# Looking at the matrix Cell.size, Cell.shape, and Bare. Nuclei will be predictors.

# Model creation 

# Setting up samples of training and testing 

set.seed(1)
sample <- sample(c(TRUE,FALSE), nrow(full_dataset), replace = TRUE, prob = c(0.7, 0.3))
train <- full_dataset[sample, ]
test <- full_dataset[!sample, ]

# Creating model 

logistical_model <- glm(Class~Cell.size+Cell.shape+Bare.nuclei, family="binomial", data=train)

# Disabling scientific notation for summary

options(scipen=999)

# Summary of the model

summary(logistical_model)


# Assessing model fit scored using McFadden's R^2. Score> 0.4 indicates good fit. 

pscl::pR2(logistical_model)["McFadden"]


# Checking specific variable importance

caret::varImp(logistical_model)

# checking for multicollinearity

car::vif(logistical_model)

# attempting prediction using the model creating a test set  

prediction_set <- data.frame(Cl.thickness = 10, Cell.size =7, Cell.shape = 7, Marg.adhesion = 3, Epith.c.size = 8, Bare.nuclei =5, Bl.cromatin = 7, Normal.nucleoli = 4, Mitoses = 3)

predict(logistical_model, prediction_set, type= "response")

