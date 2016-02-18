# Getting and Cleaning Data Course Project #

Repository for Getting and Cleaning Data Course Project. It contains following files: 

- run_analysis.R
- tidy.txt
- CodeBook.md
- README.md

## run_analysis.R ##

The script, run_analysis.R, does the following:

- Download and unzip data package.
- Merge the training and the test data using the rbind function.
- Extract the columns with the mean and standard deviation measures from the dataset and rename of columns in question.
- Replace the activity ID by the activity label on the activity dataset.
- Merge the subject, activity and mean and standard deviation measures datasets and rename the columns in order to give the  a descriptive names.
- generate a new tidy dataset with all the average measures for each subject and activity type. The output file tidy.txt is saved to the working directory.

## Dependencies and used directories  ##

run_analysis.R file will help you to install the dependencies automatically ("data.table","plyr","dplyr"). The script create the folder 'Data' on the R working directory and use it to download and unzip the project data. The final file 'tidy.txt' is generated directly to the working directory.
