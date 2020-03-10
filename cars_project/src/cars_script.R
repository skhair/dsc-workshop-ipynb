# Clear all objects from memory
rm(list=ls(all=TRUE))

# R version 3.6.3 (2020-02-29) -- "Holding the Windsock"
# Platform: x86_64-w64-mingw32/x64 (64-bit)
# Packages: ggplot2_3.2.1

# THE BASIC REPRODUCIBLE WORKFLOW

# The following workflow is modified from Kitzes, J. (2018). The Basic 
# Reproducible Workflow Template. In "The Practice of Reproducible Research: 
# Case Studies and Lessons from the Data-Intensive Sciences", by Kitzes, J., 
# Turek, D., and Deniz, F. (Eds.). University of California Press: Oakland, CA.
# https://www.practicereproducibleresearch.org/

# 5 Simple Things  

# 1. Organize your files, keeping inputs and outputs separate 
# 2. Use relative paths to specify files  
# 3. Specify R-version and dependencies explicitly 
# 4. Annotate your code, explaining actions and decisions 
# 5. Automate your work as a series of small steps, glued together as a single workflow 

##########################################################################
##########################################################################

### STAGE 1 - ORGANIZATION AND WORKSPACE SETUP ###

##########################################################################
##########################################################################

# Download R and RStudio and Anaconda for your operating system.

# Download data file and readme file.

# On your own computer, replicate this folder structure locally.

# |-- cars_project
# |   |-- data_raw
# |       |-- mtcars.csv
# |       |-- readme.txt
# |   |-- data_clean
# |   |-- results
# |   |-- src

# Run RStudio and create a new R script.
# File > New File > R Script

# Save script as 'cars_script.R' to the 'src' subfolder.

# Set your working directory to the location where you created your 'cars_project' 
# folder on your computer. Replace the filepath below with your local filepath. 

setwd("C:/Users/Shahira/Documents/R/Literate Programming Workshop")

# Check for required package 'ggplot2' needed for this exercise and install, if necessary.

packages <- c("ggplot2")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}

##########################################################################
##########################################################################

### STAGE 2 - DATA PROCESSING ###

##########################################################################
##########################################################################

# Since the project folders in our working directories are arranged in the same structure, 
# you should be able to run following scripts using the relative paths specified.

# Read in the mtcars dataset into a new object called 'car_data'.

car_data <- read.csv("./cars_project/data_raw/mtcars.csv")

# Preview the data. The 'head()' function returns the first 6 rows of a matrix. 

head(car_data)
str(car_data)

# According to the readme file, the variable 'am' represents transmission: '0' = manual, 
# '1' = automatic; and the variable 'vs' represents engine shape: '0' = V-shaped, '1' = straight. 
# R is reading these variables as integers. Convert them to factors.

car_data$am <- as.factor(car_data$am)
car_data$vs <- as.factor(car_data$vs)

# Visually inspect the change.

str(car_data)

# Save the cleaned data to the 'data_clean' subfolder.

write.csv(car_data, "./cars_project/data_clean/clean_mtcars_data.csv")

# Save the cleaned data into a different subfolder from our raw data to 
# ensure that the original data are never confused or overwritted with any derived 
# data products. You should always be able to return to your original raw data.

##########################################################################
##########################################################################

### STAGE 3 - DATA ANALYSIS ###

##########################################################################
##########################################################################

# There are many different ways to analyze this data. Begin by exploring the variation 
# in our dataset variables.

summary(car_data)

# Load the 'ggplot2' library.

library(ggplot2)

# Examine the effect of horsepower 'hp' on fuel consumption 'mpg' with a scatterplot, 

plot1 <- ggplot(car_data, aes(hp, mpg)) + geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  ylab("Miles per Gallon") +
  xlab("Horsepower") +
  ggtitle("Effect of Number of Horsepower on Fuel Consuption")

plot1

# Write plot1 as a *.png in the 'results' subfolder.

ggsave("plot1.png", path = "./cars_project/results")

# Examine the influence of transmission type 'am' on the trend observed.

plot2 <- ggplot(car_data, aes(hp, mpg, color=factor(am))) + geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  ylab("Miles per Gallon") +
  xlab("Horsepower") +
  ggtitle("Effect of Number of Horsepower on Fuel Consuption, by Transmission")

plot2

# Write plot2 as a *.png in the 'results' subfolder.

ggsave("plot2.png", path = "./cars_project/results")

# The analysis shows an effect of transmission type 'am' on fuel consuption 'mpg'. 
# Examine further with a simple linear regression model.

# Fit a simple linear regression model for 'mpg' on 'am'.

model1 <- lm(mpg~am, data=car_data)
summary (model1)

# Write the test results to a plain text file in the 'results' subfolder.

capture.output (summary(model1), file = "./cars_project/results/lm_model1.txt")