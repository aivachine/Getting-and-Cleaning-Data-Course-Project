##########################################################
# run_analysis.R
# Getting and Cleaning Data Course Project Script
# 13/02/2016
##########################################################

#Load required packages
if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("plyr")) {
  install.packages("reshape2")
}

if (!require("dplyr")) {
  install.packages("reshape2")
}

require("data.table")
require("plyr")
require("dplyr")

# set working directory
# mentioned folder must be created firstly!
#setwd("C:/Users/ai/Documents/Courses/Getting and cleaning data/Course project")

# download the archive
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip DataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

# Load raw data
features <- read.table("./data/UCI HAR Dataset/features.txt")
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

###############################################################################################
# STEP 1  Merge the training and test sets to create one data set
###############################################################################################

x_data <- rbind(x_train, x_test)

y_data <- rbind(y_train, y_test)

subject_data <- rbind(subject_train, subject_test)

rm(x_train, x_test,y_train, y_test,subject_train, subject_test)

###############################################################################################
# STEP 2  Extract only the measurements on the mean and standard deviation for each measurement
###############################################################################################

setnames(features, names(features), c("featureID", "featureName"))

mean_std_features <- grep("mean\\(\\)|std\\(\\)",features$featureName)

data_mean_std <- subset(x_data,select=mean_std_features) 
  
names(data_mean_std) <- features[mean_std_features, 2]

###############################################################################################
# STEP 3  Use descriptive activity names to name the activities in the data set
###############################################################################################

setnames(activity_labels, names(activity_labels), c("activityID", "activityName"))

setnames(y_data, names(y_data), c("activity"))

y_data[, 1] <- activity_labels[y_data[, 1], 2]

###############################################################################################
# STEP 4  Appropriately label the data set with descriptive variable names
###############################################################################################


setnames(subject_data, names(subject_data), c("subject"))

data_set <- cbind(subject_data, y_data, data_mean_std)

names(data_set)<-gsub('\\(|\\)',"",names(data_set))
names(data_set)<-gsub("^t", "time", names(data_set))
names(data_set)<-gsub("mean()", "Mean", names(data_set))
names(data_set)<-gsub("std()", "Standard", names(data_set))
names(data_set)<-gsub('\\.std',".Standard",names(data_set))
names(data_set)<-gsub("^f", "Frequency", names(data_set))
names(data_set)<-gsub('Freq\\.',"Frequency.",names(data_set))
names(data_set)<-gsub('Freq$',"Frequency",names(data_set))
names(data_set)<-gsub("Acc", "Accelerometer", names(data_set))
names(data_set)<-gsub("Gyro", "Gyroscope", names(data_set))
names(data_set)<-gsub("Mag", "Magnitude", names(data_set))
names(data_set)<-gsub("BodyBody", "Body", names(data_set))


###############################################################################################
# STEP 5  Create a second, independent tidy data set with the average of each variable
#                       for each activity and each subject
###############################################################################################

averages_data <-  ddply(data_set, c("subject","activity"), numcolwise(mean))

write.table(averages_data, "tidy.txt", row.names = FALSE, quote = FALSE)

### Remove ALL objects and clearing memory
#rm(list=ls()) 
