# Code book
The run_analysis.R script performs the data preparation and then followed by the 5 steps required for the Peer-graded Assignment: Getting and Cleaning Data Course Project

# Previous Steps: Obtaining the dataset

The data set was downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Previous Steps: Assigning each data to variables

features <- features.txt : 561 rows, 2 columns 
The features selected were: accelerometer and gyroscope 3-axial, raw signals, tAcc-XYZ, and tGyro-XYZ.
activities <- activity_labels.txt : 6 rows, 2 columns 
subject_test <- test/subject_test.txt : 2947 rows, 1 column 
X_test <- test/X_test.txt : 2947 rows, 561 columns 
y_test <- test/y_test.txt : 2947 rows, 1 columns 
subject_train <- test/subject_train.txt : 7352 rows, 1 column 
X_train <- test/X_train.txt : 7352 rows, 561 columns 
y_train <- test/y_train.txt : 7352 rows, 1 columns 

# Fist step: Merges the training and the test sets to create one data set.

By merging x_train and x_test using rbind() function, it is obtained for the X: 10299 rows, 561 columns
By merging y_train and y_test using rbind() function, it is obtained for the Y: 10299 rows, 1 column
By merging subject_train and subject_test using rbind() function, it is obtained the Subject: 10299 rows, 1 column
By Mmerging Subject, Y and X using cbind() function, it is obtained Merged_Data: 10299 rows, 563 column. 

# Second Step: Extracts only the measurements on the mean and standard deviation for each measurement.

TidyData (Tidy) is created by subsetting Merged_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement obtaining: 10299 rows, 88 columns.

# Third Step: Uses descriptive activity names to name the activities in the data set

Entire numbers in code column of the TidyData (Tidy) replaced with corresponding activity taken from second column of the activities variable
# Fourth Step: Appropriately labels the data set with descriptive variable names.
The activities are labeled into the following:
Acc = Accelerometer
Gyro = Gyroscope
BodyBody = Body
Mag = Magnitude
^t = Time
tBody = TimeBody
-mean = Mean
-std = std
-freq = frequency
angle = Angle
gravity = Gravity

#Fifth Step: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
FinalTidyDataset (180 rows, 88 columns) is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
Export FinalTidyDataset into FinalTidyDataset.txt file.