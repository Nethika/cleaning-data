###############################################
# Nethika Suraweera
# Coursera: Getting & Cleaning Data
# Course Project
# 07/16/2017
###############################################

#rm(list = ls())
library(dplyr)
library(reshape2)

####### Download data #######
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile='data') 
unzip ("data", exdir = "./")

##############################################################
####### Load Data & Adjust Column Names#############
data_dir <- "UCI HAR Dataset"

## Load features 
features <- read.table(file.path(data_dir, "features.txt"),header = FALSE)
#getting column names
colm_names <- gsub("-", "_", features$V2)
colm_names <- gsub("[^a-zA-Z\\d_]", "", colm_names)
## Load activity labels
activity_lbls <- read.table(file.path(data_dir, "activity_labels.txt"),header = FALSE)

####### Load training data
train_data <- read.table(file.path(data_dir, "train", "X_train.txt"),header = FALSE)
## Adjusts column names
names(train_data) <- make.names(names = colm_names, unique = TRUE, allow_ = TRUE)
## Load training labels
train_lbls <- read.table(file.path(data_dir, "train", "y_train.txt"),header = FALSE)
## Adjusts column names
names(train_lbls) <- "Activity"  
#Uses descriptive activity names to name the activities in the data set
train_lbls$Activity <- factor(train_lbls$Activity, levels = activity_lbls$V1, labels = activity_lbls$V2)
## Load training subs
train_subs<- read.table(file.path(data_dir, "train", "subject_train.txt"),header = FALSE)
## Adjusts column names
names(train_subs) <- "Subject"

#######  Load test data
test_data <- read.table(file.path(data_dir, "test", "X_test.txt"),header = FALSE)
## Adjusts column names
names(test_data) <- make.names(names = colm_names, unique = TRUE, allow_ = TRUE)
## Load test labels
test_lbls <- read.table(file.path(data_dir, "test", "y_test.txt"),header = FALSE)
## Adjusts column names
names(test_lbls) <- "Activity"  
#Uses descriptive activity names to name the activities in the data set
test_lbls$Activity <- factor(test_lbls$Activity, levels = activity_lbls$V1, labels = activity_lbls$V2)
## Load test subs
test_subs <- read.table(file.path(data_dir, "test", "subject_test.txt"),header = FALSE)
## Adjusts column names
names(test_subs) <- "Subject"



##############################################################
#Merges the training and the test sets to create one data set.
merged_data <- rbind(
  cbind(train_data, train_lbls, train_subs),
  cbind(test_data, test_lbls, test_subs)
)
##############################################################
#Extracts only the measurements on the mean and standard deviation for each measurement.
merged_data <- select(merged_data,
                      matches("mean|std"),
                      one_of("Subject", "Activity")
                      )

##############################################################
#creates a second, independent tidy data set with the average of each variable for each activity and each subject.
id_cols <- c("Subject", "Activity")
tidy_data <- melt(
  merged_data, 
  id = id_cols, 
  measure.vars = setdiff(colnames(merged_data), id_cols)
)
tidy_data <-dcast(tidy_data,Subject + Activity ~ variable, mean)

###############################################################
#Save results in text file

write.table(tidy_data, file = "tidy_data.txt", sep = ",", row.names = FALSE)
