# Code Book #
This is a code book that describes the variables, the data, and the transformations performed to clean up the data.

## The data source  ##

Original data: [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Transformation details ##
- Merge the training and the test data using the rbind function.
- Extract the columns with the mean and standard deviation measures from the dataset and rename of columns in question.
- Replace the activity ID by the activity label on the activity dataset.
- Merge the subject, activity and mean and standard deviation measures datasets and rename the columns in order to give the  a descriptive names.
- generate a new tidy dataset with all the average measures for each subject and activity type. The output file tidy.txt is saved to the working directory.


## Variables ##
- *features, activity\_labels, subject\_train, subject\_testx\_train, y\_train, x\_test, y\_test* - contain the data from the downloaded files.
- *subject\_data, x\_data, y\_data* -  merged  datasets (training data + test data).
- *data\_mean\_std* that contains only mean and standard deviation measures.
- *data\_set* contains merged data from  data\_mean\_std, y\_data and subject\_data.
- *averages\_data* - tidy dataset contains all the average measures for each subject and activity type.
